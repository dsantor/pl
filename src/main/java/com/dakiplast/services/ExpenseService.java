package com.dakiplast.services;

import java.util.List;

import com.dakiplast.entities.dto.ExpenseDto;
import com.dakiplast.entities.interfaces.IExpense;

public interface ExpenseService {

	IExpense create(Long moneyGivenBy, Long moneyTook, Long moneyGivenAt, Long expenseCreatedBy, String purpose, Long sum);
	IExpense get(Long id);
	List<IExpense> getAll();
	List<IExpense> getWorkerExpenses(Long workerId);
	ExpenseDto convertToDto(IExpense expense);
}
