package com.example.stayhere.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.service.rooms.RoomsService;

@Controller
@RequestMapping("rooms/*")
public class RoomsController {

	// 의존관계 주입
	@Inject
	RoomsService roomsService;

	// 숙소 목록
	// rooms_list.jsp
	@RequestMapping("list.do")
	public String list() {
		return "/rooms/rooms_list";
	}

	// 숙소 상세 정보
	// rooms_detail.jsp
	@RequestMapping("detail/{room_idx}")
	public ModelAndView detail(@PathVariable int room_idx, ModelAndView mav) {
		// 포워딩
		mav.setViewName("rooms/rooms_detail");
		mav.addObject("dto", roomsService.detailRooms(room_idx));
		return mav;
	}

}
