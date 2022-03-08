package com.brainz.ja.vo;

public class ScheduleVoJun {
	private int schedule_no;
	private String title;
	private String start_date;
	private String start_time;
	private String end_date;
	private String end_time;
	public ScheduleVoJun() {
		super();
	}
	public ScheduleVoJun(int schedule_no, String title, String start_date, String start_time, String end_date,
			String end_time) {
		super();
		this.schedule_no = schedule_no;
		this.title = title;
		this.start_date = start_date;
		this.start_time = start_time;
		this.end_date = end_date;
		this.end_time = end_time;
	}
	public int getSchedule_no() {
		return schedule_no;
	}
	public void setSchedule_no(int schedule_no) {
		this.schedule_no = schedule_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
}
