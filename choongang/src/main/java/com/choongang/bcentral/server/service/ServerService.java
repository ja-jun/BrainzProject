package com.choongang.bcentral.server.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.ServerSQLMapper;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.server.vo.ServerVo;

// [서버관리] Service
@Service
public class ServerService {
	
	@Autowired
	private ServerSQLMapper svSQLMapper;
	
	public void insertServer(ServerVo sVo) {
		svSQLMapper.insertServer(sVo);
	}
	
	public ArrayList<ServerVo> getServerList(PageVo pVo){
		ArrayList<ServerVo> serverList = svSQLMapper.getServerList(pVo);
		return serverList;
	}
	
	public int getServerCount(PageVo pVo) {
		return svSQLMapper.getServerCount(pVo);
	}
	
	public ServerVo getServer(int server_no) {
		return svSQLMapper.getServer(server_no);
	}
	
	public void deleteServer(ArrayList<String> nos) {
		for(String no : nos) {
			svSQLMapper.deleteServer(Integer.parseInt(no.trim()));
		}
	}
	
	public void updateServer(ServerVo sVo) {
		svSQLMapper.updateServer(sVo);
	}
	
	public boolean isExistMac(String mac) {
		int count = svSQLMapper.getCountByMac(mac);
		
		if(count > 0) {
			return true;
		} else {
			return false;
		}
	}
}
