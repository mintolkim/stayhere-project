package com.example.stayhere.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	private static Map<String,MediaType> mediaMap;
	//클래스를 로딩할 때 제일 먼저 실행되는 코드
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static MediaType getMediaType(String type) {
		//이미지의 확장자이름이 소문자로도 들어올 수 있어서 toUpperCase()를 써서 대문자로 변경
		return mediaMap.get(type.toUpperCase());
	}
}
