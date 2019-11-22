package com.dakiplast.controllers.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.dto.UserActivityLogDto;
import com.dakiplast.responses.CustomResponse;
import com.dakiplast.services.UserActivityLogService;

@RestController
@RequestMapping("/api/userActivityLog")
public class UserActivityLogController {

	@Autowired
	UserActivityLogService userActivityLogService;
	
	@GetMapping("/getUserActivityLogForUser/{actionUserId}")
	public CustomResponse getUserActivityLogForUser(@PathVariable ("actionUserId") Long actionUserId) {
		
		if (actionUserId == null) {
			return new CustomResponse(null, true, "Bad request"); 
		}
		
		List<UserActivityLogDto> logs = userActivityLogService.getFullLoadedActivitiesForUser(actionUserId);
		
		return new CustomResponse(logs, false, null);
	}
}
