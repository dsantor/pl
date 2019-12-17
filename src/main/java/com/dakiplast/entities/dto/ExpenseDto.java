package com.dakiplast.entities.dto;

import com.dakiplast.entities.interfaces.IExpense;

public class ExpenseDto {
	private String moneyGivenByFullName;
	private Long moneyGivenBy;
	private String moneyTookFullName;
	private Long moneyTook;
	private String purpose;
	private Long moneyGivenAt;
	private Long expenseCreatedAt;
	private String expenseCreatedByFullName;
	private Long expenseCreatedBy;
	private Long sum;
	
	private ExpenseDto() {}

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

	public Long getExpenseCreatedAt() {
		return expenseCreatedAt;
	}

	public void setExpenseCreatedAt(Long expenseCreatedAt) {
		this.expenseCreatedAt = expenseCreatedAt;
	}

	public Long getExpenseCreatedBy() {
		return expenseCreatedBy;
	}

	public void setExpenseCreatedBy(Long expenseCreatedBy) {
		this.expenseCreatedBy = expenseCreatedBy;
	}

	public Long getSum() {
		return sum;
	}

	public void setSum(Long sum) {
		this.sum = sum;
	}
	
	public String getMoneyGivenByFullName() {
		return moneyGivenByFullName;
	}

	public void setMoneyGivenByFullName(String moneyGivenByFullName) {
		this.moneyGivenByFullName = moneyGivenByFullName;
	}

	public String getMoneyTookFullName() {
		return moneyTookFullName;
	}

	public void setMoneyTookFullName(String moneyTookFullName) {
		this.moneyTookFullName = moneyTookFullName;
	}

	public String getExpenseCreatedByFullName() {
		return expenseCreatedByFullName;
	}

	public void setExpenseCreatedByFullName(String expenseCreatedByFullName) {
		this.expenseCreatedByFullName = expenseCreatedByFullName;
	}

	public static ExpenseDto ConvertToDto(IExpense expense, String moneyGivenByFullName, String moneyTookFullName, String expenseCreatedByFullName) {
		ExpenseDto expenseDto = new ExpenseDto();
		expenseDto.setMoneyGivenBy(expense.getMoneyGivenBy());
		expenseDto.setMoneyGivenByFullName(moneyGivenByFullName);
		expenseDto.setMoneyTook(expense.getMoneyTook());
		expenseDto.setMoneyTookFullName(moneyTookFullName);
		expenseDto.setPurpose(expense.getPurpose());
		expenseDto.setMoneyGivenAt(expense.getMoneyGivenAt());
		expenseDto.setExpenseCreatedAt(expense.getExpenseCreatedAt());
		expenseDto.setExpenseCreatedBy(expense.getExpenseCreatedBy());
		expenseDto.setExpenseCreatedByFullName(expenseCreatedByFullName);
		expenseDto.setSum(expense.getSum());
		return expenseDto;
	}
}
