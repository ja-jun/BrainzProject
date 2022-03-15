package com.brainz.ja.service;

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

import com.brainz.ja.mapper.CalendarSQLMapperJun;
import com.brainz.ja.vo.MgmtVo;
import com.brainz.ja.vo.ScheduleVo;
import com.brainz.ja.vo.ServerVo;
import com.brainz.ja.vo.SetScheduleVo;

@Service
public class CalendarService {
	
	@Autowired
	private CalendarSQLMapperJun sqlMapper;
	
	// 일정 등록 프로세스
	public void regSchedule(SetScheduleVo ssVo) {
		int sc_no = sqlMapper.selectNextScNo();
		ssVo.setSc_no(sc_no);
		
		sqlMapper.insertSchedule(ssVo);
		
		if(ssVo.getServer_no() != null) {
			for(String server_no : ssVo.getServer_no()) {
				MgmtVo mVo = new MgmtVo();
				mVo.setSc_no(sc_no);
				mVo.setServer_no(Integer.parseInt(server_no));
				
				sqlMapper.insertMgmtServer(mVo);
			}
		}
	}
	
	public ArrayList<HashMap<String, Object>> getScheduleList(int year,int month){
		ArrayList<HashMap<String, Object>> scheduleList = new ArrayList<HashMap<String, Object>>();
		
		// 1. 해당 월에 출력되어야 할 schedule 모두 가져오기
		ArrayList<ScheduleVo> list = sqlMapper.selectScheduleByMonth(month);
		
		for(ScheduleVo vo : list) {
			LocalDate start_date = vo.getStart_date();
			LocalDate end_date = vo.getEnd_date();
			
			// 해당 달의 1일자 날짜 객체를 생성
			LocalDate cur_date = LocalDate.of(year,month,1);
			// 비교하는 날짜가 시작 날짜보다 이후 이거나 종료 날짜보다 이전 이며
			// 해당 달에 속하는 달인 경우에만 실행한다.
			while(cur_date.getMonthValue() == month) {
				if((start_date.isBefore(cur_date) || start_date.equals(cur_date)) && (end_date.isAfter(cur_date) || end_date.equals(cur_date))) {
					String[] dayCheck = {vo.getMon(), vo.getThe(), vo.getWed(), vo.getThu(), vo.getFri(), vo.getSat(), vo.getSun()};
					
					HashMap<String, Object> event = new HashMap<String, Object>();
					
					LocalTime start_time = vo.getStart_time();
					LocalTime end_time = vo.getEnd_time();
					String title = vo.getTitle();
					int sc_no = vo.getSc_no();
					int day = cur_date.getDayOfWeek().getValue() - 1;
					switch (vo.getRepeat_cat()) {
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
				
				// 마지막으로 1일을 더하고 반복
				cur_date = cur_date.plusDays(1);
			}
		}
		return scheduleList;
	}
	
	public ArrayList<ServerVo> getServerList(){
		return sqlMapper.selectServer();
	}
	
	// 특정 스케줄 정보 가져오기
	public ScheduleVo getScheduleInfo(int sc_no) {
		return sqlMapper.selectScheduleByNo(sc_no);
	}
	
	// del_cat = 0 인 경우 해당 스케줄을 과거 미래 내역 모두 삭제
	public void delCat0(int sc_no) {
		sqlMapper.updateDeleteDate(sc_no);
	}
	
	// del_cat = 1 인 경우 해당 날짜의 스케줄만 삭제
	public void delCat1(SetScheduleVo ssVo, String cur_date) {
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		LocalDate current_date = LocalDate.parse(cur_date, dateFormat);
		
		LocalDate pre_date = current_date.minusDays(1);
		LocalDate aft_date = current_date.plusDays(1);
		
		// 기존 schedule을 해당 날짜 -1 일 까지로 end_date를 업데이트
		SetScheduleVo pre_ssVo = ssVo;
		pre_ssVo.setEnd_date(pre_date.format(dateFormat));
		sqlMapper.updateSchedule(pre_ssVo);
		
		// 해당 날짜 다음 날 부터 시작되는 새로운 스케줄을 등록
		SetScheduleVo aft_ssVo = ssVo;
		aft_ssVo.setSc_no(sqlMapper.selectNextScNo());
		aft_ssVo.setStart_date(aft_date.format(dateFormat));
		
		if(aft_ssVo.getServer_no() != null) {
			for(String server_no : ssVo.getServer_no()) {
				MgmtVo mVo = new MgmtVo();
				mVo.setSc_no(aft_ssVo.getSc_no());
				mVo.setServer_no(Integer.parseInt(server_no));
				
				sqlMapper.insertMgmtServer(mVo);
			}
		}
	}
	
	// del_cat = 2 인 경우 해당 날짜 이후만 삭제
	public void delCat2(SetScheduleVo ssVo, String cur_date) {
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		LocalDate current_date = LocalDate.parse(cur_date, dateFormat);
		
		LocalDate pre_date = current_date.minusDays(1);
		
		// 기존 schedule을 해당 날짜 -1 일 까지로 end_date를 업데이트
		SetScheduleVo pre_ssVo = ssVo;
		pre_ssVo.setEnd_date(pre_date.format(dateFormat));
		sqlMapper.updateSchedule(pre_ssVo);
	}
}

