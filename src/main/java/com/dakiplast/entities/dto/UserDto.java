package com.dakiplast.entities.dto;

import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;

public class UserDto {
	
	private Long id;
	private String firstName;
	private String lastName;
	private String street;
	private String city;
	private String buildNumber;
	private String email;
	private String phoneNumber;
	private boolean isAdmin;
	
	public void mapToUserDto(IUser user) {
		this.id = user.getId();
		this.firstName = user.getFirstName();
		this.lastName = user.getLastName();
		this.street = user.getStreet();
		this.city = user.getCity();
		this.buildNumber = user.getBuildNumber();
		this.email = user.getEmail();
		this.phoneNumber = user.getPhoneNumber();
		this.isAdmin = RolesEnum.ROLE_ADMIN.equals(user.getRole());
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getBuildNumber() {
		return buildNumber;
	}
	public void setBuildNumber(String buildNumber) {
		this.buildNumber = buildNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public boolean isAdmin() {
		return isAdmin;
	}
	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
}
