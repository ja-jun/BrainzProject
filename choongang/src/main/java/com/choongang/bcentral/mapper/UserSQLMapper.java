package com.choongang.bcentral.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.choongang.bcentral.user.vo.UserVo;


public interface UserSQLMapper {
	
	// ID로 유저 정보 가져오기
	public UserVo selectUser(String username);
	
	// ID로 유저 권한 가져오기
	public ArrayList<String> getAuthList(String username);
	
	// User 등록
	public void registerUser(UserVo vo);
	
	// 사용자 검색
	public ArrayList<UserVo> getUserList(String searchWord);
	
	// 사용자 삭제
	public void deleteUser(int user_no);
	
	// 사용자 수정
	public void updateUser(UserVo vo);
	
	// 사용자 ID 중복검사
	public int getCountById(String user_id);
	
	// 최종 로그인 시간 업데이터
	public void lastLogin(String user_id);
}
