package com.dakiplast.controllers;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.Model;

public class LoginControllerTest {

	@Mock
	private LoginController controller;
	
	@Mock
	private Model model;
	
//	@MockBean
	MockMvc mockMvc;
	@BeforeEach
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		controller = new LoginController();
		mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
	}
	
	@Test
	void login_on_root() throws Exception {
//		String login = new LoginController().login(null, null);
//		assertEquals("login.html", login);
		mockMvc.perform(get("")).andExpect(status().isOk()).andExpect(view().name("login.html"));
	}
}
