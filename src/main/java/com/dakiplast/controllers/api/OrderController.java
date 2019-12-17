package com.dakiplast.controllers.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.dto.OrderDto;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.OrderRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.OrderService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.WorkerService;
import com.dakiplast.services.impl.SessionService;
import com.dakiplast.utils.Validation;

@RestController
@RequestMapping("/api/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private WorkerService workerService;
	@Autowired
	private UserActivityLogService userActivityLogService;
	
	@PostMapping("/create")
	public BaseResponse create(@RequestBody OrderRequest orderRequest, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		if (!Validation.isUserOrAdmin(user)) {
			return new BaseResponse(null, false, ErrorsEnum.PRIVILEGES_ERROR.getMessage());
		}
		
		if (orderRequest.getClientId() == null) {
			IClient client = clientService.create(orderRequest.getCreateClient(), loggedUserId);
			orderRequest.setClientId(client.getId());
		}
		
		IOrder order = orderService.create(orderRequest, loggedUserId);
		userActivityLogService.create(loggedUserId, null, order.getClientId(), null, UserActivityLogType.CREATED_ORDER);
		return new BaseResponse(order, false, null);
	}
	
	@GetMapping("/getAll")
	public BaseResponse getAll(HttpServletRequest request) {
		List<IOrder> orders = orderService.getAll();
		IWorker worker;
		IClient client;
		String clientName;
		List<OrderDto> ordersDto = new ArrayList<>();
		List<String> workerNames = new ArrayList<>();
		Map<Long, String> workersMap = new HashMap<>();
		for (IOrder order: orders) {
			for(Long workerId: order.getWorkerIds()) {
				worker = workerService.getById(workerId);
				workersMap.put(workerId, worker.getFirstName() + " " + worker.getLastName());
				workerNames.add(worker.getFirstName() + " " + worker.getLastName());
			}
			
			IUser user = userService.getById(order.getCreatedBy());
			client = clientService.getClientById(order.getClientId());
			clientName = client.getFirstName() + " " + client.getLastName();
			ordersDto.add(OrderDto.convertToDto(order, user.getFullName(), clientName, workerNames, workersMap));
		}
		return new BaseResponse(ordersDto, false, null);
	}


	@GetMapping("/get/{orderId}")
	public BaseResponse getById(@PathVariable ("orderId") Long orderId) {
		IOrder order = orderService.getById(orderId);
		IWorker worker;
		List<String> workerNames = new ArrayList<>();
		Map<Long, String> workersMap = new HashMap<>();
		
		for(Long workerId: order.getWorkerIds()) {
			worker = workerService.getById(workerId);
			workersMap.put(workerId, worker.getFirstName() + " " + worker.getLastName());
			workerNames.add(worker.getFirstName() + " " + worker.getLastName());
		}
	
		IClient client = clientService.getClientById(order.getClientId());
		IUser user = userService.getById(order.getCreatedBy());
		String clientName = client.getFirstName() + " " + client.getLastName();
		OrderDto orderDto = OrderDto.convertToDto(order,user.getFullName(), clientName, workerNames, workersMap);
		return new BaseResponse(orderDto, false, null);
	}
}