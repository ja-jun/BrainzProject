package com.brainz.ja.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.Calendar;
import java.util.Locale;

public class test {

	public static void main(String[] args) {
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd E");
		Calendar cal = Calendar.getInstance();
		
		System.out.println(fmt.format(cal.getTime()));
		
		SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss D E W w");
		System.out.println(fmt2.format(cal.getTime()));
		
		cal.set(2022, 00, 2);
		
		System.out.println(fmt2.format(cal.getTime()));
		
		System.out.println("YEAR\t" + cal.get(Calendar.YEAR));
		System.out.println("MONTH\t" + cal.get(Calendar.MONTH));
		System.out.println("DATE\t" + cal.get(Calendar.DATE));
		System.out.println("HOUR\t" + cal.get(Calendar.HOUR));
		System.out.println("HOUR_OF_DAY\t" + cal.get(Calendar.HOUR_OF_DAY));
		System.out.println("MINUTE\t" + cal.get(Calendar.MINUTE));
		System.out.println("SECOND\t" + cal.get(Calendar.SECOND));
		System.out.println("MILLISECOND\t" + cal.get(Calendar.MILLISECOND));
		System.out.println("DAY_OF_YEAR\t" + cal.get(Calendar.DAY_OF_YEAR));
		System.out.println("WEEK_OF_MONTH\t" + cal.get(Calendar.WEEK_OF_MONTH));
		System.out.println("WEEK_OF_YEAR\t" + cal.get(Calendar.WEEK_OF_YEAR));
		
		
		WeekFields test = WeekFields.of(new Locale("ko"));
	}

}