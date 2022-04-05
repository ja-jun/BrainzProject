package com.choongang.bcentral.schedule.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalField;
import java.time.temporal.WeekFields;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.ScheduleSQLMapper;
import com.choongang.bcentral.schedule.vo.SetScheduleVo;

@Service
public class CheckValidationService {
	
	/* 실행 결과
	 * 0 : 입력한 기간 내에 적어도 1건의 작업이 등록 됨
	 * 1 : 입력한 시작 날짜가 오늘보다 이전의 날짜인 경우
	 * 2 : 입력한 기간 내에 등록되는 작업이 1건도 없는 경우
	 * */
	public int validateScheduleDate(SetScheduleVo ssVo) {		
		String[] dayCheck = {ssVo.getMon(), ssVo.getThe(), ssVo.getWed(), ssVo.getThu(), ssVo.getFri(), ssVo.getSat(), ssVo.getSun()};
		
		LocalDate cur_date = ssVo.getStart_date();
		LocalDate end_date = ssVo.getEnd_date();
		
		if(cur_date.isBefore(LocalDate.now())) {
			return 1;
		}
		
		while(cur_date.isBefore(end_date) || cur_date.isEqual(end_date)) {
			System.out.println("cur_date는  " + cur_date);
			int day = cur_date.getDayOfWeek().getValue() - 1;
			
			switch(ssVo.getRepeat_cat()) {
			case 0:
				return 0;
			case 1:
				if(dayCheck[day] != null) {
					return 0;
				}
				break;
			case 2:
				WeekFields weekFields = WeekFields.of(DayOfWeek.SUNDAY, 1);
				TemporalField weekOfMonth = weekFields.weekOfMonth();
				int wom = cur_date.get(weekOfMonth);
				System.out.println("cur_date는 " + cur_date.getMonthValue() + "월의 " + wom + "주차 입니다.");
				if(wom == ssVo.getRepeat_week() && dayCheck[day] != null) {
					return 0;
				}
				break;
			case 3:
				if(cur_date.getDayOfMonth() == ssVo.getRepeat_day()) {
					return 0;
				}
				break;
			}
			
			cur_date = cur_date.plusDays(1);
		}
		
		return 2;
	}
}
