package com.example.stayhere.controller;



import java.util.HashMap;

import java.util.List;

import java.util.Map;



import javax.inject.Inject;



import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;



import com.example.stayhere.model.rooms.dto.RoomsDTO;

import com.example.stayhere.service.rooms.RoomsService;

import com.example.stayhere.util.Pager;



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



	// 무한스크롤 룸 리스트 불러오기

	@GetMapping("addRoomsList")

	public ModelAndView addList(@RequestParam int curPage) throws Exception {

		//			logger.info("curPage : " + Integer.toString(curPage));

		int count = roomsService.getRoomAllCount();

		Pager pager = new Pager(count, curPage);

		int start = pager.getPageBegin();

		int end = pager.getPageEnd();

		List<RoomsDTO> list = roomsService.getRoomAllList(start, end);

		ModelAndView mav = new ModelAndView();

		Map<String, Object> map = new HashMap<>();

		map.put("list", list);

		map.put("count", count);
		map.put("totPage", pager.getTotPage());
		map.put("pager", pager);

		mav.addObject("map", map);

		mav.setViewName("ajax/addRoomsList");

		return mav;

	}


}