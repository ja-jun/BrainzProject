package com.choongang.bcentral.user.vo;

import java.time.LocalDateTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class UserVo {
	
	private int user_no;
	private String user_id;
	private String user_pw;
	private String name;
	private String authority;
	private String phone;
	private String email;
	private String dsc;
	@JsonFormat(pattern="yyyy-MM-dd kk:mm:ss")
	private LocalDateTime write_date;
	@JsonFormat(pattern="yyyy-MM-dd kk:mm:ss")
	private LocalDateTime last_login;
	private int parent;
	
	private UserVo() {
		super();
	}

	private UserVo(int user_no, String user_id, String user_pw, String name, String authority, String phone,
			String email, String dsc, LocalDateTime write_date, LocalDateTime last_login, int parent) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.name = name;
		this.authority = authority;
		this.phone = phone;
		this.email = email;
		this.dsc = dsc;
		this.write_date = write_date;
		this.last_login = last_login;
		this.parent = parent;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDsc() {
		return dsc;
	}

	public void setDsc(String dsc) {
		this.dsc = dsc;
	}

	public LocalDateTime getWrite_date() {
		return write_date;
	}

	public void setWrite_date(LocalDateTime write_date) {
		this.write_date = write_date;
	}

	public LocalDateTime getLast_login() {
		return last_login;
	}

	public void setLast_login(LocalDateTime last_login) {
		this.last_login = last_login;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}
	
}
