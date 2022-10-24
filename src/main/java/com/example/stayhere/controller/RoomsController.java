package com.example.stayhere.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.rooms.RoomsService;

@Controller
@RequestMapping("rooms/*")
public class RoomsController {

	//로깅
	private static final Logger logger=LoggerFactory.getLogger(RoomsController.class);
	
	//의존관계 주입
	@Inject
	RoomsService roomsService;
	
	//숙소 목록
	//rooms_list.jsp
	@RequestMapping("list.do")
	public String list() {
		return "/rooms/rooms_list";
	}
	
	//숙소 상세 정보
	//rooms_detail.jsp
	@RequestMapping("detail/{room_idx}")
	public ModelAndView detail(@PathVariable int room_idx, ModelAndView mav) {
		Map<String,Object> map=new HashMap<>();
		RoomsDTO dto=roomsService.detailRooms(room_idx);
		//int total_price=roomsService.total_price(room_idx);
		int total_price=200000;
		
		map.put("total_price",total_price);
		map.put("dto", dto);
		
		logger.info("dto");
		//포워딩
		mav.setViewName("rooms/rooms_detail");
		mav.addObject("map", map);
		return mav;
	}
	

	
}
