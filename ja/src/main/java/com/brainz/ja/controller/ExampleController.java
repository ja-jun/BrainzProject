package com.brainz.ja.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brainz.ja.service.ExampleService;

@Controller
public class ExampleController {
	
	@Autowired
	private ExampleService exService;
	
	@RequestMapping("test")
	public String test() {
		
		exService.test();
		
		return "/test";
	}
	
	@RequestMapping("calendar01")
	public String calendar01() {
		
		return "calendar/calendar01";
	}
	
	@RequestMapping("calendar02")
	public String calendar02() {
		
		return "calendar/calendar02";
	}
	
	@RequestMapping("test001")
	public String test001() {
		
		return "calendar/calendarGridPage";
	}
	
	@RequestMapping("test002")
	public String test002() {
		
		return "calendar/calendarListPage";
	}
}
