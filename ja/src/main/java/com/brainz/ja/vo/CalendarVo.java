package com.brainz.ja.vo;

import java.sql.Date;
import java.sql.Time;

import org.springframework.format.annotation.DateTimeFormat;

public class CalendarVo {

	private int mgmt_no;
	private int user_no;
	private String title;
	private int period_set;
	private String start_date;
	private String end_date;
	private int no_period_set;
	private int repeat;
	private int repeat_week;
	private int repeat_day;
	private int day;
	private String start_hour;
	private String end_hour;
	private Date write_date;
	
	public CalendarVo() {
		super();
	}

	public CalendarVo(int mgmt_no, int user_no, String title, int period_set, String start_date, String end_date,
			int no_period_set, int repeat, int repeat_week, int repeat_day, int day, String start_hour, String end_hour,
			Date write_date) {
		super();
		this.mgmt_no = mgmt_no;
		this.user_no = user_no;
		this.title = title;
		this.period_set = period_set;
		this.start_date = start_date;
		this.end_date = end_date;
		this.no_period_set = no_period_set;
		this.repeat = repeat;
		this.repeat_week = repeat_week;
		this.repeat_day = repeat_day;
		this.day = day;
		this.start_hour = start_hour;
		this.end_hour = end_hour;
		this.write_date = write_date;
	}

	public int getMgmt_no() {
		return mgmt_no;
	}

	public void setMgmt_no(int mgmt_no) {
		this.mgmt_no = mgmt_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPeriod_set() {
		return period_set;
	}

	public void setPeriod_set(int period_set) {
		this.period_set = period_set;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public int getNo_period_set() {
		return no_period_set;
	}

	public void setNo_period_set(int no_period_set) {
		this.no_period_set = no_period_set;
	}

	public int getRepeat() {
		return repeat;
	}

	public void setRepeat(int repeat) {
		this.repeat = repeat;
	}

	public int getRepeat_week() {
		return repeat_week;
	}

	public void setRepeat_week(int repeat_week) {
		this.repeat_week = repeat_week;
	}

	public int getRepeat_day() {
		return repeat_day;
	}

	public void setRepeat_day(int repeat_day) {
		this.repeat_day = repeat_day;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public String getStart_hour() {
		return start_hour;
	}

	public void setStart_hour(String start_hour) {
		this.start_hour = start_hour;
	}

	public String getEnd_hour() {
		return end_hour;
	}

	public void setEnd_hour(String end_hour) {
		this.end_hour = end_hour;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	
	
}
