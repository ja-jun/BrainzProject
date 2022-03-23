package com.brainz.ja.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.ServerSQLMapper;
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;

@Service
public class ServerService {
	
	@Autowired
	private ServerSQLMapper serverSQLMapper;
	
	public void insertServer(ServerVo vo) {
		serverSQLMapper.insertServer(vo);
	}
	
	public ArrayList<ServerVo> getServerList(PageVo vo) {
		
		ArrayList<ServerVo> serverList = serverSQLMapper.getServerList(vo);
		
		//상태항목- 작업관리에서 가져와서 정상/작업중을 추가하여 
		//arraylist<hashmap<s,o>>를 만들어 리턴할 것인지 
				
		return serverList;
		}
	
	public int getServerCount(PageVo vo) {
		return serverSQLMapper.getServerCount(vo);
	}
	
	
	public ServerVo getServer(int server_no) {
		ServerVo serverVo = serverSQLMapper.getServer(server_no);
		
		return serverVo;
	}
	
	public void deleteServer(List<String> nos) {
		
		for(String no  : nos) {
			serverSQLMapper.deleteServer(Integer.parseInt(no.trim()));
		}
		
	}
	
	public void updateServer(ServerVo vo) {
		serverSQLMapper.updateServer(vo);	
	}

	//mac 중복확인
	public boolean isExistMac(String mac) {
		int count = serverSQLMapper.getCountByMac(mac);
		if(count>0) {
			return true;
		} else {
			return false;
		}
	}
	

	
		
	
	
	
	
	
}