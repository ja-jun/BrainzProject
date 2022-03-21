package com.brainz.ja.vo;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class SetScheduleVo {
	private Integer sc_no;
	private Integer user_no;
	private String title;
	private String start_date;
	private String end_date;
	private String start_time;
	private String end_time;
	private Integer repeat_cat;
	private Integer repeat_day;
	private Integer repeat_week;
	private String mon;
	private String the;
	private String wed;
	private String thu;
	private String fri;
	private String sat;
	private String sun;
	private String delete_date;
	private ArrayList<String> server_no;
	
	public SetScheduleVo() {
		super();
	}

	public SetScheduleVo(Integer sc_no, Integer user_no, String title, String start_date, String end_date,
			String start_time, String end_time, Integer repeat_cat, Integer repeat_day, Integer repeat_week, String mon,
			String the, String wed, String thu, String fri, String sat, String sun, String delete_date,
			ArrayList<String> server_no) {
		super();
		this.sc_no = sc_no;
		this.user_no = user_no;
		this.title = title;
		this.start_date = start_date;
		this.end_date = end_date;
		this.start_time = start_time;
		this.end_time = end_time;
		this.repeat_cat = repeat_cat;
		this.repeat_day = repeat_day;
		this.repeat_week = repeat_week;
		this.mon = mon;
		this.the = the;
		this.wed = wed;
		this.thu = thu;
		this.fri = fri;
		this.sat = sat;
		this.sun = sun;
		this.delete_date = delete_date;
		this.server_no = server_no;
	}

	public Integer getSc_no() {
		return sc_no;
	}
	public void setSc_no(Integer sc_no) {
		this.sc_no = sc_no;
	}

	public Integer getUser_no() {
		return user_no;
	}
	public void setUser_no(Integer user_no) {
		this.user_no = user_no;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDate getStart_date() {
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return LocalDate.parse(this.start_date, dateFormat);
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public LocalDate getEnd_date() {
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return LocalDate.parse(this.end_date, dateFormat);
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public LocalTime getStart_time() {
		DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm");
		return LocalTime.parse(this.start_time, timeFormat);
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public LocalTime getEnd_time() {
		DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm");
		return LocalTime.parse(this.end_time, timeFormat);
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public Integer getRepeat_cat() {
		return repeat_cat;
	}
	public void setRepeat_cat(Integer repeat_cat) {
		this.repeat_cat = repeat_cat;
	}

	public Integer getRepeat_day() {
		return repeat_day;
	}
	public void setRepeat_day(Integer repeat_day) {
		this.repeat_day = repeat_day;
	}

	public Integer getRepeat_week() {
		return repeat_week;
	}
	public void setRepeat_week(Integer repeat_week) {
		this.repeat_week = repeat_week;
	}

	public String getMon() {
		return mon;
	}
	public void setMon(String mon) {
		this.mon = mon;
	}

	public String getThe() {
		return the;
	}
	public void setThe(String the) {
		this.the = the;
	}

	public String getWed() {
		return wed;
	}
	public void setWed(String wed) {
		this.wed = wed;
	}

	public String getThu() {
		return thu;
	}
	public void setThu(String thu) {
		this.thu = thu;
	}

	public String getFri() {
		return fri;
	}
	public void setFri(String fri) {
		this.fri = fri;
	}

	public String getSat() {
		return sat;
	}
	public void setSat(String sat) {
		this.sat = sat;
	}

	public String getSun() {
		return sun;
	}
	public void setSun(String sun) {
		this.sun = sun;
	}

	public String getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(String delete_date) {
		this.delete_date = delete_date;
	}

	public ArrayList<String> getServer_no() {
		return server_no;
	}
	public void setServer_no(ArrayList<String> server_no) {
		this.server_no = server_no;
	}
}
