package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.jbUserSQLMapper;
import com.brainz.ja.vo.jbUserVo;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Service
public class jbUserService {

	@Autowired
	private jbUserSQLMapper userSQLMapper;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
	public void register(jbUserVo vo) throws Exception {
		
		// 비밀번호 단방향 암호화
		String encodedPW = bCryptPasswordEncoder.encode(vo.getUser_pw());
		vo.setUser_pw(encodedPW);
	   
		
		// 개인정보 양방향 암호화
		AESUtil aes = new AESUtil();
		String encryptid = aes.encrypt(vo.getUser_id());
		vo.setUser_id(encryptid);
		
		String encryptname = aes.encrypt(vo.getName());
		vo.setName(encryptname);
		
		String encryptphone = aes.encrypt(vo.getPhone());
		vo.setPhone(encryptphone);
		
		String encryptemail = aes.encrypt(vo.getEmail());
		vo.setEmail(encryptemail);

		
		userSQLMapper.insertUser(vo);
	}

}
