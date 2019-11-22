package com.dakiplast.entities.dto;

import java.util.Calendar;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.UserActivityLogType;

public class UserActivityLogDto {

	private IUser actionUser;
	private IUser user;
	private IClient client;
	private UserActivityLogType type; 
	private Calendar time;
	
	public IUser getActionUser() {
		return actionUser;
	}
	public void setActionUser(IUser actionUser) {
		this.actionUser = actionUser;
	}
	public IUser getUser() {
		return user;
	}
	public void setUser(IUser user) {
		this.user = user;
	}
	public IClient getClient() {
		return client;
	}
	public void setClient(IClient client) {
		this.client = client;
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
}
