package com.choongang.bcentral.schedule.vo;

public class SelectScheduleVo {
	private Integer month;
	private Integer user_no;
	
	public SelectScheduleVo() {
		super();
	}
	
	public SelectScheduleVo(Integer month, Integer user_no) {
		this.month = month;
		this.user_no = user_no;
	}

	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public Integer getUser_no() {
		return user_no;
	}
	public void setUser_no(Integer user_no) {
		this.user_no = user_no;
	}
}
