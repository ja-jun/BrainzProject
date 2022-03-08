package com.brainz.ja.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brainz.ja.service.CalendarServiceJun;
import com.brainz.ja.vo.ScheduleVo;

@Controller
@RequestMapping("/schedule/*")
public class CalendarControllerJun {
	
	@Autowired
	private CalendarServiceJun service;
	
	@RequestMapping("regSchedule")
	public HashMap<String, Object> regSchedule(ScheduleVo sVo){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		service.regSchedule(sVo);
		
		return data;
	}
	
	@RequestMapping("calendarPage")
	public String calendarPage() {
		return "calendar/calendarListPage";
	}
	
	@RequestMapping("dateTest")
	public String dateTest() {
		return "sample/admin";
	}
	
	@RequestMapping("datePicker")
	public String datePicker() {
		return "calendar/datePicker";
	}
	
	@RequestMapping("jqGridPage")
	public String jqGridPage() {
		return "calendar/jqGridPage";
	}
}