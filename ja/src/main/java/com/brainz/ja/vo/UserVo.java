package com.brainz.ja.vo;

import java.time.LocalDateTime;

public class UserVo {
	private int user_no;
	private String user_id;
	private String user_pw;
	private String name;
	private String email;
	private String phone;
	private String dec;
	private LocalDateTime write_date;
	
	public UserVo() {
		super();
	}
	
	public UserVo(int user_no, String user_id, String user_pw, String name, String email, String phone, String dec,
			LocalDateTime write_date) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.dec = dec;
		this.write_date = write_date;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDec() {
		return dec;
	}
	public void setDec(String dec) {
		this.dec = dec;
	}
	public LocalDateTime getWrite_date() {
		return write_date;
	}
	public void setWrite_date(LocalDateTime write_date) {
		this.write_date = write_date;
	}
}
