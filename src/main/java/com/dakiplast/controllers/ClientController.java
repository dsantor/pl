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

import com.dakiplast.entities.Client;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.responses.CustomResponse;
import com.dakiplast.services.ClientService;

@Controller
@RequestMapping("/client")
public class ClientController {

	@Autowired
	private ClientService clientService;
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("client", new Client());
		return "createClient.html";
	}
	
	@PostMapping("/save")
	public @ResponseBody CustomResponse save(@RequestBody ClientRequest clientRequest, Model model) {
		
		IClient client = clientService.create(clientRequest);
		return new CustomResponse(client, false, null);
	}
	
	
	@GetMapping("/all")
	public @ResponseBody CustomResponse all() {
		List<IClient> clients = clientService.getAll();
		return new CustomResponse(clients, false, null);
	}
	
	@GetMapping("/id/{clientId}")
	public @ResponseBody CustomResponse getClient(@PathVariable ("clientId") Long clientId) {
		IClient client = clientService.getClientById(clientId);
		return new CustomResponse(client, false, null);
	}
}
