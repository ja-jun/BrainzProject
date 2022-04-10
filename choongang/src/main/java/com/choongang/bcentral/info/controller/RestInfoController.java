package com.choongang.bcentral.info.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.info.service.InfoService;
import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.server.vo.ServerInfoVo;
import com.choongang.bcentral.server.vo.ServerVo;
import com.choongang.bcentral.user.vo.UserVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/info/*")
public class RestInfoController {

	@Autowired
	private InfoService infoService;
	
	@RequestMapping("getServerInfo")
	public HashMap<String, Object> getServerInfo(HttpSession session){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<ScheduleVo> scheduleList = infoService.getTodaySchedule();
		HashMap<Integer, Object> serverInfo = infoService.getServerInfo(scheduleList);
		
		Integer[] stateCount = {0, 0, 0, 0};
		
		for(Integer serverNo : serverInfo.keySet()) {
			ServerInfoVo siVo = (ServerInfoVo) serverInfo.get(serverNo);
			stateCount[siVo.getStatus()]++;
			System.out.println("server_no : " + serverNo + " server_status : " + siVo.getStatus());
		}
		
		UserVo userVo = (UserVo) session.getAttribute("userInfo");
		
		data.put("serverInfo", serverInfo);
		data.put("totalServer", infoService.getTotalServer());
		data.put("stateCount", stateCount);
		data.put("weekScheduleInfo", infoService.getWeekScheduleInfo(userVo.getUser_no()));
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
