package com.choongang.bcentral.server.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;

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
		System.out.println("mac검사중************************************************************");
		if(count > 0) {
			return true; //같은 mac이 존재하면 true
		} else {
			return false; //아니면 false
		}
	}
	
	public boolean isExistMacwithServerNo(String mac, int server_no) {
		int count = svSQLMapper.getCountByMacWithServerNo(mac,server_no);
		
		if(count > 0) {
			return true; //내서버번호와 다른 서버에 같은 mac이 존재하면 true
		} else {
			return false; //아니면 false
		}
	}
	
//	public boolean formMac(String mac) {
//		if(!Pattern.matches("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", mac) ) {
//			return false; //형식에 맞지 않으면 false
//		} else {
//			return true; //아니면 true
//		}
//	}
	
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
	    	 
	         int wom = ((now_date.getDayOfMonth() - 1) / 7) + 1;
	         
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
//	      System.out.println(new Gson().toJson(sVo));
//	      System.out.println(now + "현재 작업 상태는" + result);
	      return result;
	   }

	public String getServerState (int server_no){
		ArrayList<ScheduleVo> scList = svSQLMapper.selectTodaySchedule(server_no);
		ArrayList<Integer> stateList = new ArrayList<Integer>();

		String status = "3";
		
		for(ScheduleVo sc : scList ) {
			int state = todaySchedule(sc);
			System.out.println(new Gson().toJson(sc) + " 의 상태는 ::: " + state);
			stateList.add(state);
		}
		
		if(stateList.contains(1)) {
			status  = "1";
		} else if(stateList.contains(0)) {
			status = "0";
		} else if(stateList.contains(2)) {
			status = "2";
		} else {
			status = "3";
		}			
		return status;
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
	

	public  ArrayList<ServerVo> getServerListByStatus (PageVo pVo ,String status) {
		ArrayList<ServerVo> serverList = svSQLMapper.getServerListByStatus(pVo);
		ArrayList<ServerVo> serverListByStatus = new ArrayList<ServerVo>();
	
		if(status == "") {
			serverListByStatus = serverList;
			for(ServerVo vo : serverList) {
				int server_no = vo.getServer_no();
				String s = getServerState(server_no);
				vo.setStatus(s);		
			}
		} else {
			for(ServerVo vo : serverList) {
				int server_no = vo.getServer_no();
				
				if(getServerState(server_no).equals(status)) {
					String s = getServerState(server_no);
					vo.setStatus(s);			
					serverListByStatus.add(vo);
				}
			}
		}
		System.out.println("선택한 상태 서버리스트의 사이즈는 " + serverListByStatus.size());
		return serverListByStatus;
	}


	
	
	
	
}
