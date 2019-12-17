package com.dakiplast.requests;

public class ExpenseRequest {
	private Long moneyGivenBy;
	private Long moneyTook;
	private String purpose;
	private Long moneyGivenAt;
	private Long sum;

	public Long getMoneyGivenBy() {
		return moneyGivenBy;
	}
	public void setMoneyGivenBy(Long moneyGivenBy) {
		this.moneyGivenBy = moneyGivenBy;
	}
	public Long getMoneyTook() {
		return moneyTook;
	}
	public void setMoneyTook(Long moneyTook) {
		this.moneyTook = moneyTook;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public Long getMoneyGivenAt() {
		return moneyGivenAt;
	}
	public void setMoneyGivenAt(Long moneyGivenAt) {
		this.moneyGivenAt = moneyGivenAt;
	}
	public Long getSum() {
		return sum;
	}
	public void setSum(Long sum) {
		this.sum = sum;
	}
}
