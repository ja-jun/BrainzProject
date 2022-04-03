package com.choongang.bcentral.user.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.UserSQLMapper;

@Service("LoginSuccessHandler")
public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	
	@Autowired
	UserSQLMapper userSQLMapper;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, 
										HttpServletResponse response,
										Authentication auth) throws IOException, ServletException {
		HttpSession session = request.getSession();
		
		String user_id = auth.getName();
		
		// 로그인 성공 시 유저 마지막 로그인 시간 업데이트
		userSQLMapper.lastLogin(user_id);
		
		
		// 로그인 성공 시 session에 유저 정보 담기
		session.setAttribute("userInfo", userSQLMapper.selectUser(user_id));
		
		response.sendRedirect("/choongang/info/mainPage");
	}
}
