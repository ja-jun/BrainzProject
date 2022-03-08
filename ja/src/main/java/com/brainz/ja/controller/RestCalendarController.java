package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.vo.CalendarVo;
import com.brainz.ja.vo.TestVo;

@RestController
@RequestMapping("/calendar/*")
public class RestCalendarController {
	

	@Autowired
	private CalendarService calendarService;
	
	
	@RequestMapping("getCalendarList")
	public HashMap<String, Object> getCalendarList(Model model) {
		
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		ArrayList<CalendarVo> calendarList = calendarService.getCalendarList();
		
		data.put("result", "success");
		data.put("calendarList", calendarList);
		
		return data;
	}
	
	
	@RequestMapping("getServerList")
	public HashMap<String, Object> getServerList(Model model) {
		
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		ArrayList<HashMap<String, Object>> serverList = calendarService.getServerList();
		
		data.put("result", "success");
		data.put("serverList", serverList);
		
		return data;
	}
	

	
}
