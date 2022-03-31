package com.choongang.bcentral.mapper;

import java.util.ArrayList;

import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.server.vo.ServerVo;

public interface InfoSQLMapper {
	
	// 기간에 오늘이 포함되는 스케줄을 출력
	public ArrayList<ScheduleVo> selectTodaySchedule();
	
	// 스케줄 번호에 연결된 서버들을 출력
	public ArrayList<ServerVo> selectServerVoByScNo(int sc_no);
	
	public ArrayList<ServerVo> selectServer();
}