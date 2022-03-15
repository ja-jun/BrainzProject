package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.vo.ServerVo;
import com.google.gson.Gson;

@Controller
@RequestMapping("/calendar/*")
public class CalendarController {
	
	@Autowired
	private CalendarService service;
	
	@RequestMapping("calendarListPage")
	public String calenderListPage() {
		
		return "/calendar/calendarListPage";
	}
	
	@RequestMapping("calendarGridPage")
	public String calendarGridPage() {
		
		return "/calendar/calendarGridPage";
	}
	
	@RequestMapping("multilang")
	public String multilang() {
		return "/calendar/multilang";
	}
	
	@RequestMapping("aaa")
	@ResponseBody
	public Gson aaa(){
		Gson gsonObj = new Gson();
		ArrayList<ServerVo> aa = service.getServerList();
		Map<String, String> inputMap = new HashMap<String, String>();
		for (int j = 0; j < aa.size(); j++) {
			inputMap.put("IP", aa.get(j).getIp());
		}
		String jsonStr = gsonObj.toJson(inputMap);
		System.out.println("MAP -> JSON 테스트 : " + jsonStr);
		
		return gsonObj;
		}
}
