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
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;
import com.brainz.ja.vo.UserVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/notification/*")
public class RestNotificationController {
	
	@Autowired
	private NotificationService notificationService; 
	
	@RequestMapping("getNotificationList")
	public Map<String, Object> getNotificationList(PageVo param) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		if(param.getSearchWord() != null){
			String searchWord = param.getSearchWord();
			System.out.println(searchWord);
			searchWord = searchWord.replaceAll("\\\\" , "\\\\\\\\");
			param.setSearchWord(searchWord);
			System.out.println(searchWord);
		}
		
		ArrayList<NotificationVo> notificationList = notificationService.getNotificationList(param);
		System.out.println(new Gson().toJson(notificationList));
		int rows = param.getRows();
		int records = notificationService.getNotificationCount(param);
		int total = (int) Math.ceil( (double)records / rows);
		
		data.put("rows", notificationList); //데이터
		data.put("records", records); // 데이터의 전체 개수  //viewrecords에 사용됨
		data.put("page", param.getPage()); //현재 페이지
		data.put("total", total); //총 페이지
		
		return data;

	}
	
	@RequestMapping("insertNotification")
	public HashMap<String, Object> insertNotification(NotificationVo param, HttpSession session) {
	//	System.out.println("2 - " + new Gson().toJson(param));
		HashMap<String, Object>data = new HashMap<String, Object>();

		UserVo uv = (UserVo)session.getAttribute("userInfo");
		
		param.setUser_no(uv.getUser_no()); 
		
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
