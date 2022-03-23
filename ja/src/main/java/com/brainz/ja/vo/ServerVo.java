package com.brainz.ja.vo;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ServerVo {
	private Integer server_no;
	private Integer user_no;
	private String name;
	private String ip;
	private String os;
	private String loc;
	private String mac;
	private String control_num;
	private String dsc;
	@JsonFormat(pattern="yyyy-MM-dd kk:mm:ss")
	private LocalDateTime write_date;
	
	public ServerVo() {
		super();
	}

	public ServerVo(int server_no, int user_no, String name, String ip, String os, String loc, String mac,
			String control_num, String dsc, LocalDateTime write_date) {
		super();
		this.server_no = server_no;
		this.user_no = user_no;
		this.name = name;
		this.ip = ip;
		this.os = os;
		this.loc = loc;
		this.mac = mac;
		this.control_num = control_num;
		this.dsc = dsc;
		this.write_date = write_date;
	}

	public int getServer_no() {
		return server_no;
	}

	public void setServer_no(int server_no) {
		this.server_no = server_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getControl_num() {
		return control_num;
	}

	public void setControl_num(String control_num) {
		this.control_num = control_num;
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

	
	
}