package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.jbUserSQLMapper;
import com.brainz.ja.vo.jbUserDetailsVo;
import com.brainz.ja.vo.jbUserVo;

@Service("loginService")
public class jbLoginService implements UserDetailsService {

	@Autowired
	private jbUserSQLMapper userSQLMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException  {
		
		// 최종적으로 리턴해야할 객체
		jbUserDetailsVo userDetails = new jbUserDetailsVo();

		// 사용자 정보 select
		jbUserVo userVo = userSQLMapper.selectUser(username);

		// 사용자 정보 없으면 null 처리
		if (userVo == null) {
			return null;

		// 사용자 정보 있을 경우 로직 전개 (userDetails에 데이터 넣기)
		} else {
			userDetails.setUser_id(userVo.getUser_id());
			userDetails.setUser_pw(userVo.getUser_pw());

			// 사용자 권한 select해서 받아온 List<String> 객체 주입
			userDetails.setAuthority(userSQLMapper.getAuthList(username));
		}
		
		System.out.println("유저아이디 : " + username);

		return userDetails;
	}
		
	
}
