package com.dakiplast.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.impl.SessionService;
import com.dakiplast.utils.Validation;

@Controller
@RequestMapping("/api/client")
public class ClientController {

	@Autowired
	private ClientService clientService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserActivityLogService userActivityLogService;
	
	@PostMapping("/save")
	public @ResponseBody BaseResponse save(@RequestBody ClientRequest clientRequest, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		if (!Validation.isUserOrAdmin(user)) {
			return new BaseResponse(null, true, ErrorsEnum.PRIVILEGES_ERROR.getMessage());
		}
		IClient client = clientService.create(clientRequest, loggedUserId);
		userActivityLogService.create(loggedUserId, null, client.getId(), UserActivityLogType.CREATED_CLIENT);
		return new BaseResponse(client, false, null);
	}
	
	
	@GetMapping("/all")
	public @ResponseBody BaseResponse all() {
		List<IClient> clients = clientService.getAll();
		return new BaseResponse(clients, false, null);
	}
	
	@GetMapping("/id/{clientId}")
	public @ResponseBody BaseResponse getClient(@PathVariable ("clientId") Long clientId) {
		IClient client = clientService.getClientById(clientId);
		return new BaseResponse(client, false, null);
	}
}
