package com.choongang.bcentral.info.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.info.service.InfoService;
import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.server.vo.ServerVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/info/*")
public class RestInfoController {

	@Autowired
	private InfoService infoService;
	
	@RequestMapping("getServerInfo")
	public HashMap<String, Object> getServerInfo(){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<ScheduleVo> scheduleList = infoService.getTodaySchedule();
		ArrayList<HashMap<String, Object>> serverInfo = infoService.getServerInfo(scheduleList);
		
		Integer[] stateCount = {0, 0, 0, 0};
		
		int count = 0;
		
		for(HashMap<String, Object> server : serverInfo) {
			if(server != null) {
				count++;
				if(server.containsKey("state")) {
					Integer state = (Integer) server.get("state");
					System.out.println("상태는 : " + state);
					stateCount[state]++;
				}
				ServerVo sv = (ServerVo) server.get("serverVo");
				System.out.println(sv.getOs());
			}
		}
		
		stateCount[3] = count - stateCount[2] - stateCount[1] - stateCount[0];
		
		data.put("serverInfo", serverInfo);
		data.put("totalServer", infoService.getTotalServer());
		data.put("stateCount", stateCount);
		data.put("weekScheduleInfo", infoService.getWeekScheduleInfo());
		data.put("notificationVo", infoService.getNotification());
				
		return data;
	}
	
	// 테스트 용
	@RequestMapping("getScheduleInfo")
	public HashMap<String, Object> getScheduleInfo(){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String,Object>> sc = infoService.getScheduleInfo();
		
		data.put("rows", infoService.getScheduleInfo());
		
		return data;
	}
}
