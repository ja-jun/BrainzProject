package com.choongang.bcentral.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.choongang.bcentral.user.service.UserService;

// [사용자관리] 동기적 Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping("mainPage")
	public String mainPage(HttpSession session, Authentication auth) {

		// 최종 로그인 시간 입력
		String user_id = auth.getName();
		userService.lastLogin(user_id);
		
		session.setAttribute("userInfo", userService.getUserInfo(user_id));

		return "user/mainPage";
	}
}
