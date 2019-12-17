package com.dakiplast.entities.interfaces;

public interface IExpense {
	public Long getId();
	public Long getMoneyGivenBy();
	public Long getMoneyTook();
	public String getPurpose();
	public Long getMoneyGivenAt();
	public Long getExpenseCreatedAt();
	public Long getExpenseCreatedBy();
	public Long getSum();
}
