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
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.WorkerRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.UserActivityLogService;
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
	@Autowired
	private UserActivityLogService userActivityLogService;
	
	@PostMapping("/save")
	public BaseResponse save(@RequestBody WorkerRequest worker, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		if (!Validation.isUserOrAdmin(user)) {
			return new BaseResponse(null, true, ErrorsEnum.PRIVILEGES_ERROR.getMessage());
		}
		
		IWorker iWorker = workerService.create(worker, user.getFullName());
		if (iWorker == null) {
			return new BaseResponse(null, true, "Korisnik nije uspesno kreiran, pokusajte ponovo.");
		}
		return new BaseResponse(iWorker, false, "Kreiran klijent " + iWorker.getFirstName() + " " + iWorker.getLastName());
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
	
	@GetMapping("/toggleBlockUser/{workerId}")
	public BaseResponse toggleBlockUser(@PathVariable ("workerId") Long workerId, HttpServletRequest request) {
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		boolean blocked = false;
		if (RolesEnum.ROLE_ADMIN.equals(user.getRole())) {
			blocked = workerService.toggleBlockWorker(workerId);			
		} else {
			return new BaseResponse(null, true, "Nemate privilegije za ovu akciju!");
		}
		
		if (blocked) {
			IWorker blockedUser = workerService.getById(workerId);
			String blockText = blockedUser.isActive() ? "blokiran" : "odblokiran";
			
			if (blockedUser.isActive()) {
				userActivityLogService.blockWorker(loggedUserId, workerId);
			} else {
				userActivityLogService.blockWorker(loggedUserId, workerId);
			}
			return new BaseResponse(null, false, "Uspešno " + blockText + " radnik");
		}
		return new BaseResponse(null, true, "Akcija nije uspešno izvršena");
	}
	
	@PostMapping("/update")
	public BaseResponse update(@RequestBody WorkerRequest workerRequest) {
		IWorker worker = workerService.update(workerRequest);
		if (worker == null) {
			return new BaseResponse(null, true, "Korisnik nije uspesno izmenjen, pokusajte ponovo.");
		}
		return new BaseResponse(worker, false, null);
	}
}
