package com.choongang.bcentral.noti.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.noti.service.NotificationService;
import com.choongang.bcentral.noti.vo.NotificationVo;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.user.vo.UserVo;

@RestController
@RequestMapping("/notification/*")
public class RestNotificationController {

	@Autowired
	private NotificationService notiService;
	
	@RequestMapping("getNotificationList")
	public HashMap<String, Object> getNotificationList(PageVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		if(param.getSearchWord() != null) {
			param.setSearchWord(param.getSearchWord().replaceAll("\\\\", "\\\\\\\\"));
		}
		
		ArrayList<NotificationVo> notificationList = notiService.getNotificationList(param);
		
		int rows = param.getRows();
		int records = notiService.getNotificationCount(param);
		int total = (int) Math.ceil( (double) records / rows);
		
		data.put("rows", notificationList);
		data.put("records", records);
		data.put("page", param.getPage());
		data.put("total", total);
		
		return data;
	}
	
	@RequestMapping("insertNotification")
	public HashMap<String, Object> insertNotification(NotificationVo param, HttpSession session){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		UserVo uv = (UserVo) session.getAttribute("userInfo");
		
		param.setUser_no(uv.getUser_no());
		notiService.insertNotification(param);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("updateNotification")
	public HashMap<String, Object> updateNotification(NotificationVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		notiService.updateNotification(param);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("deleteNotification")
	public HashMap<String, Object> deleteNotification(ArrayList<String> param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		notiService.deleteNotification(param);
		
		return data;
	}
	
	@RequestMapping("getNotification")
	public HashMap<String, Object> getNotification(int nc_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("notification", notiService.getNotification(nc_no));
		
		return data;
	}
}
