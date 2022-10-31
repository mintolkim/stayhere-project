package com.example.stayhere.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;


public class DateParse {
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat strFormat = new SimpleDateFormat("yyyyMMdd");
	private static DateTimeFormatter localDateFormat = DateTimeFormatter.ofPattern("yyyyMMdd");
	
	// 외부에서 객체 생성 금지 
	private DateParse() {}
	
	// yyyy-MM-dd -> yyyyMMdd	=>	DB에 넣기 위해 사용
	public static String dateToStr(String date) {
		return date.replaceAll("-", "");
	}
	
	// yyyyMMdd -> yyyy-MM-dd	=>	input date value로 넣기 위해 사용
	public static String strToDate(String str) {
		Date date;
		try {
			date = strFormat.parse(str);
			return dateFormat.format(date);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// getTodayPlus(int) 파라미터로 0 넣으면 오늘, 1 넣으면 내일
	public static String getTodayPlus(int plus) {
		LocalDate now = LocalDate.now(); 	// 현재시간
		now = now.plusDays(plus);			// 현재시간 + "plus"일
		return now.format(localDateFormat);	// yyyyMMdd 포매팅
	}
	
	// 날짜 더하기
	public static String datePlus(String date, int plus) {
		if(date.contains("-")) date = DateParse.dateToStr(date);
		LocalDate localDate = LocalDate.parse(date, DateTimeFormatter.BASIC_ISO_DATE);
		return localDate.plusDays(plus).format(DateTimeFormatter.BASIC_ISO_DATE);
		// return yyyyMMdd
	}
	
	// 날짜 차이 계산 end - start //활용X, 필요시 활용 예정
	public static int dateDif(String start, String end) {
		if(start.contains("-") || end.contains("-")) {
			start = DateParse.dateToStr(start);
			end = DateParse.dateToStr(end);
		}
		
		try {
			Date startDate = strFormat.parse(start);
			Date endDate = strFormat.parse(end);
			int dif = (int) ((endDate.getTime()-startDate.getTime()) / (24*60*60*1000));
			System.out.println("날짜 차이 : "+dif);
			return dif;
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return -1;
	}

// 스프링 타임서버 라이브러리 추가
//	<dependency>
//	    <groupId>commons-net</groupId>
//	    <artifactId>commons-net</artifactId>
//	    <version>3.6</version>
//	</dependency>
}