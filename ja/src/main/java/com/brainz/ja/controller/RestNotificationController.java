package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.NotificationService;
import com.brainz.ja.vo.NotificationVo;
import com.brainz.ja.vo.ServerVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/notification/*")
public class RestNotificationController {
	
	@Autowired
	private NotificationService notificationService; 
	
	@RequestMapping("getNotificationList")
	public Map<String, Object> getNotificationList(String searchWord) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<NotificationVo> notificationList = notificationService.getNotificationList(searchWord);
		System.out.println(new Gson().toJson(notificationList));
		
		data.put("rows", notificationList);
		
		return data;

	}
	
	@RequestMapping("insertNotification")
	public HashMap<String, Object> insertNotification(NotificationVo param) {
	//	System.out.println("2 - " + new Gson().toJson(param));
		HashMap<String, Object>data = new HashMap<String, Object>();

		param.setUser_no(2); 
		
		notificationService.insertNotification(param);
		
		data.put("result","success");
		
		return data;
	}

	@RequestMapping("updateNotification")
	public HashMap<String, Object> updateNotification(NotificationVo param) {
		HashMap<String, Object>data = new HashMap<String, Object>();

		System.out.println("**************");
		
		notificationService.updateNotification(param);		

		
		//예외처리 try문??
		//	if 문? {		data.put("result", "error");		data.put("reason", "이런 에러가 발생했습니다");		return data;	}
			
		data.put("result","success");
		
		return data;
	}

	@RequestMapping("deleteNotification")
	public  HashMap<String, Object> deleteNotification(@RequestBody List<String> param) {
		//data의 필요성 에러 관련
		HashMap<String, Object> data = new HashMap<String, Object>();

		notificationService.deleteNotification(param);

		return data;
	}
	
	@RequestMapping("getNotification")
	public  HashMap<String, Object> getNotification(int nc_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		NotificationVo notification = notificationService.getNotification(nc_no);
		
		data.put("notification", notification); 
		return data;
	}
	
	
}
