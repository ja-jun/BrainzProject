package com.choongang.bcentral.mapper;

import java.util.ArrayList;

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
	public ArrayList<ServerVo> getServerListForExcel(PageVo vo);
}
