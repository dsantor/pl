package com.dakiplast.enums;

public enum UserActivityLogType {
	CREATED_USER("Kreiran korisnik"),
	RESET_PASSWORD("Restartovana šifra"),
	CREATED_CLIENT("Kreiran klijent"), 
	CREATED_ORDER("Kreirana porudžbina"), 
	BLOCK_USER("Blokiran korisnik"), 
	UNBLOCK_USER("Odblokiran korisnik"),
	CREATED_EXPENSE("Kreirana dažbina");
	
	private String value;
	private UserActivityLogType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}