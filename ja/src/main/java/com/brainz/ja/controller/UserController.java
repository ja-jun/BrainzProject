package com.brainz.ja.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brainz.ja.service.UserService;
import com.brainz.ja.vo.ServerVo;
import com.brainz.ja.vo.UserVo;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("mainPage")
	public String mainPage(HttpSession session) {
		
		return "user/mainPage";
	}
	
	@RequestMapping("registerUser")
	public String registerUser() {
		return "user/registerUser";
	}
	
	@RequestMapping("registerUserProcess")
	public String registerUserProcess(UserVo vo) throws Exception {
		
		userService.register(vo);
		
		return "user/registerUserComplete";
	}
	
	
	@RequestMapping("test")
	public String test() {
		return "user/test";
	}
	
	

}
