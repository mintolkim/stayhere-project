package com.example.stayhere.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.Pager;

import net.sf.json.JSONArray;


@Controller
@RequestMapping("search/*")
public class SearchController {
private static final Logger logger=LoggerFactory.getLogger(SearchController.class);
	
	@Inject
	RoomsService roomsService;
	
	@RequestMapping(value = "listMap.do", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam(defaultValue = "") String cityname, 
			@RequestParam String checkin_date,@RequestParam String checkout_date,
			@RequestParam(defaultValue = "0") int bed, @RequestParam(defaultValue = "0") int bath,
			@RequestParam(defaultValue = "0") String reviewStar, 
			@RequestParam(defaultValue = "100000") int lower, @RequestParam(defaultValue = "900000") int higher) {
		System.out.println("들어온 도시이름 : "+cityname+",체크인날짜 : "+checkin_date+", 체크아웃날짜 : "+checkout_date+
				", 침대 수: "+bed+", 욕실수 : "+bath+",리뷰평점: "+reviewStar+",최소가격: "+lower+",최대가격: "+higher);	
		List<RoomsDTO> list=roomsService.listMap(cityname,bed,bath,reviewStar,lower,higher);
		//주소리스트
		List<RoomsDTO> adrlist=roomsService.address_list(cityname,bed,bath,reviewStar,lower,higher);
		System.out.println("list: "+ list.toString());
		//레코드 갯수 계산
		int count=roomsService.countrooms(cityname,bed,bath,reviewStar,lower,higher);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map=new HashMap<>();
		map.put("list", list);//map에 자료 저장
		map.put("cityname", cityname);//map에 자료 저장
		map.put("checkin_date", checkin_date);//map에 자료 저장
		map.put("checkout_date", checkout_date);//map에 자료 저장
		map.put("bed", bed);
		map.put("bath", bath);
		map.put("reviewStar", reviewStar);
		map.put("lower", lower);
		map.put("higher", higher);
		map.put("count", count); //레코드 갯수 파일
		map.put("adrlist",JSONArray.fromObject(adrlist) ); //레코드 갯수 파일
		mav.setViewName("search/search_map");//포워딩할 뷰
		mav.addObject("map", map);//보낼 데이터*/
		return mav;
	}
	
	
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
		map.put("pager", pager);		
		mav.addObject("map", map);
		mav.setViewName("search");
		return mav;
	}
	
	
	
	
}
