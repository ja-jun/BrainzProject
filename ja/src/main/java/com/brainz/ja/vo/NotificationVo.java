package com.brainz.ja.vo;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class NotificationVo {
	private Integer nc_no;
	private Integer user_no;
	private String nc_title;
	private String nc_content;
	private Integer nc_readCount;
	@JsonFormat(pattern="yyyy-MM-dd kk:mm:ss")
	private LocalDateTime nc_writeDate;
	private String user_id;
	private String name;
	
	public NotificationVo() {
		super();
	}

	public NotificationVo(Integer nc_no, Integer user_no, String nc_title, String nc_content, Integer nc_readCount,
			LocalDateTime nc_writeDate, String user_id, String name) {
		super();
		this.nc_no = nc_no;
		this.user_no = user_no;
		this.nc_title = nc_title;
		this.nc_content = nc_content;
		this.nc_readCount = nc_readCount;
		this.nc_writeDate = nc_writeDate;
		this.user_id = user_id;
		this.name = name;
	}

	public Integer getNc_no() {
		return nc_no;
	}

	public void setNc_no(Integer nc_no) {
		this.nc_no = nc_no;
	}

	public Integer getUser_no() {
		return user_no;
	}

	public void setUser_no(Integer user_no) {
		this.user_no = user_no;
	}

	public String getNc_title() {
		return nc_title;
	}

	public void setNc_title(String nc_title) {
		this.nc_title = nc_title;
	}

	public String getNc_content() {
		return nc_content;
	}

	public void setNc_content(String nc_content) {
		this.nc_content = nc_content;
	}

	public Integer getNc_readCount() {
		return nc_readCount;
	}

	public void setNc_readCount(Integer nc_readCount) {
		this.nc_readCount = nc_readCount;
	}

	public LocalDateTime getNc_writeDate() {
		return nc_writeDate;
	}

	public void setNc_writeDate(LocalDateTime nc_writeDate) {
		this.nc_writeDate = nc_writeDate;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}	
	
}