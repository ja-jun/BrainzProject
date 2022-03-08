package com.brainz.ja.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.brainz.ja.vo.CalendarVo;
import com.brainz.ja.vo.TestVo;

public interface SQLMapper {
	public void test();
	
	
	public int createCalendarPk();
	
	public void insertCalendar(CalendarVo vo);
	
	public ArrayList<CalendarVo> getCalendarList();
	
	public ArrayList<HashMap<String, Object>> getServerList();
}
