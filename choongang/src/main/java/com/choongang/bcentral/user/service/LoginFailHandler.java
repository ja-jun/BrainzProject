package com.choongang.bcentral.user.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

@Service("loginFailHandler")
public class LoginFailHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
		
			AuthenticationException exception) throws IOException, ServletException {
		
		if(exception instanceof AuthenticationServiceException) {
			request.setAttribute("LoginFailMessage", "죄송합니다. 시스템에 오류가 발생했습니다.");
		}
		else if(exception instanceof BadCredentialsException) {
			request.setAttribute("LoginFailMessage", "아이디 또는 비밀번호가 틀립니다.");
		}
		else if(exception instanceof DisabledException) {
			request.setAttribute("LoginFailMessage", "비활성화된 계정입니다.");
		}
		else if(exception instanceof LockedException) {
			request.setAttribute("LoginFailMessage", "잠긴 계정입니다.");
		}
		else if(exception instanceof AccountExpiredException) {
			request.setAttribute("LoginFailMessage", "만료된 계정입니다.");
		}
		else if(exception instanceof CredentialsExpiredException) {
			request.setAttribute("LoginFailMessage", "비밀번호가 만료되었습니다.");
		}
		else request.setAttribute("LoginFailMessage", "계정을 찾을 수 없습니다.");
		
		// 로그인 페이지로 다시 포워딩
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login/loginPage");
		dispatcher.forward(request, response);
		
	}

}
