package com.dakiplast.controllers.secure;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.requests.UserRequest;
import com.dakiplast.services.UserService;

@Controller
@RequestMapping("/secure")
public class AdminController {

	private UserService userService;
	
	@Autowired
	public AdminController(UserService userService) {
		this.userService = userService;
	}
	
	@GetMapping({"", "/", "/register"}) 
	public String register(HttpServletRequest request) {
		return "register.html";
	}
	
	@PostMapping("/register") 
	public @ResponseBody IUser createUser(@RequestBody UserRequest userRequest, HttpServletRequest request) {
		
		String firstName   = userRequest.getFirstName();
		String lastName	   = userRequest.getLastName();
		String street 	   = userRequest.getStreet();
		String buildNumber = userRequest.getBuildNumber();
		String city 	   = userRequest.getCity();
		String phoneNumber = userRequest.getPhoneNumber();
		String email 	   = userRequest.getEmail();		
		String password    = userRequest.getPassword();
		
		IUser user = userService.create(firstName, lastName, email, phoneNumber, city, street, buildNumber, password);
		
		return user;
	}
}
