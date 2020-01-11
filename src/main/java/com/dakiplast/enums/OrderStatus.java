package com.dakiplast.enums;

public enum OrderStatus {
	WAITING("WAITING", "Na čekanju"), ACCEPTED("ACCEPTED", "Prihvaćena"), DECLINED("DECLINED", "Odbijena"), FINISHED("FINISHED", "Završena");
	
	private String value;
	private String text;
	
	private OrderStatus(String value, String text) {
		this.value = value;
		this.text = text;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public String getText() {
		return this.text;
	}
}
