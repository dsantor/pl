package com.dakiplast.controllers.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.UserActivityLogType;
import com.dakiplast.exceptions.ErrorsEnum;
import com.dakiplast.requests.OrderRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.services.OrderService;
import com.dakiplast.services.UserActivityLogService;
import com.dakiplast.services.UserService;
import com.dakiplast.services.impl.SessionService;
import com.dakiplast.utils.Validation;

@RestController
@RequestMapping("/api/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserActivityLogService userActivityLogService;
	
	@PostMapping("/create")
	public BaseResponse create(@RequestBody OrderRequest orderRequest, HttpServletRequest request) {
		
		Long loggedUserId = SessionService.getLoggedUserId(request);
		IUser user = userService.getById(loggedUserId);
		
		if (!Validation.isUserOrAdmin(user)) {
			return new BaseResponse(null, false, ErrorsEnum.PRIVILEGES_ERROR.getMessage());
		}
		
		IOrder order = orderService.create(orderRequest, loggedUserId);
		userActivityLogService.create(loggedUserId, null, order.getClientId(), UserActivityLogType.CREATED_ORDER);
		return new BaseResponse(order, false, null);
	}
}
