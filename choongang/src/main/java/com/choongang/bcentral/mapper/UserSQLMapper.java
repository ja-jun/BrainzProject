package com.choongang.bcentral.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.user.vo.UserPageVo;
import com.choongang.bcentral.user.vo.UserVo;


public interface UserSQLMapper {
	
	// ID로 유저 정보 가져오기
	public UserVo selectUser(String username);
	
	// ID로 유저 권한 가져오기
	public ArrayList<String> getAuthList(String username);
	
	// User 등록
	public void registerUser(UserVo vo);
	
	// 사용자 검색 getUserCount >> 검색 했을 때 총 몇건의 row가 있는지 확인
	public ArrayList<UserVo> getUserList(UserPageVo vo);
	public int getUserCount(UserPageVo vo);
	
	// 사용자 정보 가져오기
	public UserVo getUser(int user_no);
	public UserVo getUserInfo(String user_id);
	
	// 사용자 정보 삭제하기
	public void deleteUser(int user_no);
	
	// 사용자 정보 수정하기
	public void updateUser(UserVo vo);
	
	// 사용자 ID 중복검사
	public int getCountById(String id);
	
	// 마지막 로그인 시간 업데이트
	public void lastLogin(String user_id);
	
	// 해당 사용자가 조회할 수 있는 유저 목록을 가져 옴
	public ArrayList<UserVo> getTotalUserList(int user_no);
	
	// 사용자 삭제로 인한 작업 담당자 변경
	public void updateScheduleManager(HashMap<String, Integer> map);
}
