package com.dakiplast.controllers;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dakiplast.entities.User;
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.services.UserService;
import com.dakiplast.services.impl.SessionService;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	

	@GetMapping({"", "/", "/login", "/login/{error}"})
	public String login(Model model, Authentication authentication, @RequestParam(value = "error", required = false) String error) {
		
		
		if (authentication != null && authentication.isAuthenticated()) {
			return "redirect:/homepage";
		}
//		if (error == null ) {
//			return "login.html";
//		} 
		model.addAttribute("localhost:8080", "host");
		return "login.html";
//		return "redirect:/j_spring_boot_logout"; 
	}
	
	@GetMapping("/homepage")
	public String homepage(Model model, Authentication authentication, HttpServletRequest request) {
		
		if (authentication != null && authentication.isAuthenticated()) {
			User user = userService.getByEmail(authentication.getName());
			
			if (user != null){
				
				SessionService.createSessionLoggedUserId(request, user.getId());
				
				model.addAttribute("isAdmin", user.getRole().equals(RolesEnum.ROLE_ADMIN));
				model.addAttribute("id", user.getId());
			}
			return "homepage.html";
		}
		
		return "redirect:/j_spring_boot_logout"; 
		
	}

	@GetMapping("/error-404")
	public String error(Model model, HttpServletRequest request) {
		return "errorPage.html";
	}
	

	
	@GetMapping("/logout")
	public String logout() {
		return "login.html";
	}
}
