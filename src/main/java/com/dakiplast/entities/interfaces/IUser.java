package com.dakiplast.entities.interfaces;

import com.dakiplast.enums.RolesEnum;

public interface IUser {
	
	public Long getId();
	public String getFirstName();
	public String getLastName();
	public String getStreet();
	public String getCity();
	public String getBuildNumber();
	public String getEmail();
	public String getPhoneNumber();
	public RolesEnum getRole();
	public boolean isActive();
}
