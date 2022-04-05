package com.choongang.bcentral.noti.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notification/*")
public class NotificationController {

	@RequestMapping("mainPage")
	public String notification(HttpSession session) {
		return "/notification/mainPage";
	}
}
