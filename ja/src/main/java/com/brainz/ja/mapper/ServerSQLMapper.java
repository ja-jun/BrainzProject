package com.brainz.ja.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;

public interface ServerSQLMapper {

	public ServerVo getServer(int server_no);
	public ArrayList<ServerVo> getServerList(PageVo vo);
	public int getServerCount(PageVo vo);
	public void insertServer(ServerVo vo);
	public void deleteServer(int server_no);
	public void updateServer(ServerVo vo);
	public int getCountByMac(String mac);
	public ArrayList<ServerVo> getServerListForExcel(String searchWord);
	
}
