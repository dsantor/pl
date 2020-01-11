package com.dakiplast.entities;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.enums.OrderStatus;
import com.google.gson.Gson;

@Entity
@Table(name = "orders")
@NamedQueries({
	@NamedQuery(name = "Order.findAll", query = "SELECT o from Order o"),
	@NamedQuery(name = "Order.findOrdersByClientId", query = "SELECT o from Order o WHERE o.clientId = :clientId")
})
public class Order implements Serializable, IOrder {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_id")
	private Long id;
	
	@Column(name = "created_by")
	private Long createdBy;
	
	@Column(name = "created_at")
	private Calendar createdAt;
	
	@Column(name = "client_id")
	private Long clientId;

	@Column(name = "worker_ids")
	private String workerIds;
	
	@Column(name = "saldo")
	private Long saldo;
	
	@Column(name = "paid")
	private Long paid;
	
	@Column(name = "build_date")
	private Calendar buildDate;
	
	@Column(name = "status")
	@Enumerated(EnumType.STRING)
	private OrderStatus status;

	@Column(name = "note")
	private String note;
	
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

	public Calendar getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Calendar createdAt) {
		this.createdAt = createdAt;
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

	public OrderStatus getStatus() {
		return status;
	}

	public void setStatus(OrderStatus status) {
		this.status = status;
	}

	public String getWorkerIdsJson() {
		return workerIds;
	}

	public void setWorkerIdsJson(String workerIds) {
		this.workerIds = workerIds;
	}
	
	public Calendar getBuildDate() {
		return buildDate;
	}

	public void setBuildDate(Calendar buildDate) {
		this.buildDate = buildDate;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public List<Long> getWorkerIds() {
		Long[] listIds = new Gson().fromJson(this.workerIds, Long[].class);
		return Arrays.asList(listIds);
	}
}
