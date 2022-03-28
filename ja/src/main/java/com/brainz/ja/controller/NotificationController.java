package com.brainz.ja.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notification/*")
public class NotificationController {
	
	@RequestMapping("notificationPage")
	public String notification(HttpSession session) {
		
		return "/notification/notificationPage";

	}
}
