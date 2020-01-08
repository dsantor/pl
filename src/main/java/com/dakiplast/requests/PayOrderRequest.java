package com.dakiplast.requests;

public class PayOrderRequest {

	private Long orderId;
	private Long paidAmount;

	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public Long getPaidAmount() {
		return paidAmount;
	}
	public void setPaidAmount(Long paidAmount) {
		this.paidAmount = paidAmount;
	}
}
