package com.choongang.bcentral.schedule.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalField;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.ScheduleSQLMapper;
import com.choongang.bcentral.schedule.vo.MgmtVo;
import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.schedule.vo.SetScheduleVo;
import com.choongang.bcentral.server.vo.ServerVo;

// [작업관리] 서비스
@Service
public class ScheduleService {
	
	@Autowired
	private ScheduleSQLMapper scSqlMapper;
	
	// 일정 등록 프로세스
	public void regSchedule(SetScheduleVo ssVo) {
		int sc_no = scSqlMapper.selectNextScNo();
		
		ssVo.setSc_no(sc_no);
		
		if(ssVo.getServer_no() != null) {
			for(String server_no : ssVo.getServer_no()) {
				MgmtVo mVo = new MgmtVo();
				mVo.setSc_no(sc_no);
				mVo.setServer_no(Integer.parseInt(server_no));
				
				scSqlMapper.insertMgmtServer(mVo);
			}
		}
		
		scSqlMapper.insertSchedule(ssVo);
	}
	
	// 일정 수정 프로세스
	public void modSchedule(SetScheduleVo ssVo) {
		scSqlMapper.updateSchedule(ssVo);
		
		if(ssVo.getServer_no() != null) {
			scSqlMapper.deleteMgmtScNo(ssVo.getSc_no());
			
			for(String server_no : ssVo.getServer_no()) {
				MgmtVo mVo = new MgmtVo();
				mVo.setSc_no(ssVo.getSc_no());
				mVo.setServer_no(Integer.parseInt(server_no));
				
				scSqlMapper.insertMgmtServer(mVo);
			}
		}
	}
	
	// 해당 달에 출력되야 할 이벤트 작성
	public ArrayList<HashMap<String, Object>> getScheduleList(int year, int month){
		ArrayList<HashMap<String, Object>> scheduleList = new ArrayList<HashMap<String, Object>>();
		
		// 1. 해당 월에 출력되야 할 Schedule 모두 가져오기
		ArrayList<ScheduleVo> list = scSqlMapper.selectScheduleByMonth(month);
		
		for(ScheduleVo vo : list) {
			LocalDate start_date = vo.getStart_date();
			LocalDate end_date = vo.getEnd_date();
			
			LocalDate cur_date = LocalDate.of(year, month, 1);
			
			while(cur_date.getMonthValue() == month) {
				if((start_date.isBefore(cur_date) || start_date.equals(cur_date)) && (end_date.isAfter(cur_date) || end_date.equals(cur_date))) {
					HashMap<String, Object> event = new HashMap<String, Object>();
					
					String[] dayCheck = {vo.getMon(), vo.getThe(), vo.getWed(), vo.getThu(), vo.getFri(), vo.getSat(), vo.getSun()};
					
					LocalTime start_time = vo.getStart_time();
					LocalTime end_time = vo.getEnd_time();
					
					String title = vo.getTitle();
					
					int sc_no = vo.getSc_no();
					int day = cur_date.getDayOfWeek().getValue() - 1;
					
					switch(vo.getRepeat_cat()) {
					case 0:
						// 특정 하루만 선택하는 경우
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("event_date", cur_date.toString());
						event.put("start_time", start_time.toString());
						event.put("end_time", end_time.toString());
						
						scheduleList.add(event);
						break;
					case 1:
						// 기간 내 특정 요일만 선택하는 경우
						if(dayCheck[day] != null) {
							event.put("sc_no", sc_no);
							event.put("title", title);
							event.put("event_date", cur_date.toString());
							event.put("start_time", start_time.toString());
							event.put("end_time", end_time.toString());
							
							scheduleList.add(event);
						}
						break;
					case 2:
						// 기간 내 월의 특정 주차에 해당하는 특정 요일만 선택하는 경우
						WeekFields weekFields = WeekFields.of(DayOfWeek.SUNDAY, 1);
						TemporalField weekOfMonth = weekFields.weekOfMonth();
						int wom = cur_date.get(weekOfMonth);
						
						if(wom == vo.getRepeat_week() && dayCheck[day] != null) {
							event.put("sc_no", sc_no);
							event.put("title", title);
							event.put("event_date", cur_date.toString());
							event.put("start_time", start_time.toString());
							event.put("end_time", end_time.toString());
							
							scheduleList.add(event);
						}
						break;
					case 3:
						// 기간 내 매월 특정 일 등록
						if(cur_date.getDayOfMonth() == vo.getRepeat_day()) {
							event.put("sc_no", sc_no);
							event.put("title", title);
							event.put("event_date", cur_date.toString());
							event.put("start_time", start_time.toString());
							event.put("end_time", end_time.toString());
							
							scheduleList.add(event);
						}
						break;
					}
				}
				
				cur_date = cur_date.plusDays(1);
			}
		}
	
		return scheduleList;
	}
	
