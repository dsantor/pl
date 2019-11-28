package com.dakiplast.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.ClientService;

@Controller
@RequestMapping("/api/client")
public class ClientController {

	@Autowired
	private ClientService clientService;
	
	@PostMapping("/save")
	public @ResponseBody BaseResponse save(@RequestBody ClientRequest clientRequest, Model model) {
		
		IClient client = clientService.create(clientRequest);
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
