package com.brainz.ja.mapper;

import java.util.ArrayList;

import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.UserVo;

public interface UserSQLMapper {
	
	public UserVo selectUser(String username);
	
	public ArrayList<String> getAuthList(String username);
	
	public void registerUser(UserVo vo);

	public ArrayList<UserVo> getUserList(PageVo vo);
	
	public int getUserCount(PageVo vo);
	
	public UserVo getUser(int user_no);
	
	public void deleteUser(int user_no);
	
	public void updateUser(UserVo vo);
	
	public int getCountById(String id);
	
	public void lastLogin(String user_id);
}
