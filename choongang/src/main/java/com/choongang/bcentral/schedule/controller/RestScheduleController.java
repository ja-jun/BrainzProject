package com.choongang.bcentral.schedule.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.schedule.service.ScheduleService;
import com.choongang.bcentral.schedule.vo.SetScheduleVo;
import com.google.gson.Gson;

// [작업관리] 비동기 식 Controller
@RestController
@RequestMapping("/schedule/*")
public class RestScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping("getList")
	public HashMap<String, Object> getList(Integer year, Integer month){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("scheduleList", scheduleService.getScheduleList(year, month));
		
		return data;
	}
	
	@RequestMapping("getScheduleInfo")
	public HashMap<String, Object> getScheduleInfo(Integer sc_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("scheduleInfo", scheduleService.getScheduleInfo(sc_no));
		data.put("serverList", scheduleService.getServerList(sc_no));
		
		return data;
	}
	
	@RequestMapping("getServerList")
	public HashMap<String, Object> getServerList(){
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("serverList", scheduleService.getServerList());
		System.out.println(data);
		
		return data;
	}
	
	@RequestMapping("regSchedule")
	public HashMap<String, Object> regSchedule(HttpServletRequest param, 
											   SetScheduleVo ssVo, 
											   String start_date, 
											   String end_date,
											   String start_time,
											   String end_time){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(ssVo));
		
		scheduleService.regSchedule(ssVo);
		data.put("result", 0);
		
		return data;
	}
	
	@RequestMapping("delSchedule")
	public HashMap<String, Object> delSchedule(Integer delete_radio, SetScheduleVo ssVo, String cur_date){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(ssVo));
		System.out.println(delete_radio);
		System.out.println(cur_date);
		
		if(delete_radio == 0) {
			scheduleService.delCat0(ssVo.getSc_no());
			data.put("result", 0);
		} else if(delete_radio == 1) {
			scheduleService.delCat1(ssVo, cur_date);
			data.put("result", 0);
		} else if(delete_radio == 2) {
			scheduleService.delCat2(ssVo, cur_date);
			data.put("result", 0);
		} else {
			data.put("result", 1);
		}
		
		return data;
	}
	
	@RequestMapping("modSchedule")
	public HashMap<String, Object> modSchedule(SetScheduleVo ssVo, String cur_date){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(ssVo));
		System.out.println(cur_date);
		
		scheduleService.modSchedule(ssVo);
		
		return data;
	}
	
	@RequestMapping("isExistTitle")
	public HashMap<String, Object> isExistTitle(String title){
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		System.out.println(title);
		boolean result = scheduleService.isExistTitle(title);
		
		data.put("result", result);		
		
		return data;
	}
}
