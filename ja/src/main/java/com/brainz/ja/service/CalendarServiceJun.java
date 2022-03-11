package com.brainz.ja.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.CalendarSQLMapperJun;
import com.brainz.ja.vo.ScheduleVo;
import com.brainz.ja.vo.ServerVo;
import com.brainz.ja.vo.SetScheduleVo;

@Service
public class CalendarServiceJun {
	
	@Autowired
	private CalendarSQLMapperJun sqlMapper;
	
	// 선택된 요일에 넣는 Method
	public void regWeekExList(ScheduleVo sVo, int monthVal) {
		LocalDate start_date = sVo.getStart_date();
		LocalDate end_date = sVo.getEnd_date();
		LocalTime start_time = sVo.getStart_time();
		LocalTime end_time = sVo.getEnd_time();
		
		long days = ChronoUnit.DAYS.between(start_date, end_date);
		
		String[] dayList = {sVo.getMon(), sVo.getThe(), sVo.getWed(), sVo.getThu(), sVo.getFri(), sVo.getSat(), sVo.getSun()};
		
		for(int i = 0; i < days; i++) {
			LocalDate cur_date = start_date.plusDays(i);
			LocalDate now = LocalDate.now();
			
			int day = cur_date.getDayOfWeek().getValue();
			
			// 등록될 날짜 기준으로 monthVal 보다 작은 날짜만 등록
			int monthChk = cur_date.getMonthValue() - now.getMonthValue();
			
			if(monthChk > monthVal) {
				break;
			} else if(end_date.isBefore(cur_date)) {
				break;
			} else if(dayList[day - 1] == "y") {
			} else {
				continue;
			}
		}
	}
	
	// 매달 지정된 날짜에 넣는 Method
	public void regMonthExList(ScheduleVo sVo, int monthVal) {
		// 등록 시점 날짜 확인
		LocalDate now = LocalDate.now();
		
		LocalDate start_date = sVo.getStart_date();
		LocalDate end_date = sVo.getEnd_date();
		LocalTime start_time = sVo.getStart_time();
		LocalTime end_time = sVo.getEnd_time();
		
		int monthChk = start_date.getMonthValue() - now.getMonthValue();
		
		LocalDate target_date = LocalDate.of(start_date.getYear(), start_date.getMonth(), sVo.getRepeat_day());
		if(now.isBefore(end_date)) {
			if(sVo.getRepeat_day() >= now.getDayOfMonth()) {
			} 
			
			for(int i = 1; i < monthVal - monthChk; i++) {
				
			}
		}
	}
	public ArrayList<ServerVo> getServerList(){
		return sqlMapper.selectServer();
	}
	
	public void insertSchedule(SetScheduleVo ssVo) {
		
	}
}
