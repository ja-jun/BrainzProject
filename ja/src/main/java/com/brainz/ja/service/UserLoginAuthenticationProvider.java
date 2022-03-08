package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.brainz.ja.vo.jbUserDetailsVo;

@Service
public class UserLoginAuthenticationProvider  implements AuthenticationProvider{

	@Autowired
	private jbLoginService loginService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// TODO Auto-generated method stub
		
		/* 사용자가 입력한 정보 */
		String userId = authentication.getName();
		String userPw = (String) authentication.getCredentials();		
		
	
		/* DB에서 가져온 정보 (커스터마이징 가능) */
		jbUserDetailsVo userDetails = (jbUserDetailsVo) loginService.loadUserByUsername(userId);		

		
		if (userDetails == null || !userId.equals(userDetails.getUsername())
				|| !bCryptPasswordEncoder.matches(userPw, userDetails.getPassword())) {
			
			throw new BadCredentialsException(userId);
			
		} else if (!userDetails.isAccountNonLocked()) {
			throw new LockedException(userId);

		// 비활성화된 계정일 경우
		} else if (!userDetails.isEnabled()) {
			throw new DisabledException(userId);

		// 만료된 계정일 경우
		} else if (!userDetails.isAccountNonExpired()) {
			throw new AccountExpiredException(userId);

		// 비밀번호가 만료된 경우
		} else if (!userDetails.isCredentialsNonExpired()) {
			throw new CredentialsExpiredException(userId);
		}
		
		
		userDetails.setUser_pw(null);

		/* 최종 리턴 시킬 새로만든 Authentication 객체 */
		Authentication newAuth = new UsernamePasswordAuthenticationToken(
				userDetails, null, userDetails.getAuthorities());
		
		return newAuth;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	

}
