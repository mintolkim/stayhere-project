package com.example.stayhere.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.DateParse;
import com.example.stayhere.util.Pager;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {

	@Inject
	RoomsService roomsService;

	
	//메인페이지로 리다이렉션
	@GetMapping("/")
	public String home() {
		return "redirect:/main";
	}

	
	/*
	 * 메인페이지 영역
	 * @Param curPage 페이지번호
	 * @throws Exception
	 */
	@GetMapping("/main")
	public ModelAndView main(
			@RequestParam(defaultValue = "1") int curPage
			) throws Exception {
		
		// today : 현재날짜+1, tomorrow : 현재날짜 + 2 
		String today = DateParse.strToDate(DateParse.getTodayPlus(1));
		String tomorrow = DateParse.strToDate(DateParse.getTodayPlus(2));
		log.info("today : " + today + ", tomorrow : " + tomorrow +  ", curPage :" + curPage);
		int count = roomsService.getRoomAllCount(today, tomorrow);
		int pageScale = 12; //게시물 표시 갯수
		Pager pager = new Pager(pageScale, count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<RoomsDTO> list = roomsService.getRoomAllList(start, end, today, tomorrow);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("today", today);
		mav.addObject("map", map);
		mav.setViewName("main");
		return mav;
	}

	/*
	 * 무한스크롤 룸 리스트 불러오기
	 * @Param curPage 페이지번호
	 * @throws Exception
	 */ 
	@GetMapping("addRoomsList")
	public ModelAndView addList(
			@RequestParam int curPage
			) throws Exception {
		// today : 현재날짜+1, tomorrow : 현재날짜 + 2 
		String today = DateParse.strToDate(DateParse.getTodayPlus(1));
		String tomorrow = DateParse.strToDate(DateParse.getTodayPlus(2));
		log.info("addList today : " + today + "tomorrow : " + tomorrow +  "curPage :" + curPage);
		int count = roomsService.getRoomAllCount(today, tomorrow);
		int pageScale = 12; //게시물 표시 갯수
		Pager pager = new Pager(pageScale, count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<RoomsDTO> list = roomsService.getRoomAllList(start, end, today, tomorrow);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("today", today);
		mav.addObject("map", map);
		mav.setViewName("addPage/addRoomsList");
		return mav;
	}
	
//	// json 형태로 내려보내기
//	@ResponseBody
//	@GetMapping("/api/addRoomsList")
//	public List<RoomsDTO> addListApi(
//			@RequestParam(defaultValue = "1") int curPage) {
//		int count = roomsService.getRoomAllCount();
//		Pager pager = new Pager(count, curPage);
//		int start = pager.getPageBegin();
//		int end = pager.getPageEnd();
//		return roomsService.getRoomAllList(start, end);
//	}
	
	
	/*
	 * 인터셉터 세션 체크 페이지
	 * 
	 */
	@GetMapping("check")
	public String sessionCheck() {
		return "include/session_check";
	}

}