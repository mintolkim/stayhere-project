package com.example.stayhere.controller;


import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.host.HostService;
import com.example.stayhere.service.review.ReviewService;
import com.example.stayhere.service.rooms.RoomsService;

@Controller
@RequestMapping("rooms/*")
public class RoomsController {

	private static final Logger logger = 
			LoggerFactory.getLogger(MainController.class);
	
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
	@RequestMapping("detail/{room_idx}")
	public ModelAndView detail(@PathVariable int room_idx, ModelAndView mav) {
		
		RoomsDTO room_dto=new RoomsDTO();
		room_dto=roomsService.detailRooms(room_idx);
		
		HostDTO h_dto=new HostDTO();
		h_dto=hostService.viewHost(room_dto.getH_userid());
		
		List<ReviewDTO> list = reviewService.reviewsByRoom(room_idx);
		int reviewCount=reviewService.countByRoom(room_idx);
		double starAvg=reviewService.starByRoom(room_idx);
		
		// 포워딩
		mav.addObject("room", room_dto); 
		mav.addObject("host", h_dto); 
		mav.addObject("review", list); 
		mav.addObject("reviewCount", reviewCount); 
		mav.addObject("starAvg", starAvg); 		
	
		//예약된 날짜 가져오기
		List<String> date1=new ArrayList<>();
		date1=roomsService.matchDetail(room_idx);
		logger.info("해당 숙소의 예약된 날짜 리스트"+date1.toString());
		
		int listSize=date1.size();
		String[] date2=date1.toArray(new String[listSize]);

		logger.info("리스트를 배열로 변환"+Arrays.toString(date2));
		
		String date3="";
		for(int i=0; i<date2.length; i++) {
			date3 += '\"'+date2[i]+'\"'+",";
		}
		
		logger.info("큰따옴표 붙인 날짜 (스트링)"+date3.toString());
		
		String[] date4=date3.split(",");
		
		logger.info("큰따옴표 붙인 날짜 (배열)"+Arrays.toString(date4));
		
		List<String> reList=new ArrayList<String>();
		for(String item:date4) {
			reList.add(item);
		}
		
		//리스트를 뷰에 넘기기
		List<String> chkList=new ArrayList<String>();
		for(String item1:date4) {
			chkList.add(item1);
		}
		logger.info("리스트 타입의 예약날짜"+chkList.toString());
		//포워딩
		mav.addObject("redateList", chkList);
		mav.setViewName("rooms/rooms_detail");
		return mav;
	}
	
	//체크인,체크아웃 지정 후  숙소 상세 정보
	@RequestMapping(value = "searchDetail/{room_idx}/{checkin_date}/{checkout_date}"
			,method = RequestMethod.GET)
	public ModelAndView searchDetail(
			@PathVariable int room_idx, 
			@PathVariable String checkin_date, 
			@PathVariable String checkout_date,
			ModelAndView mav) {
		
		RoomsDTO room_dto=new RoomsDTO();
		room_dto=roomsService.detailRooms(room_idx);
		
		HostDTO h_dto=new HostDTO();
		h_dto=hostService.viewHost(room_dto.getH_userid());
		
		List<ReviewDTO> list = reviewService.reviewsByRoom(room_idx);
		int reviewCount=reviewService.countByRoom(room_idx);
		double starAvg=reviewService.starByRoom(room_idx);
		
		// 포워딩
		mav.addObject("room", room_dto); 
		mav.addObject("host", h_dto); 
		mav.addObject("review", list); 
		mav.addObject("reviewCount", reviewCount); 
		mav.addObject("starAvg", starAvg); 
		mav.addObject("checkin_date", checkin_date); 
		mav.addObject("checkout_date", checkout_date); 
		
		//예약된 날짜 가져오기
		List<String> date1=new ArrayList<>();
		date1=roomsService.matchDetail(room_idx);
		logger.info("해당 숙소의 예약된 날짜 리스트"+date1.toString());
		
		int listSize=date1.size();
		String[] date2=date1.toArray(new String[listSize]);

		logger.info("리스트를 배열로 변환"+Arrays.toString(date2));
		
		String date3="";
		for(int i=0; i<date2.length; i++) {
			date3 += '\"'+date2[i]+'\"'+",";
		}
		
		logger.info("큰따옴표 붙인 날짜 (스트링)"+date3.toString());
		
		String[] date4=date3.split(",");
		
		logger.info("큰따옴표 붙인 날짜 (배열)"+Arrays.toString(date4));
		
		List<String> reList=new ArrayList<String>();
		for(String item:date4) {
			reList.add(item);
		}
		
		//리스트 뷰에 넘기기
		List<String> chkList=new ArrayList<String>();
		for(String item1:date4) {
			chkList.add(item1);
		}
		logger.info("리스트 타입의 예약날짜"+chkList.toString());
		//포워딩
		mav.addObject("redateList", chkList);
		mav.setViewName("rooms/rooms_detail");
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
		
		String imgUploadPath = uploadPath;
		
		String[] fileName =new String[photo.size()];
		String[] newName =new String[photo.size()];
		
		for(int i=0; i<photo.size(); i++) {
		fileName[i] =  FileUtils.fileUpload(imgUploadPath,photo.get(i).getOriginalFilename(),photo.get(i).getBytes());   
		newName[i] = fileName[i];
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
		
		String imgUploadPath = uploadPath;
		
		String[] fileName =new String[photo.size()];
		String[] newName =new String[photo.size()];
		
		String[] getPhoto = {dto.getPhoto1(),dto.getPhoto2(),dto.getPhoto3(),dto.getPhoto4()};
		
		for(int i=0; i<photo.size(); i++) {
		if(photo.get(i).getOriginalFilename() != null && photo.get(i).getOriginalFilename() != "") {
			fileName[i] =  FileUtils.fileUpload(imgUploadPath,photo.get(i).getOriginalFilename(),photo.get(i).getBytes());   
			newName[i] = fileName[i];
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
