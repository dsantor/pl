package com.dakiplast.controllers.api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.dto.ExpenseDto;
import com.dakiplast.entities.interfaces.IExpense;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.requests.ExpenseRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.ExpenseService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.WorkerService;
import com.dakiplast.services.impl.SessionService;

@RestController
@RequestMapping("/api/expense")
public class ExpenseController {

	@Autowired
	private ExpenseService expenseService;
	@Autowired
	private UserService userService;
	@Autowired
	private WorkerService workerService;
	@Autowired
	private UserActivityLogService userActivityLogService;
	
	@PostMapping("/create")
	public BaseResponse create(@RequestBody ExpenseRequest request, HttpServletRequest servletRequest) {
		
		Long loggedUserId = SessionService.getLoggedUserId(servletRequest);
		IUser user = userService.getById(loggedUserId);
		
		Long moneyGivenBy	  = request.getMoneyGivenBy();
		Long moneyTook		  = request.getMoneyTook();
		Long moneyGivenAt 	  = request.getMoneyGivenAt();
		String purpose 		  = request.getPurpose();
		Long sum			  = request.getSum();
		
		IExpense expense = expenseService.create(moneyGivenBy, moneyTook, moneyGivenAt, user.getId(), purpose, sum);
		
		if (expense == null) {
			return new BaseResponse(null, true, "Doslo je do greške");
		}
		
		userActivityLogService.create(loggedUserId, null, null, moneyTook, UserActivityLogType.CREATED_EXPENSE);
		IUser userWhoGaveMoney 	= userService.getById(moneyGivenBy);
		IWorker workerMoneyTook = workerService.getById(moneyTook);

		ExpenseDto expenseDto = ExpenseDto.ConvertToDto(expense, userWhoGaveMoney.getFullName(), workerMoneyTook.getFullName(), user.getFullName());
				
		return new BaseResponse(expenseDto, false, null);
	}
	
	@GetMapping("/get/{id}")
	public BaseResponse get(@PathVariable ("id") Long id) {
		IExpense expense = expenseService.get(id);
		IUser userExpenseCreated = userService.getById(expense.getExpenseCreatedBy());
		IUser userWhoGaveMoney 	 = userService.getById(expense.getMoneyGivenBy());
		IWorker workerMoneyTook  = workerService.getById(expense.getMoneyTook());
		ExpenseDto expenseDto = ExpenseDto.ConvertToDto(expense, userWhoGaveMoney.getFullName(), workerMoneyTook.getFullName(), userExpenseCreated.getFullName());
		return new BaseResponse(expenseDto, false, null);
	}
	
	@GetMapping("/all")
	public BaseResponse getAll() {
		List<IExpense> expenseList = expenseService.getAll();
		List<ExpenseDto> result = new ArrayList<>(expenseList.size());
		
		ExpenseDto expenseDto;
		IUser userExpenseCreated;
		IUser userWhoGaveMoney;
		IWorker workerMoneyTook;
		for (IExpense expense: expenseList) {
			userExpenseCreated = userService.getById(expense.getExpenseCreatedBy());
			userWhoGaveMoney   = userService.getById(expense.getMoneyGivenBy());
			workerMoneyTook    = workerService.getById(expense.getMoneyTook());
			
			expenseDto = ExpenseDto.ConvertToDto(expense, userWhoGaveMoney.getFullName(), workerMoneyTook.getFullName(), userExpenseCreated.getFullName());
			result.add(expenseDto);
		}
		
		return new BaseResponse(result, false, null);
	}
}
