package com.dakiplast.services.impl;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

@Service
public class SessionService {

	private static final String LOGGED_USER_ID = "userId";
	
	public static void createSessionLoggedUserId(HttpServletRequest request, Long userId) {
		request.getSession().setAttribute(LOGGED_USER_ID, userId);
	}

	public static Long getLoggedUserId(HttpServletRequest request) {
		
		return (Long) request.getSession().getAttribute(LOGGED_USER_ID);
	}

}
