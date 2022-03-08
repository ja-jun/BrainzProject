package com.brainz.ja.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brainz.ja.service.jbUserService;
import com.brainz.ja.vo.jbUserVo;

@Controller
public class jbHomeController {
	
	@Autowired
	private jbUserService userService;

	@RequestMapping("/index")
	public String home(Model model) {
		return "home";
	}
	
	@RequestMapping("/jbAdmin")
	public String admin(Model model) {
		System.out.println("admdin 확인");
		return "jbAdmin";
	}
	
	@RequestMapping("/jbLogin")
	public String login(Model model) {
		System.out.println("login 확인");
		return "jbLogin";
	}
	
	@RequestMapping("/jbWork")
	public String work() {
		return "jbWork";
	}
	
	@RequestMapping("/jbRegisterUser")
	public String registerUser() {
		return "jbRegisterUser";
	}
	
	@RequestMapping("/registerUserProcess")
	public String registerUserProcess(jbUserVo vo) {
		
		System.out.println("아이디 등록");
		
		userService.register(vo);
		
		return "jbRegisterUserComplete";
	}


}
