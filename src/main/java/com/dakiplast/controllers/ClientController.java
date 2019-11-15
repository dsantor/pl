package com.dakiplast.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dakiplast.entities.Client;

@Controller
@RequestMapping("//client")
public class ClientController {

	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("client", new Client());
		return "createClient.html";
	}
	
	@PostMapping("/save")
	public String save(@ModelAttribute Client client, Model model) {
		model.addAttribute("client", client);
		return "showClient.html";
	}
	
	
	@GetMapping("/all")
	public String all() {
		return null;
	}
}
