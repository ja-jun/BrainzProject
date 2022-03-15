package com.brainz.ja.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brainz.ja.service.jbUserService;
import com.brainz.ja.vo.jbUserVo;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private jbUserService userService;
	
	@RequestMapping("mainPage")
	public String mainPage(HttpSession session) {
		
		return "/user/mainPage";
	}
	
	@RequestMapping("registerUser")
	public String registerUser() {
		return "/user/registerUser";
	}
	
	@RequestMapping("/registerUserProcess")
	public String registerUserProcess(jbUserVo vo) throws Exception {
		
		userService.register(vo);
		
		return "/user/registerUserComplete";
	}
	
	

}
