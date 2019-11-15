package com.dakiplast.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/templates")
public class TemplatesController {

	@GetMapping("/userProfile")
	public String userProfile() {
		return "userProfile.html";
	}
	
	
	@GetMapping("/createUser")
	public String create() {
		return "createUser.html";
	}
	
}
