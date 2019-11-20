package com.dakiplast.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Component;

@Component( "restAuthenticationEntryPoint" )
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

	private static final Logger LOG = LoggerFactory.getLogger( RestAuthenticationEntryPoint.class.getName() );
	private static String LOGIN_PAGE_URL = "/login";

	@Override
	public void commence( HttpServletRequest request, HttpServletResponse response, AuthenticationException authException ) throws IOException {

		// Get context path and URI
		String contextPath = request.getContextPath();
		String requestUri = request.getRequestURI();
		String pathInfo = request.getPathInfo();
		String spath = request.getServletPath();
		String lr = request.getRequestURI();
		StringBuffer d = request.getRequestURL();
		// Remove context path from URI
		if ( contextPath != null && !contextPath.trim().isEmpty() ) {

			// Request URI begins with context path
			int contextPathLength = contextPath.trim().length();
			requestUri = requestUri.substring( contextPathLength );
		}

		// Print requested URI
		LOG.info( "Requested uri: " + requestUri );
	      
		// If user comes for a REST call return "not authorized" exception
		if (requestUri.toLowerCase().startsWith("/api")) {
//			RequestDispatcher dispatcher = response.getServletContext()
//				      .getRequestDispatcher("/login");
//				    dispatcher.forward(request, response);
//			request.getSession(true).invalidate();
			response.sendError( HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized" );
//			response.sendRedirect("/login?error");
//			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			//response.sendRedirect("/logout");
//			RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
//			redirectStrategy.sendRedirect( request, response, "/login?invalid" );
			
		} else {

			// User is requesting page - redirect to login page
			RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
			redirectStrategy.sendRedirect( request, response, "/login");
		}
	}
}
