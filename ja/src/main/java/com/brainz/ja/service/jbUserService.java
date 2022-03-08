package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.jbUserSQLMapper;
import com.brainz.ja.vo.jbUserVo;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
@Service
public class jbUserService {
	
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
	@Autowired
	private jbUserSQLMapper userSQLMapper;
	
	public void register(jbUserVo vo) {
		
		String encodedPW = bCryptPasswordEncoder.encode(vo.getUser_pw());
		vo.setUser_pw(encodedPW);
		
		userSQLMapper.insertUser(vo);
	}

	
}
