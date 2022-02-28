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
}
