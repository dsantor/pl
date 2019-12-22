package com.dakiplast.controllers.api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.dto.ClientDto;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.OrderService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.impl.SessionService;
import com.dakiplast.utils.Validation;

@RestController
@RequestMapping("/api/client")
public class ClientController {

	@Autowired
	private ClientService clientService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserActivityLogService userActivityLogService;
	@Autowired
	private OrderService orderService;
	
	@PostMapping("/save")
	public BaseResponse save(@RequestBody ClientRequest clientRequest, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		if (!Validation.isUserOrAdmin(user)) {
			return new BaseResponse(null, true, ErrorsEnum.PRIVILEGES_ERROR.getMessage());
		}
		IClient client = clientService.create(clientRequest, loggedUserId);
		userActivityLogService.create(loggedUserId, null, client.getId(), null, UserActivityLogType.CREATED_CLIENT);
		return new BaseResponse(client, false, null);
	}
	
	
	@GetMapping("/all")
	public BaseResponse all() {
		List<IClient> clients = clientService.getAll();
		List<ClientDto> clientsDto = new ArrayList<>(clients.size());
		
		clients.stream().forEach(client -> clientsDto.add(ClientDto.convertToDto(client)));
		
		List<IOrder> orders;
		for (ClientDto clientDto: clientsDto) {
			orders = orderService.getOrdersForClient(clientDto.getId());
			for (IOrder order: orders) {
				if (order.getPaid() < order.getSaldo()) {
					clientDto.setUnpaid(true);
					break;
				}
				clientDto.setUnpaid(false);
			}
		}
		
		return new BaseResponse(clientsDto, false, null);
	}
	
	@GetMapping("/id/{clientId}")
	public BaseResponse getClient(@PathVariable ("clientId") Long clientId) {
		IClient client = clientService.getClientById(clientId);
		return new BaseResponse(client, false, null);
	}
}
