package com.dakiplast.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.dto.UserActivityLogDto;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.entities.interfaces.IUserActivityLog;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.repository.UserActivityLogRepository;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;

@Service
public class UserActivityLogServiceImpl implements UserActivityLogService {

	@Autowired
	private UserActivityLogRepository userActivityLogRepository;
	@Autowired
	private UserService userService;
	@Autowired
	private ClientService clientService;
	
	@Override
	public IUserActivityLog create(Long actionUserId, Long userId, Long clientId, UserActivityLogType type) {
		return userActivityLogRepository.createUserActivityLog(actionUserId, userId, clientId, type);
	}
	@Override
	public List<IUserActivityLog> getAllActivitiesForUser(Long actionUserId) {
		return userActivityLogRepository.getAllActivitiesForUser(actionUserId);
	}
	@Override
	public List<IUserActivityLog> getAllActivitiesExcludingUser(Long actionUserId) {
		return userActivityLogRepository.getAllActivitiesExcludingUser(actionUserId);
	}
	@Override
	public List<UserActivityLogDto> getFullLoadedActivitiesForUser(Long actionUserId) {
		List<IUserActivityLog> actionLogs = userActivityLogRepository.getAllActivitiesForUser(actionUserId);
		
		List<UserActivityLogDto> actionLogsDto = new ArrayList<>();
		UserActivityLogDto actionLogDto;
		for (IUserActivityLog actionLog: actionLogs) {
			actionLogDto = ConvertToDto(actionLog);
			actionLogsDto.add(actionLogDto);
		}
		
		return actionLogsDto;
	}

	
	private UserActivityLogDto ConvertToDto(IUserActivityLog actionLog) {
		
		if (actionLog == null) {
			return null;
		}
		
		UserActivityLogDto actionLogDto = new UserActivityLogDto();
		
		IUser actionUser = userService.getById(actionLog.getActionUserId());
		Long userId = actionLog.getUserId();
		if (userId != null) {
			IUser user = userService.getById(userId);
			actionLogDto.setUser(user);
		}
		
		Long clientId = actionLog.getUserId();
		if (clientId != null) {
			IClient client = clientService.getClientById(clientId);
			actionLogDto.setClient(client);
		}
		
	
		
		actionLogDto.setActionUser(actionUser);
		
		
		actionLogDto.setType(actionLog.getType());
		actionLogDto.setTime(actionLog.getTime());
		
		return actionLogDto;
	}
}
