package com.dakiplast.entities.dto;

import java.util.Calendar;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.enums.UserActivityLogType;

public class UserActivityLogDto {

	private UserDto actionUser;
	private UserDto user;
	private IClient client;
	private UserActivityLogType type; 
	private Calendar time;
	
	public UserDto getActionUser() {
		return actionUser;
	}
	public void setActionUser(UserDto actionUser) {
		this.actionUser = actionUser;
	}
	public UserDto getUser() {
		return user;
	}
	public void setUser(UserDto user) {
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
