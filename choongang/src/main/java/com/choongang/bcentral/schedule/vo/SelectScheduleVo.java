package com.choongang.bcentral.schedule.vo;

public class SelectScheduleVo {
	private Integer year;
	private Integer month;
	private Integer user_no;
	
	public SelectScheduleVo() {
		super();
	}
	
	public SelectScheduleVo(Integer year, Integer month, Integer user_no) {
		this.year = year;
		this.month = month;
		this.user_no = user_no;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public String getMonth() {
		String newMonth;
		if(month < 10) {
			newMonth = '0' + month.toString();	
		} else {
			newMonth = month.toString();
		}
		return newMonth;
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
