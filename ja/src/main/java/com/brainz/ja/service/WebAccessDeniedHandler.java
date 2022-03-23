package com.brainz.ja.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Service;

import com.brainz.ja.vo.UserDetailsVo;

@Service("webAccessDeniedHandler")
public class WebAccessDeniedHandler implements AccessDeniedHandler {

	private static final Logger logger = LoggerFactory.getLogger(WebAccessDeniedHandler.class);
	
	@Override
	public void handle(HttpServletRequest req, HttpServletResponse res, AccessDeniedException ade)
			throws IOException, ServletException {
		res.setStatus(HttpStatus.FORBIDDEN.value());
		
		// String requestUri = req.getRequestURI();
		
		if(ade instanceof AccessDeniedException) {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if (authentication != null &&
					((UserDetailsVo) authentication.getPrincipal()).getAuthorities().contains(new SimpleGrantedAuthority("ROLE_USER"))) 
			{
				req.setAttribute("msg", "접근권한 없는 사용자입니다.");
				req.setAttribute("nextPage", "../user/mainPage");
			} else {
				req.setAttribute("msg", "(로그인 상태) 로그아웃 되었습니다.");
				req.setAttribute("nextPage", "../user/mainPage");
				res.setStatus(HttpStatus.UNAUTHORIZED.value());
				SecurityContextHolder.clearContext();
			}
		} else {
			logger.info(ade.getClass().getCanonicalName());			
		}		
		req.getRequestDispatcher("/ja/login/loginPage").forward(req, res);
	}

}
