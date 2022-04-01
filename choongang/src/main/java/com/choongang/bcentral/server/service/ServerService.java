package com.choongang.bcentral.server.service;

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


import com.choongang.bcentral.mapper.ServerSQLMapper;
import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.server.vo.ServerVo;
import com.google.gson.Gson;

// [서버관리] Service
@Service
public class ServerService {
	
	@Autowired
	private ServerSQLMapper svSQLMapper;
	
	public void insertServer(ServerVo sVo) {
		svSQLMapper.insertServer(sVo);
	}
	
	public ArrayList<ServerVo> getServerList(PageVo pVo){
		ArrayList<ServerVo> serverList = svSQLMapper.getServerList(pVo);
		return serverList;
	}
	
	public int getServerCount(PageVo pVo) {
		return svSQLMapper.getServerCount(pVo);
	}
	
	public ServerVo getServer(int server_no) {
		return svSQLMapper.getServer(server_no);
	}
	
	public void deleteServer(ArrayList<String> nos) {
		for(String no : nos) {
			svSQLMapper.deleteServer(Integer.parseInt(no.trim()));
		}
	}
	
	public void updateServer(ServerVo sVo) {
		svSQLMapper.updateServer(sVo);
	}
	
	public boolean isExistMac(String mac) {
		int count = svSQLMapper.getCountByMac(mac);
		
		if(count > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public int todaySchedule(ScheduleVo sVo){
	      /*   result = 0 : 작업 전
	       *   result = 1 : 작업 중
	       *   result = 2 : 작업 후
	       *   result = 3 : 오늘 작업 없음 */
	      
	      int result = 3;
	      
	      LocalDate now_date = LocalDate.now();
	      LocalTime now_time = LocalTime.now();
	      LocalDateTime now = LocalDateTime.of(now_date, now_time);
	      
	      LocalDateTime start = LocalDateTime.of(sVo.getStart_date(), sVo.getStart_time());
	      LocalDateTime end = LocalDateTime.of(sVo.getEnd_date(), sVo.getEnd_time());
	      
	      String[] days = {sVo.getMon(), sVo.getThe(), sVo.getWed(), sVo.getThu(), sVo.getFri(), sVo.getSat(), sVo.getSun()};
	      int day = now.getDayOfWeek().getValue() - 1; 
	      
	      switch(sVo.getRepeat_cat()) {
	      case 0: //매일하는 작업일 경우
	         if(now_date.isEqual(sVo.getStart_date()) && now_time.isBefore(sVo.getStart_time())) {
	            result = 0;
	         } else if(now_date.isEqual(sVo.getEnd_date()) && now_time.isAfter(sVo.getEnd_time())) {
	            result = 2;
	         } else if(now.isAfter(start) && now.isBefore(end)) {
	            result = 1;
	         }
	         break;
	      case 1: //특정 요일의 작업일 경우
	         if(days[day] != null) { //오늘요일에 스케줄이 있으면
	            if(now_time.isBefore(sVo.getStart_time())) {
	               result = 0;
	            } else  if(now_time.isAfter(sVo.getEnd_time())) {
	               result = 2;
	            } else if(now_time.isAfter(sVo.getStart_time()) && now_time.isBefore(sVo.getEnd_time())) {
	               result = 1;
	            }
	         }
	         break;
	      case 2: //특정 주차의 특정 요일의 작업일 경우
	    	 
	    	  //아마도 틀 인듯? 한주의 시작을 일요일, 달도 그런 일주일 형식으로 설정?
	         WeekFields weekFields = WeekFields.of(DayOfWeek.SUNDAY, 1); //(DayOfWeek firstDayOfWeek, int minimalDaysInFirstWeek?)
	         TemporalField weekOfMonth = weekFields.weekOfMonth(); 
	         
	         int wom = now.get(weekOfMonth); //오늘의 주
	         
	         //반복주는 몇째주인지 저장되어 있는?
	         if(wom == sVo.getRepeat_week() && days[day] != null) { //오늘의 주가 작업반복 주이고, 오늘요일에 작업이 있으면
	            if(now_time.isBefore(sVo.getStart_time())) { 
	               result = 0;
	            } else  if(now_time.isAfter(sVo.getEnd_time())) {
	               result = 2;
	            } else if(now_time.isAfter(sVo.getStart_time()) && now_time.isBefore(sVo.getEnd_time())) {
	               result = 1;
	            }
	         }
	         break;
	      case 3: //매달 특정일에 하는 작업일 경우
	         if(sVo.getRepeat_day() == now.getDayOfMonth()) { //특정일이 오늘 일과 같으면 
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
	      System.out.println(new Gson().toJson(sVo));
	      System.out.println(now + "현재 작업 상태는" + result);
	      return result;
	   }

	public ArrayList<Integer> getScNoListByServerNo(int server_no) {
		return svSQLMapper.getScNoListByServerNo(server_no);
	}
	
	public ScheduleVo getScheduleByScNo(int sc_no) {
		return svSQLMapper.getScheduleByScheduleNo(sc_no);
	}
	
	public ArrayList<Integer> getServerListByServerNo(int sc_no) {
		
		return svSQLMapper.getServerNosByScNo(sc_no);
	}
	
	public ArrayList<HashMap<String, Object>> todayScheduleState(){
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
				
		ArrayList<ScheduleVo> todayScList= svSQLMapper.selectTodaySchedule();
 		for(ScheduleVo sVo : todayScList) {
 	 		HashMap<String, Object> map = new HashMap<String, Object>();
 			int sc_no = sVo.getSc_no();
 			int status = todaySchedule(sVo);
 			ArrayList<Integer> serverNos = svSQLMapper.getServerNosByScNo(sc_no);
 			 			
 			map.put("sc_no", sc_no);
 			map.put("status", status);
 			map.put("serverNos", serverNos);

 			int state = 3;
 			for(int serverNo : serverNos) {
 				ArrayList<Integer> scNos = svSQLMapper.getScNoListByServerNo(serverNo);
 				ArrayList<Integer> stateList = new ArrayList<Integer>();

 				if(scNos == null) {
 					state = 3;
 				} else {
 					for(int scNo : scNos) {
 						ScheduleVo vo= getScheduleByScNo(scNo);
 						int s = todaySchedule(sVo);
 						System.out.println(serverNo + "번 서버의 "+scNo + "번 스케줄의 현재 작업상태 :" +   s);
 						stateList.add(s);	
 					}
 					
 					if(stateList.contains(1)) {
 						state  = 1;
 					} else if(stateList.contains(0)) {
 						state = 0;
 					} else if(stateList.contains(2)) {
 						state = 2;
 					} else {
 						state = 3;
 					}
 				}
 		
 				
 				
 			}
 			
 		}

		return list;
	}
	
	
//	public 
//	ArrayList<HashMap<String, Object>> list = todayScheduleState();
//	
//	for(HashMap<String, Object> map : list) {
//		if(map.get("serverNos") != null) {
//			ArrayList<Integer> nos = (ArrayList<Integer>) map.get("serverNos");
//
//		}
//		
//		
//	}
//	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int getServerState(int server_no){
		int state = 3;
		ArrayList<Integer> scNos= svSQLMapper.getScNoListByServerNo(server_no);
		ArrayList<Integer> stateList = new ArrayList<Integer>();

		if(scNos == null) {
			state = 3;
		} else {
			for(int no : scNos) {
				ScheduleVo sVo= getScheduleByScNo(no);
				int s = todaySchedule(sVo);
				System.out.println(server_no + "번 서버의 "+ no + "번 스케줄의 현재 작업상태 :" +   s);
				stateList.add(s);	
			}

			if(stateList.contains(1)) {
				state  = 1;
			} else if(stateList.contains(0)) {
				state = 0;
			} else if(stateList.contains(2)) {
				state = 2;
			} else {
				state = 3;
			}
		}

		return state;
	}
	
	
	
	
	
}
