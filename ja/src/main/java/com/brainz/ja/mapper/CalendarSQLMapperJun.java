package com.brainz.ja.mapper;

import java.time.LocalDate;
import java.util.ArrayList;

import com.brainz.ja.vo.MgmtVo;
import com.brainz.ja.vo.ScheduleVo;
import com.brainz.ja.vo.ServerVo;

public interface CalendarSQLMapperJun {
	public int selectNextScNo();
	public void insertSchedule(ScheduleVo vo);
	public ArrayList<LocalDate> selectDate();
	public ArrayList<ServerVo> selectServer();
	public void insertGood(LocalDate value);
	public ArrayList<ScheduleVo> selectScheduleByMonth(int month);
	public void insertMgmtServer(MgmtVo vo);
}
