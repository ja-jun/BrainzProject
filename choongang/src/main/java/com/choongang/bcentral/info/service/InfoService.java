package com.choongang.bcentral.info.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalField;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.InfoSQLMapper;
import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.server.vo.ServerVo;

@Service
public class InfoService {
	
	@Autowired
	private InfoSQLMapper ifSqlMapper;
	
	// 기간이 오늘을 포함하는 스케줄 목록을 조회
	public ArrayList<ScheduleVo> getTodaySchedule(){
		return ifSqlMapper.selectTodaySchedule();
	}
	
	// 스케줄과 연결된 Server의 ServerVo를 불러옴
	public ArrayList<ServerVo> getScheduleServer(int sc_no){
		return ifSqlMapper.selectServerVoByScNo(sc_no);
	}
	
	// 모든 서버의 갯수를 가져옴
	public ArrayList<ServerVo> getTotalServer() {
		return ifSqlMapper.selectServer();
	}
	
	// ScheduleVo를 넣어주면 현재 해당 스케줄의 상태를 알려줌
	public int todaySchedule(ScheduleVo sVo){
		/*	result = 0 : 작업 전
		 *	result = 1 : 작업 중
		 *	result = 2 : 작업 후
		 *	result = 3 : 오늘 작업 없음 */
		
		int result = 3;
		
		LocalDate now_date = LocalDate.now();
		LocalTime now_time = LocalTime.now();
		LocalDateTime now = LocalDateTime.of(now_date, now_time);
		
		LocalDateTime start = LocalDateTime.of(sVo.getStart_date(), sVo.getStart_time());
		LocalDateTime end = LocalDateTime.of(sVo.getEnd_date(), sVo.getEnd_time());
		
		String[] days = {sVo.getMon(), sVo.getThe(), sVo.getWed(), sVo.getThu(), sVo.getFri(), sVo.getSat(), sVo.getSun()};
		int day = now.getDayOfWeek().getValue() - 1;
		
		switch(sVo.getRepeat_cat()) {
		case 0:
			if(now_date.isEqual(sVo.getStart_date()) && now_time.isBefore(sVo.getStart_time())) {
				result = 0;
			} else if(now_date.isEqual(sVo.getEnd_date()) && now_time.isAfter(sVo.getEnd_time())) {
				result = 2;
			} else if(now.isAfter(start) && now.isBefore(end)) {
				result = 1;
			}
			break;
		case 1:
			if(days[day] != null) {
				if(now_time.isBefore(sVo.getStart_time())) {
					result = 0;
				} else  if(now_time.isAfter(sVo.getEnd_time())) {
					result = 2;
				} else if(now_time.isAfter(sVo.getStart_time()) && now_time.isBefore(sVo.getEnd_time())) {
					result = 1;
				}
			}
			break;
		case 2:
			WeekFields weekFields = WeekFields.of(DayOfWeek.SUNDAY, 1);
			TemporalField weekOfMonth = weekFields.weekOfMonth();
			int wom = now.get(weekOfMonth);
			
			if(wom == sVo.getRepeat_week() && days[day] != null) {
				if(now_time.isBefore(sVo.getStart_time())) {
					result = 0;
				} else  if(now_time.isAfter(sVo.getEnd_time())) {
					result = 2;
				} else if(now_time.isAfter(sVo.getStart_time()) && now_time.isBefore(sVo.getEnd_time())) {
					result = 1;
				}
			}
			break;
		case 3:
			if(sVo.getRepeat_day() == now.getDayOfMonth()) {
				if(now_time.isBefore(sVo.getStart_time())) {
					result = 0;
				} else  if(now_time.isAfter(sVo.getEnd_time())) {
					result = 2;
				} else if(now_time.isAfter(sVo.getStart_time()) && now_time.isBefore(sVo.getEnd_time())) {
					result = 1;
				}
			}
			break;
		}
		
		return result;
	}
	
	// ScheduleVo 를 넣어주면 연결된 Server들의 현재 상태를 포함한 HashMap을 반환함
	public ArrayList<HashMap<String, Object>> getServerInfo(ArrayList<ScheduleVo> scheduleList){
		
		ArrayList<HashMap<String, Object>> serverInfo = new ArrayList<HashMap<String, Object>>();
		
		for(ServerVo sv : getTotalServer()) {
			HashMap<String, Object> serverData = new HashMap<String, Object>();
			serverData.put("serverVo", sv);
			serverData.put("state", 3);
			serverInfo.add(serverData);
		}
		
		for(ScheduleVo scVo : scheduleList) {
			int state = todaySchedule(scVo);
			
			ArrayList<ServerVo> serverList = ifSqlMapper.selectServerVoByScNo(scVo.getSc_no());
			
			for(ServerVo svVo : serverList) {
				int server_no = svVo.getServer_no();
				System.out.println("server 번호 : " + server_no + ", 서버 상태 : " + state);
				HashMap<String, Object> sv = serverInfo.get(server_no - 1);
				
				if(sv.containsKey("state")) {
					int pre_state = (Integer) sv.get("state");
					
					if(state == 1) {
						sv.put("state", state);
					} else if (state == 0 && pre_state != 1) {
						sv.put("state", state);
					} else if (state == 2) {
						sv.put("state", state);
					}
				} else {
					sv.put("state", state);
				}
			}
		}
		
		return serverInfo;
	}
	
	public ArrayList<HashMap<String, Object>> getScheduleInfo(){
		ArrayList<HashMap<String, Object>> scheduleInfo = new ArrayList<HashMap<String, Object>>();
		
		for(ScheduleVo scVo : getTodaySchedule()) {
			int scState = todaySchedule(scVo);
			
			if(scState != 3) {
				HashMap<String, Object> schedule = new HashMap<String, Object>();
				
				schedule.put("scheduleVo", scVo);
				schedule.put("title", scVo.getTitle());
				schedule.put("start_time", scVo.getStart_time().toString());
				schedule.put("end_time", scVo.getEnd_time().toString());
				schedule.put("state", scState);
				
				scheduleInfo.add(schedule);
			}
		}
		
		return scheduleInfo;
	}
}