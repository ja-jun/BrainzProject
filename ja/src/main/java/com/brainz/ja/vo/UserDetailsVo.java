package com.brainz.ja.vo;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserDetailsVo implements UserDetails {

	private String user_id;
	private String user_pw;
	private ArrayList<GrantedAuthority> authority;

	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authority;
	}
	
	public void setAuthority(ArrayList<String> authList) {
		ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		for(int i=0;i<authList.size();i++) {
			auth.add(new SimpleGrantedAuthority(authList.get(i)));
		}
		this.authority=auth;
	}

	@Override
	public String getPassword() {
		return user_pw;
	}

	@Override
	public String getUsername() {
		return user_id;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	@Override
	public boolean isEnabled() {
		return true;
	}
	
	

}
