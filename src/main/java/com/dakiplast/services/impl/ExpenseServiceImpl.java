package com.dakiplast.services.impl;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.interfaces.IExpense;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.repository.ExpenseRepository;
import com.dakiplast.services.ExpenseService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.WorkerService;

@Service
public class ExpenseServiceImpl implements ExpenseService {

	@Autowired
	private ExpenseRepository expenseRepository;
	@Autowired
	private UserService userService;
	@Autowired
	private WorkerService workerService;
	
	@Override
	public IExpense create(Long moneyGivenBy, Long moneyTook, Long moneyGivenAt, Long expenseCreatedBy, String purpose, Long sum) {
		IUser user = userService.getById(moneyGivenBy);
		
		if (user == null) {
			return null;
		}
		IWorker worker = workerService.getById(moneyTook);
		if (worker == null) {
			return null;
		}
		
		if (sum < 0) {
			return null;
		}
		Long expenseCreatedAt = Calendar.getInstance().getTimeInMillis();
		return expenseRepository.create(moneyGivenBy, moneyTook, moneyGivenAt, expenseCreatedBy, expenseCreatedAt, purpose, sum);
	}

	@Override
	public IExpense get(Long id) {
		return expenseRepository.get(id);
	}

	@Override
	public List<IExpense> getAll() {
		return expenseRepository.getAll();
	}

}
