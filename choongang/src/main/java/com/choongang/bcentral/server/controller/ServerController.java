package com.choongang.bcentral.server.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

// [서버관리] 비동기 Controller
@Controller
@RequestMapping("/server/*")
public class ServerController {
	
	@RequestMapping("mainPage")
	public String mainPage() {
		return "server/mainPage";
	}
}
