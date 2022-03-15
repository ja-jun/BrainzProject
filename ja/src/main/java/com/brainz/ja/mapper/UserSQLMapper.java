package com.brainz.ja.mapper;

import java.util.ArrayList;

import com.brainz.ja.vo.UserVo;

public interface UserSQLMapper {
	
	public UserVo selectUser(String username);
	
	public ArrayList<String> getAuthList(String username);
	
	public void insertUser(UserVo vo);

}
