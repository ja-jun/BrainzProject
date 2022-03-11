
package com.brainz.ja.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
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
		ssVo.setStart_time("16:00:00");
		ssVo.setEnd_time("18:00:00");
		int sc_no = sqlMapper.selectNextScNo();
		ssVo.setSc_no(sc_no);
		
		sqlMapper.insertSchedule(ssVo);
	}
	
	public ArrayList<HashMap<String, Object>> getScheduleList(int year,int month){
		ArrayList<HashMap<String, Object>> scheduleList = new ArrayList<HashMap<String, Object>>();
		
		// 1. 해당 월에 출력되어야 할 schedule 모두 가져오기
		ArrayList<ScheduleVo> list = sqlMapper.selectScheduleByMonth(month);
		
		for(ScheduleVo vo : list) {
			LocalDate start_date = vo.getStart_date();
			LocalDate end_date = vo.getEnd_date();
			int i = 1;
			
			// 해당 달의 1일자 날짜 객체를 생성
			LocalDate cur_date = LocalDate.of(year,month,1);
			System.out.println(vo.getTitle() + "실행했습니다.");
			// 비교하는 날짜가 시작 날짜보다 이후 이거나 종료 날짜보다 이전 이며
			// 해당 달에 속하는 달인 경우에만 실행한다.
			while(cur_date.getMonthValue() == month) {
				if((start_date.isBefore(cur_date) || start_date.equals(cur_date)) && (end_date.isAfter(cur_date) || end_date.equals(cur_date))) {
					System.out.println("실행 " + (i++) + " 번째" + cur_date.toString());
					String[] dayCheck = {vo.getMon(), vo.getThe(), vo.getWed(), vo.getThu(), vo.getFri(), vo.getSat(), vo.getSun()};
					
					HashMap<String, Object> event = new HashMap<String, Object>();
					
					LocalTime start_time = vo.getStart_time();
					LocalTime end_time = vo.getEnd_time();
					String title = vo.getTitle();
					int sc_no = vo.getSc_no();
					int day = cur_date.getDayOfWeek().getValue() - 1;
					System.out.println("repeat_cat : " + vo.getRepeat_cat());
					switch (vo.getRepeat_cat()) {
					case 0:
						System.out.println("0인 경우");
						// 특정 하루만 선택하는 경우
						event.put("sc_no", sc_no);
						event.put("title", title);
						event.put("event_date", cur_date.toString());
						event.put("start_time", start_time.toString());
						event.put("end_time", end_time.toString());
						
						test(event);
						
						scheduleList.add(event);
						break;
					case 1:
						System.out.println("1인 경우 실행은 해봤습니다." + day);
						// 기간 내 특정 요일만 선택하는 경우
						if(dayCheck[day] != null) {
							System.out.println("1인 경우");
							event.put("sc_no", sc_no);
							event.put("title", title);
							event.put("event_date", cur_date.toString());
							event.put("start_time", start_time.toString());
							event.put("end_time", end_time.toString());
							
							test(event);
							
							scheduleList.add(event);
						}
						break;
					case 2:
						// 기간 내 월의 특정 주차에 해당하는 특정 요일만 선택하는 경우
						WeekFields weekFields = WeekFields.of(DayOfWeek.SUNDAY, 1);
						TemporalField weekOfMonth = weekFields.weekOfMonth();
						int wom = cur_date.get(weekOfMonth);
						System.out.println("2인 경우 실행은 해봤습니다." + wom + "주차");
						
						if(wom == vo.getRepeat_week() && dayCheck[day].equals("y")) {
							System.out.println("2인 경우");
							event.put("sc_no", sc_no);
							event.put("title", title);
							event.put("event_date", cur_date.toString());
							event.put("start_time", start_time.toString());
							event.put("end_time", end_time.toString());
							
							test(event);
							
							scheduleList.add(event);
						}
						break;
					case 3:
						// 기간 내 매월 특정 일 등록
						System.out.println("3인 경우 실행은 해봤습니다.");
						if(cur_date.getDayOfMonth() == vo.getRepeat_day()) {
							System.out.println("3인 경우");
							event.put("sc_no", sc_no);
							event.put("title", title);
							event.put("event_date", cur_date.toString());
							event.put("start_time", start_time.toString());
							event.put("end_time", end_time.toString());
							
							test(event);
							
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
	
	public void test(HashMap<String, Object> event) {
		System.out.println(event.get("sc_no"));
		System.out.println(event.get("title"));
		System.out.println(event.get("event_date"));
		System.out.println(event.get("start_time"));
		System.out.println(event.get("end_time"));
	}
	
	public ArrayList<ServerVo> getServerList(){
		return sqlMapper.selectServer();
	}
}

