package com.choongang.bcentral.server.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.choongang.bcentral.server.service.ServerService;

// [서버관리] 비동기 Controller
@Controller
@RequestMapping("/server/*")
public class ServerController {
	
	@Autowired
	private ServerService serverService;
	
	@RequestMapping("mainPage")
	public String mainPage(HttpSession session) {
		return "server/mainPage";
	}
}
