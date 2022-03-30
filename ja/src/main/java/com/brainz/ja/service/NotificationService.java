package com.brainz.ja.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.NotificationSQLMapper;
import com.brainz.ja.vo.NotificationVo;
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;

@Service
public class NotificationService {
	
	@Autowired
	private NotificationSQLMapper notificationSQLMapper;
		
	public ArrayList<NotificationVo> getNotificationList(PageVo vo) {
	
		ArrayList<NotificationVo> getNotificationList = notificationSQLMapper.getNotificationList(vo);

		
		return getNotificationList;
	}
	
	public void insertNotification(NotificationVo vo) {
		notificationSQLMapper.insertNotification(vo);
	}

	public void updateNotification(NotificationVo vo) {
		notificationSQLMapper.updateNotification(vo);	
	}

	public void deleteNotification(List<String> nos) {
		
		for(String no  : nos) {
			notificationSQLMapper.deleteNotification(Integer.parseInt(no.trim()));
		}
		
	}
	
	public NotificationVo getNotification(int nc_no) {
		return notificationSQLMapper.getNotification(nc_no);
	}
	
	public void increaseReadCount(int nc_no) {
		notificationSQLMapper.increaseReadCount(nc_no);
	}
	
	public int getNotificationCount(PageVo vo){
		return notificationSQLMapper.getNotificationCount(vo);
		 
	}
}