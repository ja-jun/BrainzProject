package com.brainz.ja.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.SQLMapper;
import com.brainz.ja.vo.CalendarVo;
import com.brainz.ja.vo.TestVo;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Service
public class CalendarService {
	
	@Autowired
	private SQLMapper sqlMapper;
	
	public ArrayList<CalendarVo> getCalendarList() {

		ArrayList<CalendarVo> calendarList = sqlMapper.getCalendarList();
		
		return calendarList;
	}
	
	
	public ArrayList<HashMap<String, Object>> getServerList() {
		ArrayList<HashMap<String, Object>> dataList = sqlMapper.getServerList();
		
		
		return dataList;
	}
	
	
}
