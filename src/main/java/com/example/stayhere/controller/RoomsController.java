package com.example.stayhere.controller;


import java.io.File;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.host.HostService;
import com.example.stayhere.service.review.ReviewService;
import com.example.stayhere.service.rooms.RoomsService;

@Controller
@RequestMapping("rooms/*")
public class RoomsController {

	// 의존관계 주입
	@Inject
	RoomsService roomsService;
	
	@Inject
	HostService hostService;

	@Inject
	ReviewService reviewService;

	// 숙소 목록
	// rooms_list.jsp
	@RequestMapping("list.do")
	public String list() {
		return "/rooms/rooms_list";
	}
	
	@Resource(name="uploadPath")
	String uploadPath;

	// 숙소 상세 정보
	// rooms_detail.jsp
	@RequestMapping("detail/{room_idx}")
	public ModelAndView detail(@PathVariable int room_idx, ModelAndView mav) {
		// 포워딩
		mav.setViewName("rooms/rooms_detail");
		mav.addObject("dto", roomsService.detailRooms(room_idx));
		return mav;
	}

	@RequestMapping("write.do")
	public String write() {
		return "host/host_Room_write";
	}
	
	@RequestMapping("insert")
	public ModelAndView insert(HttpSession session, RoomsDTO dto, ModelAndView mav,ArrayList<MultipartFile> photo) throws Exception {
		
		String h_userid =(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		String contents = dto.getContents();
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace(" ", "&nbsp;&nbsp;");
		contents = contents.replaceAll(System.getProperty("line.separator"), "<br>");
		dto.setContents(contents);
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		
		String[] fileName =new String[photo.size()];
		String[] newName =new String[photo.size()];
		
		for(int i=0; i<photo.size(); i++) {
		fileName[i] =  FileUtils.fileUpload(imgUploadPath,photo.get(i).getOriginalFilename(),photo.get(i).getBytes());   
		newName[i] = File.separator + "imgUpload" + File.separator + fileName[i];
		}
		
		dto.setPhoto1(newName[0]);
		dto.setPhoto2(newName[1]);
		dto.setPhoto3(newName[2]);
		dto.setPhoto4(newName[3]);
		
		roomsService.insert(dto);
		
		mav.setViewName("host/host_Room_write");
		mav.addObject("message", "confirm");
		
		return mav;
	}
	
	@RequestMapping("edit/{room_idx}")
	public ModelAndView edit(@PathVariable int room_idx, ModelAndView mav) {
		mav.addObject("dto", roomsService.getRoomInfo(room_idx));
		mav.setViewName("host/rooms_Edit");
		
		return mav;
	}
	
	@RequestMapping("delete/{room_idx}")
	public ModelAndView deleteConfirm(@PathVariable int room_idx, ModelAndView mav) {
		mav.addObject("dto", roomsService.getRoomInfo(room_idx));
		roomsService.deleteConfirm(room_idx);
		mav.setViewName("host/rooms_Edit");
		
		return mav;
	}
	
	@RequestMapping("update/{room_idx}")
	public ModelAndView updateRoom(@PathVariable int room_idx, ModelAndView mav, RoomsDTO dto, ArrayList<MultipartFile> photo) throws Exception{ 
		String contents = dto.getContents();
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace(" ", "&nbsp;&nbsp;");
		contents = contents.replaceAll(System.getProperty("line.separator"), "<br>");
		dto.setContents(contents);
		roomsService.updateRoom(dto);
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		
		String[] fileName =new String[photo.size()];
		String[] newName =new String[photo.size()];
		
		String[] getPhoto = {dto.getPhoto1(),dto.getPhoto2(),dto.getPhoto3(),dto.getPhoto4()};
		
		for(int i=0; i<photo.size(); i++) {
		if(photo.get(i).getOriginalFilename() != null && photo.get(i).getOriginalFilename() != "") {
			fileName[i] =  FileUtils.fileUpload(imgUploadPath,photo.get(i).getOriginalFilename(),photo.get(i).getBytes());   
			newName[i] = File.separator + "imgUpload" + File.separator + fileName[i];
		}else {
		    newName[i] = getPhoto[i];
		 }
		}
		
		dto.setPhoto1(newName[0]);
		dto.setPhoto2(newName[1]);
		dto.setPhoto3(newName[2]);
		dto.setPhoto4(newName[3]);
		
		roomsService.updateRoomphoto(dto);
		
		mav.addObject("dto", roomsService.getRoomInfo(room_idx));
		mav.setViewName("host/rooms_Edit");
		
		return mav;
	}	
	

}
