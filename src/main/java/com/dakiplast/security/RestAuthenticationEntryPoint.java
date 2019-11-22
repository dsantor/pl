package com.dakiplast.security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Component;

@Component( "restAuthenticationEntryPoint" )
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {


	@Override
	public void commence( HttpServletRequest request, HttpServletResponse response, AuthenticationException authException ) throws IOException {

		// Get context path and URI
		String contextPath = request.getContextPath();
		String requestUri = request.getRequestURI();

		// Remove context path from URI
		if ( contextPath != null && !contextPath.trim().isEmpty() ) {

			// Request URI begins with context path
			int contextPathLength = contextPath.trim().length();
			requestUri = requestUri.substring( contextPathLength );
		}

		// If user comes for a REST call return "not authorized" exception
		if (requestUri.toLowerCase().startsWith("/api")) {
			response.sendError( HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized" );
		} else {

			// User is requesting page - redirect to login page
			RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
			redirectStrategy.sendRedirect( request, response, "/login");
		}
	}
}
