package com.brainz.ja.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.ServerSQLMapper;
import com.brainz.ja.vo.ServerVo;

@Service
public class ServerService {
	
	@Autowired
	private ServerSQLMapper serverSQLMapper;
	
	public void insertServer(ServerVo vo) {
		serverSQLMapper.insertServer(vo);
	}
	
	public ArrayList<HashMap<String, Object>> getServerList(String searchWord) {
		ArrayList<HashMap<String, Object>>  serverList = serverSQLMapper.getServerList(searchWord);
		
		//상태항목- 작업관리에서 가져와서 정상/작업중을 추가하여 
		//arraylist<hashmap<s,o>>를 만들어 리턴할 것인지 
				
		return serverList;
		}
	
	public ServerVo getServer(int server_no) {
		ServerVo serverVo = serverSQLMapper.getServer(server_no);
		
		return serverVo;
	}
	
	public void deleteServer(int server_no) {
		serverSQLMapper.deleteServer(server_no);
	}
	
	public void updateServer(ServerVo vo) {
		serverSQLMapper.updateServer(vo);	
	}
	
		
	
	
	
	
	
}