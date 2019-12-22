package com.dakiplast.entities.interfaces;

public interface IWorker {
	public Long getId();
	public String getFirstName();
	public String getLastName();
	public String getStreet();
	public String getCity();
	public String getBuildNumber();
	public String getEmail();
	public String getPhoneNumber();	
	public String getCreatedBy();
	public Long getCreatedAt();
	public boolean isDeleted();
	public boolean isActive();
	public String getFullName();
}
