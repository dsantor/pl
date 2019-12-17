package com.dakiplast.repositoryImpl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dakiplast.entities.UserActivityLog;
import com.dakiplast.entities.interfaces.IUserActivityLog;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.repository.UserActivityLogRepository;

@Repository
@Transactional
@SuppressWarnings("unchecked")
public class UserActivityLogRepositoryImpl implements UserActivityLogRepository {

	@Autowired
	private EntityManager entityManager;
	
	@Override
	public IUserActivityLog createUserActivityLog(Long actionUserId, Long userId, Long clientId,
			Long workerId, UserActivityLogType type) {
		
		UserActivityLog entity = new UserActivityLog();
		entity.setActionUserId(actionUserId);
		entity.setUserId(userId);
		entity.setClientId(clientId);
		entity.setWorkerId(workerId);
		entity.setType(type);
		entity.setTime(Calendar.getInstance());
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public List<IUserActivityLog> getAllActivitiesForUser(Long actionUserId) {
		Query query = entityManager.createNamedQuery("UserActivityLog.getAllActivitiesForUser");
		query.setParameter("actionUserId", actionUserId);
		
		List<IUserActivityLog> result = query.getResultList();
		
		return result == null ? new ArrayList<>() : result;
	}

	@Override
	public List<IUserActivityLog> getAllActivitiesExcludingUser(Long actionUserId) {
		Query query = entityManager.createNamedQuery("UserActivityLog.getAllActivitiesExcludingUser");
		query.setParameter("actionUserId", actionUserId);
		
		List<IUserActivityLog> result = query.getResultList();
		
		return result == null ? new ArrayList<>() : result;
	}

}
