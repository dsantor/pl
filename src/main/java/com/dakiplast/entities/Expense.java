package com.dakiplast.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.dakiplast.entities.interfaces.IExpense;

@Entity
@Table(name = "expense")
@NamedQueries({
	@NamedQuery(name = "Expense.findAll", query = "SELECT e FROM Expense e"),
	@NamedQuery(name = "Expense.getExpensesByWorkerId", query = "SELECT e FROM Expense e where e.moneyTook = :moneyTook")
})
public class Expense implements Serializable, IExpense {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	@Column(name = "money_given_by")
	private Long moneyGivenBy;
	
	@Column(name = "money_took")
	private Long moneyTook;
	
	@Column(name = "purpose")
	private String purpose;
	
	@Column(name = "money_given_at")
	private Long moneyGivenAt;
	
	@Column(name = "expense_created_at")
	private Long expenseCreatedAt;
	
	@Column(name = "expense_created_by")
	private Long expenseCreatedBy;
	
	@Column(name = "sum")
	private Long sum;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

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
}
