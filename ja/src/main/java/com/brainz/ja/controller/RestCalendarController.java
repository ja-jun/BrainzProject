package com.brainz.ja.controller;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.service.CalendarServiceJun;

@RestController
@RequestMapping("/schedule/*")
public class RestCalendarController {
	
	@Autowired
	private CalendarServiceJun serviceJun;
	
	@Autowired
	private CalendarService service;
	
	@RequestMapping("getList")
	public HashMap<String, Object> getList(int month, int year){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("scheduleList", service.getScheduleList(year, month));
		
		return data;
	}
	
	@RequestMapping("getServerList")
	public HashMap<String, Object> getServerList(){
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("serverList", serviceJun.getServerList());
		return data;
	}
	
	@RequestMapping("insertDate")
	public HashMap<String, Object> insertDate(String date){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		System.out.println(date);
		
		try {
			LocalDate test = LocalDate.parse(date);
			System.out.println("String to LocalDate : " + test);
			
			serviceJun.insertGood(date);
			
			data.put("result", "success");
		} catch(Exception e) {
			data.put("result", "fail");
		}
		return data;
	}
	
	
	@RequestMapping("regTest")
	public HashMap<String, Object> test(String start_date , String repeat_cat){
		
		System.out.println("test : " + repeat_cat + ":" + start_date);
		
		return null;
	}
	
}
