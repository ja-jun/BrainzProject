package com.brainz.ja.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.vo.CalendarVo;

@Controller
@RequestMapping("/calendar/*")
public class CalendarController {
	
	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping("calendarListPage")
	public String calenderListPage() {
		
		return "/calendar/calendarListPage";
	}
	
	@RequestMapping("calendarGridPage")
	public String calendarGridPage() {
		
		return "/calendar/calendarGridPage";
	}
	

}
