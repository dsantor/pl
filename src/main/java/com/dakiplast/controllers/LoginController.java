package com.dakiplast.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dakiplast.entities.User;
import com.dakiplast.entities.dto.UserDto;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.services.UserService;
import com.dakiplast.services.impl.SessionService;
import com.google.gson.Gson;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	

	@GetMapping({"", "/", "/login", "/login/{error}"})
	public String login(HttpServletRequest request, Authentication authentication, 
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			@RequestParam(value = "expired", required = false) String expired,
			@RequestParam(value = "invalid", required = false) String invalid,
			@RequestParam(value = "autherror", required = false) String autherror,
			HttpServletResponse response) throws IOException {
		
		
		if (authentication != null && authentication.isAuthenticated()) {
			return "redirect:/pages/secure";
		}
		
//		Long id = SessionService.getLoggedUserId(request);
//		if (id == null) {
//			response.sendError( HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized" );
//		}
		if (error != null || logout != null || expired != null || invalid != null || autherror != null ) {
//			response.sendError( HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized" );
//			request.getSession(true).invalidate();
//			response.sendRedirect("/login?error");
			request.setAttribute("error", true);
			return "login.html";
//			return null;
		} 
		
//		request.getSession().invalidate();
//		authentication.setAuthenticated(false);
		//model.addAttribute("localhost:8080", "host");
//		return "login.html";
//		return "redirect:/logout";
		return "login.html"; 
//		return "errorPage.html";
	}
	
	@GetMapping("/pages/secure")
	public String homepage(Model model, Authentication authentication, HttpServletRequest request) {
		
		if (authentication != null && authentication.isAuthenticated()) {
			User user = userService.getByEmail(authentication.getName());
			
			if (user != null){
				
				SessionService.createSessionLoggedUserId(request, user.getId());
				
				model.addAttribute("isAdmin", user.getRole().equals(RolesEnum.ROLE_ADMIN));
				model.addAttribute("id", user.getId());
			}
		
		}
		
		return "pages/secure/homepage.html";
		
	}

	@GetMapping("/error-404")
	public String error(Model model, HttpServletRequest request) {
		return "errorPage.html";
	}

	@GetMapping("/loginFailed")
	public String loginView(RedirectAttributes attributes) {
		
		return "redirect:/login?error";
	}
//	@GetMapping("/logout")
//	public String logout() {
//		return "login.html";
//	}
	
	@GetMapping("/logout")
	public void ss(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException {
		request.getSession(true).invalidate();
		RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
		auth.setAuthenticated(false);
		redirectStrategy.sendRedirect(request, response, "/login?timeout");
	}
	
	
	@GetMapping("/pages/userInfo.js")
	public void js (HttpServletRequest request, HttpServletResponse response) throws IOException {
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		UserDto userDto = new UserDto();
		userDto.mapToUserDto(user);
		Gson gson = new Gson();
		
		response.setHeader( "Content-Type", "text/javascript;charset=UTF-8" );
		response.getWriter().print("window.loggerUserInfo="+gson.toJson(userDto)+";\n");
	}
}
