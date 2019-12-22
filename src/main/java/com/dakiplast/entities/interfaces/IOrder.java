package com.dakiplast.entities.interfaces;

import java.util.Calendar;
import java.util.List;

import com.dakiplast.enums.OrderStatus;

public interface IOrder {
	public Long getId();
	public Long getCreatedBy();
	public Calendar getCreatedAt();
	public Long getClientId();
	public List<Long> getWorkerIds();
	public Long getSaldo();
	public Long getPaid();
	public Calendar getBuildDate();
	public OrderStatus getStatus();
}
