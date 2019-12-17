package com.dakiplast.entities;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.dakiplast.entities.interfaces.IUserActivityLog;
import com.dakiplast.enums.UserActivityLogType;

@Entity
@Table(name = "user_activity_log")
@NamedQueries({
		@NamedQuery(name = "UserActivityLog.getAllActivitiesForUser", query = "SELECT o FROM UserActivityLog o where o.actionUserId = :actionUserId ORDER BY o.time DESC"),
		@NamedQuery(name = "UserActivityLog.getAllActivitiesExcludingUser", query = "SELECT o FROM UserActivityLog o where o.actionUserId != :actionUserId ORDER BY o.time DESC")
		})
public class UserActivityLog implements Serializable, IUserActivityLog {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	@Column(name = "action_user_id")
	private Long actionUserId;
	
	@Column(name = "type")
	@Enumerated(EnumType.STRING)
	private UserActivityLogType type;
	
	@Column(name = "user_id")
	private Long userId;
	
	@Column(name = "client_id")
	private Long clientId;
	
	@Column(name = "worker_id")
	private Long workerId;
	
	@Column(name = "time")
	private Calendar time;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public UserActivityLogType getType() {
		return type;
	}

	public void setType(UserActivityLogType type) {
		this.type = type;
	}

	public Calendar getTime() {
		return time;
	}

	public void setTime(Calendar time) {
		this.time = time;
	}

	public Long getActionUserId() {
		return actionUserId;
	}

	public void setActionUserId(Long actionUserId) {
		this.actionUserId = actionUserId;
	}

	public Long getClientId() {
		return clientId;
	}

	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}

	public Long getWorkerId() {
		return workerId;
	}

	public void setWorkerId(Long workerId) {
		this.workerId = workerId;
	}
}
