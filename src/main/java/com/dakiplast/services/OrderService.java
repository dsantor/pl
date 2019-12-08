package com.dakiplast.services;

import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.requests.OrderRequest;

public interface OrderService {

	public IOrder create(OrderRequest orderRequest, Long createdBy);
	public IOrder getById(Long orderId);
	public IOrder getAll();
	public IOrder setAccepted(Long orderId);
	public IOrder setDeclined(Long orderId);
	public IOrder setFinished(Long orderId);
}
