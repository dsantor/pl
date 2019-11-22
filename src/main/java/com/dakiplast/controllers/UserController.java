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

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.requests.UserRequest;
import com.dakiplast.responses.CustomResponse;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.impl.SessionService;
import com.dakiplast.utils.Validation;

@Controller
@RequestMapping("/api/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private UserActivityLogService userActivityLogService; 
	
	@GetMapping("/{id}")
	public @ResponseBody IUser getUser(@PathVariable ("id") Long id) {
		
		IUser user = userService.getById(id);
		
		return user;
		
	}
	
	@GetMapping("/all")
	public @ResponseBody List<User> getUsers(HttpServletRequest request) {
		Long userId = SessionService.getLoggedUserId(request);
		List<User> users = userService.getUsersExcludeUser(userId);
		return users;
	}
	
	
	@PostMapping("/update")
	public @ResponseBody CustomResponse update(@RequestBody UserRequest user, HttpServletRequest request) {
		
		Long userId = SessionService.getLoggedUserId(request);
		
		try {
			boolean updated = userService.update(userId, user);
			return new CustomResponse(updated, false, "Uspesno sacuvane izmene.");

		}catch (Exception e) {
			return new CustomResponse(false, true, e.getMessage());
		}
	}
	
	@PostMapping("/save")
	public @ResponseBody CustomResponse save(@RequestBody UserRequest user, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser loggedUser = userService.getById(loggedUserId);
		
		if (!Validation.isAdmin(loggedUser)) {
			return new CustomResponse(null, true, "Privilege error!");
		}
		
		String firstName   = user.getFirstName();
		String lastName	   = user.getLastName();
		String email 	   = user.getEmail();
		String phoneNumber = user.getPhoneNumber();
		String city	 	   = user.getCity();
		String street 	   = user.getStreet();
		String buildNumber = user.getBuildNumber();
		String password    = user.getPassword();
		
		try {
			User createdUser = userService.getByEmail(email);
			
			if (createdUser != null) {
				return new CustomResponse(null, true, "Korisnik sa " + email + " vec postoji.");
			}
			
			createdUser = userService.create(loggedUserId, firstName, lastName, email, phoneNumber, city, street, buildNumber, password);
			
			// Save activity
			if (createdUser != null) {
				userActivityLogService.create(loggedUserId, createdUser.getId(), null, UserActivityLogType.CREATED_USER);
			}
			
			return new CustomResponse(createdUser, false, "Uspesno sacuvane izmene.");

		}catch (Exception e) {
			return new CustomResponse(null, true, "Error while creating user!");
		}
	}

	@GetMapping("/remove/{userId}")
	public @ResponseBody CustomResponse remove(@PathVariable ("userId") Long userId, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		boolean deleted = false;
		
		if (RolesEnum.ROLE_ADMIN.equals(user.getRole())) {
			deleted = userService.delete(userId);			
		}
		
		if (deleted) {
			return new CustomResponse(userId, false, null);
		}
		return new CustomResponse(null, true, "Privilege error!");
	}
}
