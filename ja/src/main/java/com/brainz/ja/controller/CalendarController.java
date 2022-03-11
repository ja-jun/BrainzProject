package com.brainz.ja.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/calendar/*")
public class CalendarController {
	
	@RequestMapping("calendarListPage")
	public String calenderListPage() {
		
		return "/calendar/calendarListPage";
	}
	
	@RequestMapping("calendarGridPage")
	public String calendarGridPage() {
		
		return "/calendar/calendarGridPage";
	}
	

}
