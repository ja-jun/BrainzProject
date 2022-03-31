package com.choongang.bcentral.info.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/info/*")
public class InfoController {

	@RequestMapping("mainPage")
	public String mainPage() {
		return "/info/mainPage";
	}
	
	@RequestMapping("test")
	public String test() {
		return "/info/test";
	}
}
