package com.choongang.bcentral.info.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/info/*")
public class InfoController {

	@RequestMapping("mainPage")
	public String mainPage(HttpSession session, Authentication auth) {
		
		// 최종 로그인 시간 입력
		String user_id = auth.getName();
		
		
		return "/info/mainPage";
	}
	
	@RequestMapping("test")
	public String test() {
		return "/info/test";
	}
}
