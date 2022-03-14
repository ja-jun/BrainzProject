
package com.brainz.ja.controller;

import java.awt.SystemTray;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.CalendarService;
import com.brainz.ja.vo.SetScheduleVo;
import com.google.gson.Gson;

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
		System.out.println(data);
		
		return data;
	}
	
	@RequestMapping("regSchedule")
	public HashMap<String, Object> regSchedule(HttpServletRequest param, SetScheduleVo ssVo){
		Gson gson = new Gson();
		System.out.println(gson.toJson(ssVo));
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		if(ssVo.getRepeat_cat() == null) {
			ssVo.setRepeat_cat(0);
		}
		
		if(ssVo.getTitle() == null) {
			data.put("result", 0);
		} else if(ssVo.getStart_date() == null || ssVo.getEnd_date() == null) {
			data.put("result", 1);
		} else if(ssVo.getStart_time() == null || ssVo.getEnd_time() == null) {
			data.put("result", 2);
		} else {
			service.regSchedule(ssVo);
			data.put("result", 3);
		}
		
		return data;
	}
}

