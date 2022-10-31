package com.example.stayhere.util;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;



public class UploadFileUtils {
	//로깅
	private static final Logger logger=LoggerFactory.getLogger(UploadFileUtils.class);
	
	public static String uploadFile(String uploadPath, 
			String originalName, byte[] fileData) throws Exception {
		//uuid 발급
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;
		// 업로드할 디렉토리 생성
		//String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath, savedName);
		// 임시 디렉토리에 업로드된 파일을 지정된 디렉토리 복사
		FileCopyUtils.copy(fileData, target);
		//파일의 확장자 검사
		// a.jpg, aaa.bbb.ccc.jpg
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = noImg(uploadPath,savedName);
		}else { 
			uploadedFileName = noImg(uploadPath,savedName);
		}
		return uploadedFileName;
	}


	// 이미지 파일이 아닌 파일처리 메소드 makeIcon=>noImg
	public static String noImg(String uploadPath,
			String fileName) throws Exception {
		String iconName = uploadPath + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(
				File.separatorChar, '/');
	}
}
