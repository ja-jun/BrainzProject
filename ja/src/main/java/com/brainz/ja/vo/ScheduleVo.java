package com.brainz.ja.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ScheduleVo {
	private Integer sc_no;
	private Integer user_no;
	private String title;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private LocalDate start_date;
	@JsonFormat(pattern = "kk:mm")
	private LocalTime start_time;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private LocalDate end_date;
	@JsonFormat(pattern = "kk:mm")
	private LocalTime end_time;
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
	@JsonFormat(pattern = "yyyy-MM-dd kk:mm")
	private LocalDateTime write_date;
	@JsonFormat(pattern = "yyyy-MM-dd kk:mm")
	private LocalDateTime delete_date;
	
	public ScheduleVo() {
		super();
	}
	
	public ScheduleVo(Integer sc_no, Integer user_no, String title, LocalDate start_date, LocalTime start_time,
			LocalDate end_date, LocalTime end_time, Integer repeat_cat, Integer repeat_day, Integer repeat_week,
			String mon, String the, String wed, String thu, String fri, String sat, String sun,
			LocalDateTime write_date, LocalDateTime delete_date) {
		super();
		this.sc_no = sc_no;
		this.user_no = user_no;
		this.title = title;
		this.start_date = start_date;
		this.start_time = start_time;
		this.end_date = end_date;
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
		this.write_date = write_date;
		this.delete_date = delete_date;
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
		return start_date;
	}
	public void setStart_date(LocalDate start_date) {
		this.start_date = start_date;
	}
	public LocalTime getStart_time() {
		return start_time;
	}
	public void setStart_time(LocalTime start_time) {
		this.start_time = start_time;
	}
	public LocalDate getEnd_date() {
		return end_date;
	}
	public void setEnd_date(LocalDate end_date) {
		this.end_date = end_date;
	}
	public LocalTime getEnd_time() {
		return end_time;
	}
	public void setEnd_time(LocalTime end_time) {
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
	public LocalDateTime getWrite_date() {
		return write_date;
	}
	public void setWrite_date(LocalDateTime write_date) {
		this.write_date = write_date;
	}
	public LocalDateTime getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(LocalDateTime delete_date) {
		this.delete_date = delete_date;
	}
}
