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
public class MainController {

	private static final Logger logger = 
			LoggerFactory.getLogger(MainController.class);

	@Inject
	RoomsService roomsService;
	
	@GetMapping("/")
	public String home() {
		return "redirect:/main";
	}
		
	@GetMapping("/main")
	public ModelAndView main(
			@RequestParam(defaultValue = "1") int curPage) throws Exception
		{
		int count = roomsService.getRoomAllCount();
//		logger.info("count : " + Integer.toString(count));
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<RoomsDTO> list = roomsService.getRoomAllList(start, end);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);		
		mav.addObject("map", map);
		mav.setViewName("main");
		return mav;
	}

}