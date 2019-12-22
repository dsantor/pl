package com.dakiplast.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.dto.UserActivityLogDto;
import com.dakiplast.entities.dto.UserDto;
import com.dakiplast.entities.dto.WorkerDto;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.entities.interfaces.IUserActivityLog;
import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.repository.UserActivityLogRepository;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.WorkerService;

@Service
public class UserActivityLogServiceImpl implements UserActivityLogService {

	@Autowired
	private UserActivityLogRepository userActivityLogRepository;
	@Autowired
	private UserService userService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private WorkerService workerService;
	
	@Override
	public IUserActivityLog create(Long actionUserId, Long userId, Long clientId, Long workerId, UserActivityLogType type) {
		return userActivityLogRepository.createUserActivityLog(actionUserId, userId, clientId, workerId, type);
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

			UserDto userDto = new UserDto();
			userDto.mapToUserDto(user);
			
			actionLogDto.setUser(userDto);
		}
		
		Long clientId = actionLog.getClientId();
		if (clientId != null) {
			IClient client = clientService.getClientById(clientId);
			actionLogDto.setClient(client);
		}
		
		Long workerId = actionLog.getWorkerId();
		if (workerId != null) {
			IWorker worker = workerService.getById(workerId);
			WorkerDto workerDto = WorkerDto.convertToDto(worker);
			actionLogDto.setWorker(workerDto);
		}
		
		UserDto actionUserDto = new UserDto();
		actionUserDto.mapToUserDto(actionUser);
		actionLogDto.setActionUser(actionUserDto);
		
		actionLogDto.setType(actionLog.getType().getValue());
		actionLogDto.setTime(actionLog.getTime());

		return actionLogDto;
	}
	@Override
	public void setDefaultPassword(Long loggedUserId, Long userId) {
		userActivityLogRepository.createUserActivityLog(loggedUserId, userId, null, null, UserActivityLogType.RESET_PASSWORD);
	}
	@Override
	public void unblockUser(Long loggedUserId, Long userId) {
		userActivityLogRepository.createUserActivityLog(loggedUserId, userId, null, null, UserActivityLogType.UNBLOCK_USER);
	}
	@Override
	public void blockUser(Long loggedUserId, Long userId) {
		userActivityLogRepository.createUserActivityLog(loggedUserId, userId, null, null, UserActivityLogType.BLOCK_USER);
	}
	
	@Override
	public void unblockWorker(Long loggedUserId, Long workerId) {
		userActivityLogRepository.createUserActivityLog(loggedUserId, null, null, workerId, UserActivityLogType.UNBLOCK_WORKER);
	}
	@Override
	public void blockWorker(Long loggedUserId, Long workerId) {
		userActivityLogRepository.createUserActivityLog(loggedUserId, null, null, workerId, UserActivityLogType.BLOCK_WORKER);
	}
	
}