	// 작업 등록 창에서 서버 추가 클릭 시 나타날 모든 서버 리스트 출력
	public ArrayList<ServerVo> getServerList(){
		return scSqlMapper.selectServer();
	}
	
	// 특정 이벤트 클릭 시 해당 스케줄 정보 가져오기
	public ScheduleVo getScheduleInfo(int sc_no) {
		return scSqlMapper.selectScheduleByNo(sc_no);
	}
	
	public ArrayList<ServerVo> getServerList(int sc_no){
		return scSqlMapper.selectServerByScNo(sc_no);
	}
	
	// del_cat = 0 인 경우 해당 스케줄을 과거 미래 내역 모두 삭제
	public void delCat0(int sc_no) {
		scSqlMapper.updateDeleteDate(sc_no);
	}
	
	// del_cat = 1 인 경우 해당 날짜의 스케줄만 삭제
	public void delCat1(SetScheduleVo ssVo, String cur_date) {
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate current_date = LocalDate.parse(cur_date, dateFormat);
		
		LocalDate pre_date = current_date.minusDays(1);
		LocalDate aft_date = current_date.plusDays(1);
		
		LocalDate start_date = ssVo.getStart_date();
		LocalDate end_date = ssVo.getEnd_date();
		
		// 기존 schedule을 해당 날짜 -1 일 까지로 end_date를 업데이트
		SetScheduleVo pre_ssVo = ssVo;
		pre_ssVo.setStart_date(start_date.format(dateFormat));
		pre_ssVo.setEnd_date(pre_date.format(dateFormat));
		scSqlMapper.updateSchedule(pre_ssVo);
		
		// 해당 날짜 다음 날 부터 시작되는 새로운 스케줄을 등록
		SetScheduleVo aft_ssVo = ssVo;
		
		int aft_sc_no = scSqlMapper.selectNextScNo();
		aft_ssVo.setSc_no(aft_sc_no);
		aft_ssVo.setStart_date(aft_date.format(dateFormat));
		aft_ssVo.setEnd_date(end_date.format(dateFormat));
		
		if(aft_ssVo.getServer_no() != null) {
			for(String server_no : ssVo.getServer_no()) {
				MgmtVo mVo = new MgmtVo();
				mVo.setSc_no(aft_ssVo.getSc_no());
				mVo.setServer_no(Integer.parseInt(server_no));
				
				scSqlMapper.insertMgmtServer(mVo);
			}
		}
		
		scSqlMapper.insertSchedule(aft_ssVo);
	}
	
	// del_cat = 2 인 경우 해당 날짜 이후만 삭제
	public void delCat2(SetScheduleVo ssVo, String cur_date) {
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate current_date = LocalDate.parse(cur_date, dateFormat);
		
		LocalDate pre_date = current_date.minusDays(1);
		
		// 기존 schedule을 해당 날짜 -1 일 까지로 end_date를 업데이트
		SetScheduleVo pre_ssVo = ssVo;
		pre_ssVo.setEnd_date(pre_date.format(dateFormat));
		scSqlMapper.updateSchedule(pre_ssVo);
	}
	
	// 작업명 중복체크
	public boolean isExistTitle(String title) {
			
		int count = scSqlMapper.selectCountByTitle(title);
			
		if(count > 0) {
			return true;
		}else {
			return false;
		}
	}
}
