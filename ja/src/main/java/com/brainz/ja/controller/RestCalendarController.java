
package com.brainz.ja.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.service.CalendarServiceJun;
import com.brainz.ja.vo.ScheduleVo;

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
	public HashMap<String, Object> regTest(ScheduleVo sVo, ArrayList<Integer> server_no){
		
		System.out.println("title : " + sVo.getTitle() + " start_date : " + sVo.getStart_date());
		
		return null;
	}
	
	@RequestMapping("regSchedule")
	public HashMap<String, Object> regSchedule(HttpServletRequest param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		System.out.println("시작");
		
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm:ss");
		
		ScheduleVo sVo = new ScheduleVo();
		System.out.println("title : " + param.getParameter("title"));
		sVo.setTitle(param.getParameter("title"));
		System.out.println("start_date : " + param.getParameter("start_date"));
		sVo.setStart_date(LocalDate.parse(param.getParameter("start_date"), dateFormatter));
//		System.out.println("start_time : " + param.getParameter("start_time"));
//		sVo.setStart_time(LocalTime.parse(param.getParameter("start_time"),timeFormatter));
//		System.out.println("end_date : " + param.getParameter("end_date"));
//		sVo.setStart_date(LocalDate.parse(param.getParameter("end_date"), dateFormatter));
//		System.out.println("end_time : " + param.getParameter("end_time"));
//		sVo.setStart_time(LocalTime.parse(param.getParameter("end_time"),timeFormatter));
		
		if(param.getParameter("repear_cat") != null) {
			sVo.setRepeat_cat(Integer.parseInt(param.getParameter("repear_cat")));
		}
		if(param.getParameter("repear_day") != null) {
			sVo.setRepeat_day(Integer.parseInt(param.getParameter("repear_day")));
		}
		if(param.getParameter("repear_week") != null) {
			sVo.setRepeat_week(Integer.parseInt(param.getParameter("repear_week")));
		}
		
		sVo.setMon(param.getParameter("mon"));
		sVo.setThe(param.getParameter("the"));
		sVo.setWed(param.getParameter("wed"));
		sVo.setThu(param.getParameter("the"));
		sVo.setFri(param.getParameter("fri"));
		sVo.setSat(param.getParameter("sat"));
		sVo.setSun(param.getParameter("sun"));
		
		String[] serverList = param.getParameterValues("serverList");
		for(String list : serverList) {
			System.out.println(list);
		}
		
		System.out.println("종료");
		
		return data;
	}
}

