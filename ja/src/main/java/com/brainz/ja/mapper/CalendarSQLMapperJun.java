package com.brainz.ja.mapper;

import java.time.LocalDate;
import java.util.ArrayList;

import com.brainz.ja.vo.MgmtVo;
import com.brainz.ja.vo.ScheduleVo;
import com.brainz.ja.vo.ServerVo;
import com.brainz.ja.vo.SetScheduleVo;

public interface CalendarSQLMapperJun {
	public int selectNextScNo();
	public ArrayList<LocalDate> selectDate();
	public ArrayList<ServerVo> selectServer();
	public void insertGood(LocalDate value);
	public ArrayList<ScheduleVo> selectScheduleByMonth(int month);
	public void insertMgmtServer(MgmtVo vo);
	public void insertSchedule(SetScheduleVo ssVo);
}
