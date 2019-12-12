package com.dakiplast.entities.dto;

import java.util.ArrayList;
import java.util.List;

public class OrdersDto {

	private List<OrderDto> orders;

	public OrdersDto() {
		this.orders = new ArrayList<>();
	}

	public List<OrderDto> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderDto> orders) {
		this.orders = orders;
	}
}
