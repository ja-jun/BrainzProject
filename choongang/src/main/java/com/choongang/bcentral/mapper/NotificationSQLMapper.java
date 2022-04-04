package com.choongang.bcentral.mapper;

import java.util.ArrayList;

import com.choongang.bcentral.noti.vo.FileVo;
import com.choongang.bcentral.noti.vo.NotificationVo;
import com.choongang.bcentral.server.vo.PageVo;

public interface NotificationSQLMapper {
	public ArrayList<NotificationVo> getNotificationList(PageVo vo);
	public void insertNotification(NotificationVo vo);
	public void updateNotification(NotificationVo vo);
	public void deleteNotification(int nc_no);
	public NotificationVo getNotification(int nc_no);
	public void increaseReadCount(int nc_no);
	public int getNotificationCount(PageVo vo);
	public int getNextFileNo();
	
	//...
	public int getNextNotificationNo();
	public void insertFile(FileVo fileVo);
	
	
}
