package com.example.stayhere.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.Pager;

@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Inject
	RoomsService roomsService;

	@GetMapping("search")
	public ModelAndView search(
			@RequestParam(defaultValue = "1") int curPage, 
			@RequestParam(defaultValue = "") String city,
			@RequestParam(defaultValue = "") String check_in, 
			@RequestParam(defaultValue = "") String check_out) throws Exception {

		// 검색갯수
		int count = roomsService.getRoomOptionCount(city, check_in, check_out);
		// 옵션별 검색리스트
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<RoomsDTO>list = roomsService.getRoomOptionList(start, end, city, check_in, check_out);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("totPage", pager.getTotPage());
		map.put("pager", pager);		
		mav.addObject("map", map);
		mav.setViewName("search");
		return mav;
	}

}
