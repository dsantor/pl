package com.dakiplast.exceptions;

public enum ErrorsEnum {
	INTERNAL_ERROR("Internal error"), PRIVILEGES_ERROR("Nemate privilegije za ovu akciju!"), WORKER_NOT_FOUND("Radnik nije pronadjen!");
	
	private String message;
	
	private ErrorsEnum(String message) {
		this.message = message;
	}
	
	public String getMessage() {
		return this.message;
	}
}
