package com.dakiplast.enums;

public enum OrderStatus {
	WAITING("Na čekanju"), ACCEPTED("Prihvaćena"), DECLINED("Odbijena"), FINISHED("Završena");
	
	private String value;
	
	private OrderStatus(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
