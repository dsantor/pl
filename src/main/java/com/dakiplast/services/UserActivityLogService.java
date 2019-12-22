package com.dakiplast.services;

import java.util.List;

import com.dakiplast.entities.dto.UserActivityLogDto;
import com.dakiplast.entities.interfaces.IUserActivityLog;
import com.dakiplast.enums.UserActivityLogType;

public interface UserActivityLogService {

	public IUserActivityLog create(Long actionUserId, Long userId, Long clientId, Long workerId, UserActivityLogType type);
	
	public List<IUserActivityLog> getAllActivitiesForUser(Long actionUserId);
	
	public List<IUserActivityLog> getAllActivitiesExcludingUser(Long actionUserId);
	
	public List<UserActivityLogDto> getFullLoadedActivitiesForUser(Long actionUserId);

	public void setDefaultPassword(Long loggedUserId, Long userId);

	public void unblockUser(Long loggedUserId, Long userId);

	public void blockUser(Long loggedUserId, Long userId);
	
	public void unblockWorker(Long loggedUserId, Long workerId);

	public void blockWorker(Long loggedUserId, Long workerId);
}