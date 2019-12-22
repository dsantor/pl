package com.dakiplast.entities.dto;

import java.util.List;
import java.util.Map;

public class OrderDto {

	private Long id;
	private Long createdById;
	private String createdByName;
	private Long createdAtMillis;
	private Long buildDateMillis;
	private Long clientId;
	private String clientFullName;
	private String clientFirstName;
	private String clientLastName;
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
	public Long getClientId() {
		return clientId;
	}
	public void setClientId(Long clientId) {
		this.clientId = clientId;
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
	public Long getCreatedById() {
		return createdById;
	}
	public void setCreatedById(Long createdById) {
		this.createdById = createdById;
	}
	public Map<Long, String> getWorkersMap() {
		return workersMap;
	}
	public void setWorkersMap(Map<Long, String> workersMap) {
		this.workersMap = workersMap;
	}
	public String getCreatedByName() {
		return createdByName;
	}
	public void setCreatedByName(String createdByName) {
		this.createdByName = createdByName;
	}
	public String getClientFullName() {
		return clientFullName;
	}
	public void setClientFullName(String clientFullName) {
		this.clientFullName = clientFullName;
	}
	public String getClientFirstName() {
		return clientFirstName;
	}
	public void setClientFirstName(String clientFirstName) {
		this.clientFirstName = clientFirstName;
	}
	public String getClientLastName() {
		return clientLastName;
	}
	public void setClientLastName(String clientLastName) {
		this.clientLastName = clientLastName;
	}
	public Long getBuildDateMillis() {
		return buildDateMillis;
	}
	public void setBuildDateMillis(Long buildDateMillis) {
		this.buildDateMillis = buildDateMillis;
	}
}