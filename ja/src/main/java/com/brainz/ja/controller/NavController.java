package com.brainz.ja.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/nav/*")
public class NavController {
	
	@RequestMapping("nav")
	public String nav() {
		return "nav/nav";
	}

}
