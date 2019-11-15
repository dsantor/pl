package com.dakiplast.responses;

public class CustomResponse {

	private Object data;
	private boolean error;
	private String message;

	public CustomResponse(Object data, boolean error, String message) {
		this.data = data;
		this.error = error;
		this.message = message;
	}
	
	public Object getData() {
		return data;
	}

	public boolean isError() {
		return error;
	}

	public String getMessage() {
		return message;
	}
}
