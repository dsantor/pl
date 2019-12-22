package com.dakiplast.services;

import java.util.List;

import com.dakiplast.entities.dto.OrderDto;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.requests.OrderRequest;

public interface OrderService {

	public IOrder create(OrderRequest orderRequest, Long createdBy);
	public IOrder getById(Long orderId);
	public List<IOrder> getAll();
	public IOrder setAccepted(Long orderId);
	public IOrder setDeclined(Long orderId);
	public IOrder setFinished(Long orderId);
	public List<IOrder> getOrdersForClient(Long clientId);
	public OrderDto convertToOrderDto(IOrder order);
}
