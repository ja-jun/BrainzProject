package com.choongang.bcentral.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.choongang.bcentral.schedule.vo.ScheduleVo;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.server.vo.ServerVo;

public interface ServerSQLMapper {
	public ServerVo getServer(int server_no);
	public ArrayList<ServerVo> getServerList(PageVo vo);
	public int getServerCount(PageVo vo);
	public void insertServer(ServerVo vo);
	public void deleteServer(int server_no);
	public void updateServer(ServerVo vo);
	public int getCountByMac(String mac);
	public int getCountByMacWithServerNo(@Param("mac") String mac,@Param("server_no") int server_no);
	public ArrayList<ServerVo> getServerListForExcel(PageVo vo);


	//등록된 기간에 오늘날짜가 포함되는 schedule의 모든 정보를 받아옴
	public ArrayList<ScheduleVo> selectTodaySchedule(int server_no); 
	
	//서버번호로 작업에 등록된 스케줄번호리스트 받아오기
	public ArrayList<Integer> getScNoListByServerNo(int server_no);

	//스케줄번호로 스케줄vo 받아오기
	public ScheduleVo getScheduleByScheduleNo(int sc_no);

	
	//등록된 스케줄의 서버번호리스트 받기
	public ArrayList<Integer> getServerNosByScNo(int sc_no);
	
	//상태별로 서버리스트 받기 - 상태로 보는 서버리스트는 페이지마다 쿼리로 가져올 수 없으므로 전부 가져와야함...
	public ArrayList<ServerVo> getServerListByStatus(PageVo vo);
	

}
