package com.brainz.ja.mapper;

import java.util.ArrayList;

import com.brainz.ja.vo.jbUserVo;

public interface jbUserSQLMapper {
	
	public jbUserVo selectUser(String username);
	
	public ArrayList<String> getAuthList(String username);
	
	public void insertUser(jbUserVo vo);

}
