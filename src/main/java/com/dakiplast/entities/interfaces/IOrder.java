package com.dakiplast.entities.interfaces;

import java.util.Calendar;

import com.dakiplast.enums.OrderStatus;

public interface IOrder {
	public Long getId();
	public Long getCreatedBy();
	public Calendar getCreatedAt();
	public Long getClientId();
	public Long getWorkerId();
	public Long getSaldo();
	public Long getPaid();
	public OrderStatus getStatus();
}
