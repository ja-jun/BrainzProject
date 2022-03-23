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
@RequestMapping("/calendar/*")
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
	public HashMap<String, Object> regSchedule(HttpServletRequest param, 
											   SetScheduleVo ssVo, 
											   String start_date, 
											   String end_date,
											   String start_time,
											   String end_time){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(ssVo));
		
		service.regSchedule(ssVo);
		data.put("result", 0);	
		
//		// 작업명은 입력되었는지 확인
//		if(!ssVo.getTitle().equals("")) {
//			// 시작 날짜는 정상적인지 확인
//			if(service.validateDate(start_date).get("result").equals("0")) {
//				// 종료 날짜는 정상적인지 확인
//				if(service.validateDate(end_date).get("result").equals("0")) {
//					//시작 시간은 정상적인지 확인
//					if(service.validationTime(start_time).get("result").equals("0")) {
//						//종료 시간은 정상적인지 확인
//						if(service.validationTime(end_time).get("result").equals("0")) {
//							if(ssVo.getServer_no()!= null) {
//								String result = service.validationSchedule(ssVo).get("result");
//								if(result.equals("0")) {
//									service.regSchedule(ssVo);
//									data.put("result", 0);									
//								} else {
//									data.put("result", result);
//								}
//							} else {
//								data.put("result", "작업하실 서버를 선택해주세요.");
//							}
//						} else {
//							data.put("result", "입력하신 종료 시간은 " + service.validationTime(end_time).get("result"));
//						}
//					} else {
//						data.put("result", "입력하신 시작 시간은 " + service.validationTime(start_time).get("result"));
//					}
//				} else {
//					data.put("result", "입력하신 종료 날짜는 " + service.validateDate(end_date).get("result"));
//				}
//			} else {
//				data.put("result", "입력하신 시작 날짜는 " + service.validateDate(start_date).get("result"));
//			}
//		} else {
//			data.put("result", "유효하지 않은 작업명입니다.");
//		}
		
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
	
	@RequestMapping("isExistTitle")
	public HashMap<String, Object> isExistTitle(String title){
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		System.out.println(title);
		boolean result = service.isExistTitle(title);
		
		data.put("result", result);		
		
		return data;
	}
}