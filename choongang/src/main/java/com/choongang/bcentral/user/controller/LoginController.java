package com.choongang.bcentral.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login/*")
public class LoginController {

	@RequestMapping("loginPage")
	public String login() {
		System.out.println("login 확인");
		return "login/loginPage";
	}
}
