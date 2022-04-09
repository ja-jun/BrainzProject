package com.choongang.bcentral.info.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.choongang.bcentral.user.controller.LoginController;

@Controller
public class MainController {

	
	@Autowired
	private LoginController loginController;
	
	
	
	@RequestMapping("/")
	public String main() {
		
		return loginController.login();
	}
	
}

