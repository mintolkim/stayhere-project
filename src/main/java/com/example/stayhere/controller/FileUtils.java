package com.example.stayhere.controller;


	import java.io.File;
	import java.text.DecimalFormat;
	import java.util.Calendar;
	import java.util.UUID;

	import org.springframework.util.FileCopyUtils;

	public class FileUtils {
	    
	   public static String fileUpload(String uploadPath,
	           String fileName,
	           byte[] fileData) throws Exception {

	    UUID uid = UUID.randomUUID();
	    
	    String newFileName = uid + "_" + fileName;
	    String imgPath = uploadPath;

	    File target = new File(imgPath, newFileName);
	    FileCopyUtils.copy(fileData, target);
	    

	    return newFileName;
	    
	   }


}

	
