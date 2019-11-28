package com.dakiplast.controllers;

import java.util.ArrayList;
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
import com.dakiplast.entities.dto.UserDto;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.requests.UserRequest;
import com.dakiplast.responses.BaseResponse;
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
	public @ResponseBody BaseResponse getUser(@PathVariable ("id") Long id) {
		
		IUser user = userService.getById(id);
		if (user != null) {
			UserDto userDto = new UserDto();
			userDto.mapToUserDto(user);
			
			return new BaseResponse(userDto, false, null);
		}
		
		return new BaseResponse(null, true, "Korisnik ne postoji");
		
	}
	
	@GetMapping("/all")
	public @ResponseBody BaseResponse getUsers(HttpServletRequest request) {
		Long userId = SessionService.getLoggedUserId(request);
		List<User> users = userService.getUsersExcludeUser(userId);
		
		List<UserDto> response = new ArrayList<UserDto>();
		UserDto userDto;
		for (User user: users) {
			userDto = new UserDto();
			userDto.mapToUserDto(user);
			response.add(userDto);
		}
		return new BaseResponse(response, false, null);
	}
	
	
	@PostMapping("/update")
	public @ResponseBody BaseResponse update(@RequestBody UserRequest user, HttpServletRequest request) {
		
		Long userId = SessionService.getLoggedUserId(request);
		
		try {
			boolean updated = userService.update(userId, user);
			return new BaseResponse(updated, false, "Uspešno sačuvane izmene.");

		}catch (Exception e) {
			return new BaseResponse(false, true, e.getMessage());
		}
	}
	
	@PostMapping("/save")
	public @ResponseBody BaseResponse save(@RequestBody UserRequest user, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser loggedUser = userService.getById(loggedUserId);
		
		if (!Validation.isAdmin(loggedUser)) {
			return new BaseResponse(null, true, "Nemate privilegije za ovu akciju!");
		}
		
		String firstName   = user.getFirstName();
		String lastName	   = user.getLastName();
		String email 	   = user.getEmail();
		String phoneNumber = user.getPhoneNumber();
		String city	 	   = user.getCity();
		String street 	   = user.getStreet();
		String buildNumber = user.getBuildNumber();
		
		try {
			IUser createdUser = userService.getByEmail(email);
			
			if (createdUser != null) {
				return new BaseResponse(null, true, "Korisnik sa " + email + " već postoji.");
			}
			
			createdUser = userService.create(loggedUserId, firstName, lastName, email, phoneNumber, city, street, buildNumber);
			
			// Save activity
			if (createdUser != null) {
				userActivityLogService.create(loggedUserId, createdUser.getId(), null, UserActivityLogType.CREATED_USER);
			}
			
			return new BaseResponse(createdUser, false, "Uspešno sačuvane izmene.");

		}catch (Exception e) {
			return new BaseResponse(null, true, "Error tokom kreiranja korisnika!");
		}
	}

	@GetMapping("/remove/{userId}")
	public @ResponseBody BaseResponse remove(@PathVariable ("userId") Long userId, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		boolean deleted = false;
		
		if (RolesEnum.ROLE_ADMIN.equals(user.getRole())) {
			deleted = userService.delete(userId);			
		}
		
		if (deleted) {
			return new BaseResponse(userId, false, null);
		}
		return new BaseResponse(null, true, "Nemate privilegije za ovu akciju!");
	}
	
	@GetMapping("/defaultPassword/{userId}")
	public @ResponseBody BaseResponse defaultPassword(@PathVariable ("userId") Long userId, HttpServletRequest request) {
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		boolean resetPassword = false;
		if (RolesEnum.ROLE_ADMIN.equals(user.getRole())) {
			resetPassword = userService.setDefaultPassword(userId);			
		} else {
			return new BaseResponse(null, true, "Nemate privilegije za ovu akciju!");
		}
		
		if (resetPassword) {
			return new BaseResponse(null, false, "Uspešno restartovana šifra");
		}
		return new BaseResponse(null, true, "Šifra nije uspesno restartovana");
	}

	@GetMapping("/toggleBlockUser/{userId}")
	public @ResponseBody BaseResponse toggleBlockUser(@PathVariable ("userId") Long userId, HttpServletRequest request) {
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		boolean blocked = false;
		if (RolesEnum.ROLE_ADMIN.equals(user.getRole())) {
			blocked = userService.toggleBlockUser(userId);			
		} else {
			return new BaseResponse(null, true, "Nemate privilegije za ovu akciju!");
		}
		
		if (blocked) {
			IUser blockedUser = userService.getById(userId);
			String blockText = blockedUser.isActive() ? "odblokiran" : "blokiran";
			return new BaseResponse(null, false, "Uspešno " + blockText + " korisnik");
		}
		return new BaseResponse(null, true, "Akcija nije uspešno izvršena");
	}
}
