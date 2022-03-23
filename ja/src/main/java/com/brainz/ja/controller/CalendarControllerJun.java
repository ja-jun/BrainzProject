package com.brainz.ja.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/schedule/*")
public class CalendarControllerJun {
	
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
	
	@RequestMapping("calendarPageTest")
	public String calendarPageTest() {
		return "calendar/calendarListPageTest";
	}
}