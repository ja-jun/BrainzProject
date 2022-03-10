package com.brainz.ja.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.brainz.ja.vo.ServerVo;

public interface ServerSQLMapper {

	public ServerVo getServer(int server_no);
	public ArrayList<HashMap<String, Object>> getServerList(String searchWord);
	public void insertServer(ServerVo vo);
	public void deleteServer(int server_no);
	public void updateServer(ServerVo vo);
	public void test();

	
	
}
