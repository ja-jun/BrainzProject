package com.brainz.ja.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.brainz.ja.vo.UserVo;

public interface UserSQLMapper {
	
	public UserVo selectUser(String user_id);
	
	public ArrayList<String> getAuthList(String user_id);
	
	public void registerUser(UserVo vo);

	public ArrayList<HashMap<String, Object>> getUserList(String searchWord);
	
	public UserVo getUser(int user_no);
	
	public void deleteUser(int user_no);
	
	public void updateUser(UserVo vo);
	
	public int getCountById(String id);
		
    public void lastLogin(String user_id);

}
