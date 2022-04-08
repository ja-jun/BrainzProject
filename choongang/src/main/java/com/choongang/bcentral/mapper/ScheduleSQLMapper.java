package com.choongang.bcentral.mapper;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestParam;

import com.choongang.bcentral.schedule.vo.MgmtVo;
import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.schedule.vo.SelectScheduleVo;
import com.choongang.bcentral.schedule.vo.SetScheduleVo;
import com.choongang.bcentral.server.vo.ServerVo;

public interface ScheduleSQLMapper {
	
	// Schedule 추가를 위한 Query
	public int selectNextScNo();
	public void insertSchedule(SetScheduleVo ssVo);
	public void insertMgmtServer(MgmtVo mVo);
	
	// Schedule 등록 시 서버 목록 출력
	public ArrayList<ServerVo> selectServer();
	
	// 등록된 스케줄 중 해당하는 달에 맞는 스케줄 가져오기
	public ArrayList<ScheduleVo> selectScheduleByMonth(SelectScheduleVo sscVo);
	
	// 특정 이벤트 클릭 시 Schedule 정보 입력
	public ScheduleVo selectScheduleByNo(int sc_no);
	public ArrayList<ServerVo> selectServerByScNo(int sc_no);
	
	// 이벤트 삭제 시 해당 스케줄에 삭제 날짜 입력
	public void updateDeleteDate(int sc_no);
	public void deleteMgmtScNo(int sc_no);
	
	// 이벤트 수정
	public void updateSchedule(SetScheduleVo ssVo);
	
	// 작업명 중복검사
	public int selectCountByTitle(String title);
}
