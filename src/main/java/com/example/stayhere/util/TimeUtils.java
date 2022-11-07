package com.example.stayhere.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeUtils {
	private static final String timeFormat = "MM/dd(E) HH:mm";
	
	public static String getCurrentTimeStamp() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern(timeFormat);
		return LocalDateTime.now().format(formatter);
	}
}
