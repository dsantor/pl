package com.dakiplast.controllers.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.WorkerRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.UserService;
import com.dakiplast.services.WorkerService;
import com.dakiplast.services.impl.SessionService;
import com.dakiplast.utils.Validation;

@RestController
@RequestMapping("/api/workers")
public class WorkersController {

	@Autowired
	private UserService userService;
	@Autowired
	private WorkerService workerService;
	
	@PostMapping("/save")
	public BaseResponse save(@RequestBody WorkerRequest worker, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		if (!Validation.isUserOrAdmin(user)) {
			return new BaseResponse(null, true, ErrorsEnum.PRIVILEGES_ERROR.getMessage());
		}
		
		IWorker iWorker = workerService.create(worker, user.getFullName());
		return new BaseResponse(iWorker, false, null);
	}
	
	@GetMapping("get/{id}")
	public BaseResponse get(@PathVariable ("id") Long id) {
		IWorker worker = workerService.getById(id);
		if (worker == null) {
			return new BaseResponse(null, true, ErrorsEnum.WORKER_NOT_FOUND.getMessage());
		}
		return new BaseResponse(worker, false, null);
	}
	
	@GetMapping("/all")
	public BaseResponse getAll() {
		List<IWorker> workers = workerService.getAll();
		return new BaseResponse(workers, false, null);
	}
}
