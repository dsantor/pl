package com.dakiplast.requests;

import java.util.List;

import com.dakiplast.enums.OrderInformationTypes;

public class OrderTypeRequest {

	private OrderInformationTypes type;
	private List<String> options;

	public OrderInformationTypes getType() {
		return type;
	}
	public void setType(OrderInformationTypes type) {
		this.type = type;
	}
	public List<String> getOptions() {
		return options;
	}
	public void setOptions(List<String> options) {
		this.options = options;
	}
}
