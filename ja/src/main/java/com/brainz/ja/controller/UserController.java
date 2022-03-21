package com.brainz.ja.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/user/*")
public class UserController {
	
	
	@RequestMapping("mainPage")
	public String mainPage(HttpSession session) {
		
		return "user/mainPage";
	}
	
	
	@RequestMapping("test")
	public String test() {
		return "user/test";
	}
	
	@RequestMapping("test2")
	public String test2() {
		return "user/test2";
	}
	
	

}
