package com.brainz.ja.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.brainz.ja.vo.UserVo;

public interface UserSQLMapper {
	
	public UserVo selectUser(String username);
	
	public ArrayList<String> getAuthList(String username);
	
	public void registerUser(UserVo vo);

	public ArrayList<HashMap<String, Object>> getUserList(String searchWord);
	
	public UserVo getUser(int user_no);
		
	
}
