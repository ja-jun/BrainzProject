package com.choongang.bcentral.schedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.choongang.bcentral.schedule.service.ScheduleService;

// [작업관리] 동기 방식의 Controller

@Controller
@RequestMapping("/schedule/*")
public class ScheduleController {
	
	// 작업관리 mainPage 연결
	@RequestMapping
	public String mainPage() {
		
		return "/schedule/mainPage";
	}
}
