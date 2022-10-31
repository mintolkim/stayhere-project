package com.example.stayhere.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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

	// 의존관계 주입
	@Inject
	RoomsService roomsService;
	
	@Inject
	HostService hostService;

	@Inject
	ReviewService reviewService;
	
	// 숙소 목록
	@RequestMapping("list.do")
	public String list() {
		return "/rooms/rooms_list";
	}

	// 숙소 상세 정보
	@RequestMapping("detail/{room_idx}")
	public ModelAndView detail(@PathVariable int room_idx, ModelAndView mav) {
		
		LocalDate today = LocalDate.now();
		LocalDate tomorrow=today.plusDays(1);
		
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
		mav.addObject("today", today); 		
		mav.addObject("tomorrow", tomorrow); 		
		mav.setViewName("rooms/rooms_detail");
		return mav;
	}

}
