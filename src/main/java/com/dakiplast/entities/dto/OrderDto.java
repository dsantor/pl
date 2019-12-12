package com.dakiplast.entities.dto;

import java.util.List;

import com.dakiplast.entities.interfaces.IOrder;

public class OrderDto {

	private Long id;
	private Long createdBy;
	private Long createdAtMillis;
	private Long clientId;
	private String clientName;
	private List<Long> workerIds;
	private List<String> workerNames;
	private Long saldo;
	private Long paid;
	private String status;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
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
	
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
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
	public static OrderDto convertToDto(IOrder order, String clientName, List<String> workerNames) {
		OrderDto orderDto = new OrderDto();
		orderDto.setId(order.getId());
		orderDto.setCreatedBy(order.getCreatedBy());
		orderDto.setCreatedAtMillis(order.getCreatedAt().getTimeInMillis());
		orderDto.setClientId(order.getClientId());
		orderDto.setClientName(clientName);
		orderDto.setWorkerIds(order.getWorkerIds());
		orderDto.setWorkerNames(workerNames);
		orderDto.setSaldo(order.getSaldo());
		orderDto.setPaid(order.getPaid());
		orderDto.setStatus(order.getStatus().getValue());
		return orderDto;
	}
}