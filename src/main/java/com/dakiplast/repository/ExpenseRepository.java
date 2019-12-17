package com.dakiplast.repository;

import java.util.List;

import com.dakiplast.entities.interfaces.IExpense;

public interface ExpenseRepository {

	IExpense create(Long moneyGivenBy, Long moneyTook, Long moneyGivenAt, Long expenseCreatedBy, Long expenseCreatedAt, String purpose, Long sum);
	IExpense get(Long id);
	List<IExpense> getAll();

}