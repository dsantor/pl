package com.dakiplast.responses;

import java.util.List;

import com.dakiplast.entities.dto.ClientDto;
import com.dakiplast.entities.dto.OrderDto;

public class OrderResponse extends Response {

	private List<OrderDto> orders;
	private List<ClientDto> clients;
	private boolean error;
	private String message;
	
	public OrderResponse(boolean error, String message, List<OrderDto> orders, List<ClientDto> clients) {
		super(error, message);
		this.orders = orders;
		this.clients = clients;
		this.error = error;
		this.message = message;
	}
	
	public List<OrderDto> getOrders() {
		return orders;
	}
	public void setOrders(List<OrderDto> orders) {
		this.orders = orders;
	}
	public List<ClientDto> getClients() {
		return clients;
	}
	public void setClients(List<ClientDto> clients) {
		this.clients = clients;
	}
	public boolean isError() {
		return error;
	}
	public void setError(boolean error) {
		this.error = error;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
