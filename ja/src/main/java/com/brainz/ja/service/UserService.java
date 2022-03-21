package com.brainz.ja.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.UserSQLMapper;
import com.brainz.ja.vo.UserVo;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Service
public class UserService {

	@Autowired
	private UserSQLMapper userSQLMapper;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	AESUtil aes;
	
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

	public ArrayList<HashMap<String, Object>> getUserList(String searchWord) {
		ArrayList<HashMap<String, Object>>  userList = userSQLMapper.getUserList(searchWord);
		
		//상태항목- 작업관리에서 가져와서 정상/작업중을 추가하여 
		//arraylist<hashmap<s,o>>를 만들어 리턴할 것인지 
				
		return userList;
		}
	
	public UserVo getUser(int user_no) {
		UserVo userVo = userSQLMapper.getUser(user_no);
		
		return userVo;
	}
	
	public void deleteUser(String [] user_no) {
		
		for(String no  : user_no) {
			userSQLMapper.deleteUser(Integer.parseInt(no.trim()));
		}
		
	}
	
	public void updateUser(UserVo vo) {
		userSQLMapper.updateUser(vo);	
	}
	
	//id 중복확인
	public boolean isExistId(String id) {
		int count = userSQLMapper.getCountById(id);
		if(count>0) {
			return false;
		} else {
			return true;
		}
	}
	
	
	
	
}
