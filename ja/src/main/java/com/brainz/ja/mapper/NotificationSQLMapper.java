package com.brainz.ja.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.brainz.ja.vo.NotificationVo;
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;

public interface NotificationSQLMapper {

	public ArrayList<NotificationVo> getNotificationList(PageVo vo);
	public void insertNotification(NotificationVo vo);
	public void updateNotification(NotificationVo vo);
	public void deleteNotification(int nc_no);
	public NotificationVo getNotification(int nc_no);
	public void increaseReadCount(int nc_no);
	public int getNotificationCount(PageVo vo);

}
