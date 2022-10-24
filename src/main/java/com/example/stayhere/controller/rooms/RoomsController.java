package com.example.stayhere.controller.rooms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.Pager;

@Controller
@RequestMapping("rooms/*")
public class RoomsController {

	@Inject
	RoomsService roomsService;
	
	
	//무한스크롤 룸 리스트 불러오기
	@GetMapping("addRoomsList")
	public ModelAndView addList(
			@RequestParam int curPage) throws Exception {
//		logger.info("curPage : " + Integer.toString(curPage));
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
	
	
	//json 형태로 내려보내기.. javascript로 구현가능하나
	//section영역 html을 모두 변수에 담아야함... 다음기회에..
//	@ResponseBody
//	@GetMapping("/api/addRoomsList")
//	public List<RoomsDTO> addListApi(@RequestParam int curPage){
//		int count = roomsService.getRoomCount();
//		Pager pager = new Pager(count, curPage);
//		int start = pager.getPageBegin();
//		int end = pager.getPageEnd();
//		return roomsService.getRoomList(start, end);
//	}
		
	
}
