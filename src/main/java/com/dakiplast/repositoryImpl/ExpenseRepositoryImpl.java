package com.dakiplast.repositoryImpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dakiplast.entities.Expense;
import com.dakiplast.entities.interfaces.IExpense;
import com.dakiplast.repository.ExpenseRepository;

@Repository
@Transactional
@SuppressWarnings("unchecked")
public class ExpenseRepositoryImpl implements ExpenseRepository {

	@Autowired
	private EntityManager entityManager;
	
	@Override
	public IExpense create( Long moneyGivenBy, Long moneyTook, Long moneyGivenAt, Long expenseCreatedBy, Long expenseCreatedAt, String purpose, Long sum) {
		Expense entity = new Expense();
		entity.setExpenseCreatedAt(expenseCreatedAt);
		entity.setExpenseCreatedBy(expenseCreatedBy);
		entity.setMoneyGivenAt(moneyGivenAt);
		entity.setMoneyGivenBy(moneyGivenBy);
		entity.setMoneyTook(moneyTook);
		entity.setPurpose(purpose);
		entity.setSum(sum);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IExpense get(Long id) {
		return entityManager.find(Expense.class, id);
	}
	
	@Override
	public List<IExpense> getAll() {
		Query query = entityManager.createNamedQuery("Expense.findAll");
		return query.getResultList();
	}

	@Override
	public List<IExpense> getWorkerExpenses(Long workerId) {
		Query query = entityManager.createNamedQuery("Expense.getExpensesByWorkerId").setParameter("moneyTook", workerId);
		return query.getResultList();
	}
}
