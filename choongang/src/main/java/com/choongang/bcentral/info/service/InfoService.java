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
import com.choongang.bcentral.noti.vo.NotificationVo;
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
	
	// 모든 서버의 정보를 가져옴
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
		
		int curServerSeq = ifSqlMapper.selectCurrentServerVal();
		
		for(int i = 0; i < curServerSeq; i++) {
			serverInfo.add(null);
		}
		
		for(ServerVo sv : getTotalServer()) {
			HashMap<String, Object> serverData = new HashMap<String, Object>();
			serverData.put("serverVo", sv);
			serverData.put("state", 3);
			serverInfo.add(sv.getServer_no() - 1, serverData);
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
		
		serverInfo.remove(null);
		
		return serverInfo;
	}
	
	public ArrayList<HashMap<String, Object>> getWeekScheduleInfo(){
		ArrayList<HashMap<String, Object>> weekScInfo = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<ScheduleVo> weekScVo = ifSqlMapper.selectWeekSchedule();
		
		LocalDate cur_date = LocalDate.now();
		
		while(!cur_date.equals(LocalDate.now().plusDays(7))) {
			
			for(ScheduleVo scVo : weekScVo) {
				HashMap<String, Object> event = new HashMap<String, Object>();
				int sc_no = scVo.getSc_no();
				String title = scVo.getTitle();
				
				LocalDate start_date = scVo.getStart_date();
				LocalDate end_date = scVo.getEnd_date();
				LocalTime start_time = scVo.getStart_time();
				LocalTime end_time = scVo.getEnd_time();
				
				String[] dayCheck = {scVo.getMon(), scVo.getThe(), scVo.getWed(), scVo.getThu(), scVo.getFri(), scVo.getSat(), scVo.getSun()};
				int day = cur_date.getDayOfWeek().getValue() - 1;
				
				switch(scVo.getRepeat_cat()) {
				case 0:
					if(start_date.equals(cur_date)) {
						// cur_date가 시작 날짜인 경우 시작 시간은 작업대로 설정하고 24시 까지 설정
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("start_date", cur_date.toString());
						event.put("end_date", cur_date.toString());
						event.put("start_time", start_time.toString());
						event.put("end_time", "24:00");
					} else if (end_date.equals(cur_date)) {
						// cur_date가 종료 날짜인 경우 시작 시간을 00시로 설정하고 종료 시간을 작업대로 설정
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("start_date", cur_date.toString());
						event.put("end_date", cur_date.toString());
						event.put("start_time", "00:00");
						event.put("end_time", end_time.toString());
					} else {
						// cur_date가 시작 또는 종료 날짜가 아닌 경우 하루 종일을 차지하도록
						// 00시 부터 24시 까지로 설정
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("start_date", cur_date.toString());
						event.put("end_date", cur_date.toString());
						event.put("start_time", "00:00");
						event.put("end_time", "24:00");
					}
					
					weekScInfo.add(event);
					break;
				case 1:
					if(dayCheck[day] != null) {
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("start_date", cur_date.toString());
						event.put("end_date", cur_date.toString());
						event.put("start_time", start_time.toString());
						event.put("end_time", end_time.toString());
						
						weekScInfo.add(event);
					}
					break;
				case 2:
					WeekFields weekFields = WeekFields.of(DayOfWeek.SUNDAY, 1);
					TemporalField weekOfMonth = weekFields.weekOfMonth();
					int wom = cur_date.get(weekOfMonth);
					
					if(wom == scVo.getRepeat_week() && dayCheck[day] != null) {
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("start_date", cur_date.toString());
						event.put("end_date", cur_date.toString());
						event.put("start_time", start_time.toString());
						event.put("end_time", end_time.toString());
						
						weekScInfo.add(event);
					}
					break;
				case 3:
					if(cur_date.getDayOfMonth() == scVo.getRepeat_day()) {
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("start_date", cur_date.toString());
						event.put("end_date", cur_date.toString());
						event.put("start_time", start_time.toString());
						event.put("end_time", end_time.toString());
						
						weekScInfo.add(event);
					}
					break;
				}
				
			}
			cur_date = cur_date.plusDays(1);
		}
		
		return weekScInfo;
	}
	
	
	// 테스트 용
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
	
	public ArrayList<NotificationVo> getNotification(){
		return ifSqlMapper.selectNotification();
	}
}
