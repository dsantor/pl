package com.dakiplast.entities.dto;

import java.util.List;
import java.util.Map;

public class ClientOrderDto {
	private Long id;
	private String firstName;
	private String lastName;
	private String street;
	private String city;
	private String buildNumber;
	private String email;
	private String phoneNumber;
	private Long createdBy;
	
	private Long orderId;
	private Long createdById;
	private String createdByName;
	private Long createdAtMillis;
	private List<Long> workerIds;
	private List<String> workerNames;
	private Long saldo;
	private Long paid;
	private String status;
	private Map<Long, String> workersMap;
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
	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public Long getCreatedById() {
		return createdById;
	}
	public void setCreatedById(Long createdById) {
		this.createdById = createdById;
	}
	public String getCreatedByName() {
		return createdByName;
	}
	public void setCreatedByName(String createdByName) {
		this.createdByName = createdByName;
	}
	public Long getCreatedAtMillis() {
		return createdAtMillis;
	}
	public void setCreatedAtMillis(Long createdAtMillis) {
		this.createdAtMillis = createdAtMillis;
	}
	public List<Long> getWorkerIds() {
		return workerIds;
	}
	public void setWorkerIds(List<Long> workerIds) {
		this.workerIds = workerIds;
	}
	public List<String> getWorkerNames() {
		return workerNames;
	}
	public void setWorkerNames(List<String> workerNames) {
		this.workerNames = workerNames;
	}
	public Long getSaldo() {
		return saldo;
	}
	public void setSaldo(Long saldo) {
		this.saldo = saldo;
	}
	public Long getPaid() {
		return paid;
	}
	public void setPaid(Long paid) {
		this.paid = paid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Map<Long, String> getWorkersMap() {
		return workersMap;
	}
	public void setWorkersMap(Map<Long, String> workersMap) {
		this.workersMap = workersMap;
	}
}
