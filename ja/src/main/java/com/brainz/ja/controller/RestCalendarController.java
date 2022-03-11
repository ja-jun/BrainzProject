
package com.brainz.ja.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.vo.SetScheduleVo;

@RestController
@RequestMapping("/schedule/*")
public class RestCalendarController {
	
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
		data.put("serverList", service.getServerList());
		
		return data;
	}
	
	@RequestMapping("regSchedule")
	public HashMap<String, Object> regSchedule(HttpServletRequest param, SetScheduleVo ssVo){
		HashMap<String, Object> data = new HashMap<String, Object>();
		if(ssVo.getRepeat_cat() == null) {
			ssVo.setRepeat_cat(0);
		}
		
		service.regSchedule(ssVo);
		
		return data;
	}
}

