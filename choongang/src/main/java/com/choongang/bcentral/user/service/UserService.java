package com.choongang.bcentral.user.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.UserSQLMapper;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.user.vo.UserPageVo;
import com.choongang.bcentral.user.vo.UserVo;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Service
public class UserService {

	@Autowired
	private UserSQLMapper userSQLMapper;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	AESUtil aes;
	
	// 사용자 등록
	public void registerUser(UserVo vo) throws Exception {
		
		// 비밀번호 단방향 암호화
		String encodedPW = bCryptPasswordEncoder.encode(vo.getUser_pw());
		vo.setUser_pw(encodedPW);
		
		// 개인정보 양방향 암호화
		String encryptphone = aes.encrypt(vo.getPhone());
		vo.setPhone(encryptphone);
		
		String encryptemail = aes.encrypt(vo.getEmail());
		vo.setEmail(encryptemail);

		
		userSQLMapper.registerUser(vo);
	}

	// 사용자관리에 나타날 사용자 목록 출력 및 검색
	public ArrayList<UserVo> getUserList(UserPageVo vo) {
		return userSQLMapper.getUserList(vo);
	}
	
	// 사용자관리에서 검색 했을 때 총 몇건이 출력될 지 값을 리턴
	public int getUserCount(UserPageVo vo) {
		return userSQLMapper.getUserCount(vo);
	}
	
	// 사용자 정보 리턴
	public UserVo getUser(int user_no) {
		return userSQLMapper.getUser(user_no);
	}
	
	public UserVo getUserInfo(String user_id) {
		return userSQLMapper.getUserInfo(user_id);
	}
	
	// 사용자 삭제
	public void deleteUser(ArrayList<String> nos) {
		for(String no  : nos) {
			userSQLMapper.deleteUser(Integer.parseInt(no.trim()));
		}
	}
	
	// 사용자 수정
	public void updateUser(UserVo vo) throws Exception {
		
		// 비밀번호 단방향 암호화
		if(!vo.getUser_pw().equals("")) {
			String encodedPW = bCryptPasswordEncoder.encode(vo.getUser_pw());
			vo.setUser_pw(encodedPW);
		}
		
		// 개인정보 양방향 암호화
		String encryptphone = aes.encrypt(vo.getPhone());
		vo.setPhone(encryptphone);
		
		String encryptemail = aes.encrypt(vo.getEmail());
		vo.setEmail(encryptemail);
			
		userSQLMapper.updateUser(vo);	
	}
	
	//id 중복확인
	public boolean isExistId(String id) {
		int count = userSQLMapper.getCountById(id);
		if(count > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	// 사용자 최종 로그인 시간 업데이트
	public void lastLogin(String user_id) {
		userSQLMapper.lastLogin(user_id);
	}
	
	public ArrayList<UserVo> getTotalUserList(int user_no){
		return userSQLMapper.getTotalUserList(user_no);
	}
}
