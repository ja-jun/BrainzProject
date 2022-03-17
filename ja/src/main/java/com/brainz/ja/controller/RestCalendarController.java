
package com.brainz.ja.controller;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

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
	public HashMap<String, Object> getList(Integer year, Integer month){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("scheduleList", service.getScheduleList(year, month));
		
		return data;
	}
	
	@RequestMapping("getScheduleInfo")
	public HashMap<String, Object> getScheduleInfo(Integer sc_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("scheduleInfo", service.getScheduleInfo(sc_no));
		data.put("serverList", service.getServerList(sc_no));
		data.put("serverListNo", service.getServerListNoServer(sc_no));
		
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
			data.put("result", 1);
		} else if(ssVo.getStart_date() == null || ssVo.getEnd_date() == null) {
			data.put("result", 2);
		} else if(ssVo.getStart_time() == null || ssVo.getEnd_time() == null) {
			data.put("result", 3);
		} else {
			service.regSchedule(ssVo);
			data.put("result", 0);
		}
		
		return data;
	}
	
//	0 - 선택된 날짜 이전 이후 모두 삭제
//	1 - 선택된 날짜만 삭제
//	2 - 선택된 날짜 이후만 삭제
	
	@RequestMapping("delSchedule")
	public HashMap<String, Object> delSchedule(Integer delete_radio, SetScheduleVo ssVo, String cur_date){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(ssVo));
		System.out.println(delete_radio);
		System.out.println(cur_date);
		
		if(delete_radio == 0) {
			service.delCat0(ssVo.getSc_no());
			data.put("result", 0);
		} else if(delete_radio == 1) {
			service.delCat1(ssVo, cur_date);
			data.put("result", 0);
		} else if(delete_radio == 2) {
			service.delCat2(ssVo, cur_date);
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
		
		service.modSchedule(ssVo);
		
		return data;
	}
}
