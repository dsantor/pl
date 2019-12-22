package com.dakiplast.entities.dto;

import com.dakiplast.entities.interfaces.IWorker;

public class WorkerDto {
	private  Long Id;
	private  String firstName;
	private  String lastName;
	private  String street;
	private  String city;
	private  String buildNumber;
	private  String email;
	private  String phoneNumber;	
	private  String createdBy;
	private  Long createdAt;
	private  boolean deleted;
	private  boolean active;
	private  String fullName;
	
	private WorkerDto() {}
	
	public Long getId() {
		return Id;
	}
	public void setId(Long id) {
		Id = id;
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
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Long getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Long createdAt) {
		this.createdAt = createdAt;
	}

	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	
	public static WorkerDto convertToDto(IWorker worker) {
		WorkerDto workerDto = new WorkerDto();
		workerDto.setBuildNumber(worker.getBuildNumber());
		workerDto.setCity(worker.getCity());
		workerDto.setCreatedAt(worker.getCreatedAt());
		workerDto.setCreatedBy(worker.getCreatedBy());
		workerDto.setDeleted(worker.isDeleted());
		workerDto.setEmail(worker.getEmail());
		workerDto.setFirstName(worker.getFirstName());
		workerDto.setFullName(worker.getFullName());
		workerDto.setId(worker.getId());
		workerDto.setLastName(worker.getLastName());
		workerDto.setPhoneNumber(worker.getPhoneNumber());
		workerDto.setStreet(worker.getStreet());
		workerDto.setActive(worker.isActive());
		return workerDto;
	}
}
