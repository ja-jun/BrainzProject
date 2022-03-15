package com.brainz.ja.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class jbHomeController {

	@RequestMapping("/index")
	public String home(Model model) {
		return "home";
	}
	
	@RequestMapping("/jbLogin")
	public String login(Model model) {
		System.out.println("login 확인");
		return "jbLogin";
	}
	
}
