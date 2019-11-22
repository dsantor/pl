package com.dakiplast.repository;

import java.util.List;

import com.dakiplast.entities.interfaces.IUserActivityLog;
import com.dakiplast.enums.UserActivityLogType;

public interface UserActivityLogRepository {

	IUserActivityLog createUserActivityLog(Long actionUserId, Long userId, Long clientId, UserActivityLogType type);
	
	List<IUserActivityLog> getAllActivitiesForUser(Long actionUserId);
	
	List<IUserActivityLog> getAllActivitiesExcludingUser(Long actionUserId);
}
