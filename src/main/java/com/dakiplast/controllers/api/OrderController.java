package com.dakiplast.controllers.api;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.dto.ClientDto;
import com.dakiplast.entities.dto.OrderDto;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.OrderRequest;
import com.dakiplast.requests.PayOrderRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.responses.OrderResponse;
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
		
		IOrder order = orderService.create(orderRequest, loggedUserId);
		userActivityLogService.create(loggedUserId, null, order.getClientId(), null, UserActivityLogType.CREATED_ORDER);
		return new BaseResponse(order, false, null);
	}
	
	@GetMapping("/getAll")
	public OrderResponse getAll(HttpServletRequest request) {
		List<IOrder> orders = orderService.getAll();
		List<OrderDto> ordersDto = new ArrayList<>(orders.size());
		
		for (IOrder order: orders) {
			ordersDto.add(orderService.convertToOrderDto(order));
		}
		
		List<IClient> clients = clientService.getAll();
		List<ClientDto> clientsDto = new ArrayList<>(clients.size());
		
		clients.stream().forEach(client -> clientsDto.add(ClientDto.convertToDto(client)));
		return new OrderResponse(false, null, ordersDto, clientsDto);
	}


	@GetMapping("/get/{orderId}")
	public BaseResponse getById(@PathVariable ("orderId") Long orderId) {
		IOrder order = orderService.getById(orderId);
		OrderDto orderDto = orderService.convertToOrderDto(order);
		return new BaseResponse(orderDto, false, null);
	}
	
	@GetMapping("/getAll/{clientId}")
	public OrderResponse getAllForClient(@PathVariable ("clientId") Long clientId) {
		
		IClient client = clientService.getClientById(clientId);
		if (client == null) {
			return new OrderResponse(true, "Klijent ne postoji", null, null);
		}
		
		List<IOrder> orders = orderService.getOrdersForClient(client.getId());
		List<OrderDto> ordersDto = new ArrayList<>(orders.size());
		Set<ClientDto> clients = new HashSet<>();
		for (IOrder order: orders) {
			ordersDto.add(orderService.convertToOrderDto(order));
			clients.add(ClientDto.convertToDto(clientService.getClientById(order.getClientId())));
		}
		
		List<ClientDto> clientsDto = new ArrayList<>(clients.size());
		clients.stream().forEach(clientDto -> clientsDto.add(clientDto));
		return new OrderResponse(false, null, ordersDto, clientsDto);
	}
	
	@PostMapping("/payOrder")
	public BaseResponse payOrder(@RequestBody PayOrderRequest payOrderRequest, HttpServletRequest request) {
		
		IOrder order = orderService.getById(payOrderRequest.getOrderId());
		if (order == null) {
			return new BaseResponse(null, true, "Porudžbina ne postoji");
		}
		
		Long paidAmount = payOrderRequest.getPaidAmount();
		if (paidAmount == null || paidAmount < 0) {
			return new BaseResponse(null, true, "Iznos uplate nije validan"); 
		}
		order = orderService.payOrder(payOrderRequest);
		return new BaseResponse(order.getPaid(), false, null);
	}
}