package com.brainz.ja.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login/*")
public class LoginController {

	
	@RequestMapping("loginPage")
	public String login(Model model) {
		System.out.println("login 확인");
		return "login/loginPage";
	}
	
	@RequestMapping("deniedPage")
	public String accessDenied(){
	    return "login/deniedPage";
	}
	
}
