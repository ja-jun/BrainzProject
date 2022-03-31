package com.choongang.bcentral.noti.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.NotificationSQLMapper;
import com.choongang.bcentral.noti.vo.NotificationVo;
import com.choongang.bcentral.server.vo.PageVo;

// 공지사항 Service
@Service
public class NotificationService {
	
	@Autowired
	private NotificationSQLMapper notiSQLMapper;
	
	public ArrayList<NotificationVo> getNotificationList(PageVo vo){
		return notiSQLMapper.getNotificationList(vo);
	}
	
	public void insertNotification(NotificationVo vo) {
		notiSQLMapper.insertNotification(vo);
	}
	
	public void updateNotification(NotificationVo vo) {
		notiSQLMapper.updateNotification(vo);
	}
	
	public void deleteNotification(ArrayList<String> nos) {
		for(String no : nos) {
			notiSQLMapper.deleteNotification(Integer.parseInt(no.trim()));
		}
	}
	
	public NotificationVo getNotification(int nc_no) {
		return notiSQLMapper.getNotification(nc_no);
	}
	
	public void increaseReadCount(int nc_no) {
		notiSQLMapper.increaseReadCount(nc_no);
	}
	
	public int getNotificationCount(PageVo vo) {
		return notiSQLMapper.getNotificationCount(vo);
	}
}
