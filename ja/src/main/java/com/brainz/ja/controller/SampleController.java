package com.brainz.ja.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sample/*")
public class SampleController {
	
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/all")
	public void doAll() {
		System.out.println("do all can access everybody");
		
		logger.info("all 페이지 실행");
	}
	
	@GetMapping("/member")
	public void doMember() {
		System.out.println("logined member");
		
		logger.info("member 페이지 실행");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		System.out.println("admin only");
		
		logger.info("admin 페이지 실행");
	}
}
