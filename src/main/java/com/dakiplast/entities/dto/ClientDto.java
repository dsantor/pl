package com.dakiplast.entities.dto;

import com.dakiplast.entities.interfaces.IClient;

public class ClientDto {
	private Long id;
	private String firstName;
	private String lastName;
	private String street;
	private String city;
	private String buildNumber;
	private String email;
	private String phoneNumber;
	private Long createdBy;
	private boolean unpaid;
	
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
	public Long getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}
	public boolean isUnpaid() {
		return unpaid;
	}
	public void setUnpaid(boolean unpaid) {
		this.unpaid = unpaid;
	}
	public static ClientDto convertToDto(IClient client) {
		ClientDto clientDto = new ClientDto();
		clientDto.setId(client.getId());
		clientDto.setFirstName(client.getFirstName());
		clientDto.setLastName(client.getLastName());
		clientDto.setStreet(client.getStreet());
		clientDto.setCity(client.getCity());
		clientDto.setBuildNumber(client.getBuildNumber());
		clientDto.setEmail(client.getEmail());
		clientDto.setPhoneNumber(client.getPhoneNumber());
		clientDto.setCreatedBy(client.getCreatedBy());
		return clientDto;
	}
}
