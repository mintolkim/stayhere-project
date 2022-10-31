package com.example.stayhere.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.Pager;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;


@Controller
@Slf4j
public class SearchController {
	
	@Inject
	RoomsService roomsService;
	
	@RequestMapping(value = "search/map/{cityname}/{checkin_date}/{checkout_date}"
			,method = RequestMethod.GET)
	public ModelAndView listMap(
			@PathVariable String cityname,
			@PathVariable String checkin_date, 
			@PathVariable String checkout_date,
			@RequestParam(defaultValue = "0") int bed, 
			@RequestParam(defaultValue = "0") int bath,
			@RequestParam(defaultValue = "0") String reviewStar, 
			@RequestParam(defaultValue = "100000") int lower, 
			@RequestParam(defaultValue = "900000") int higher) {
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
	
	/*
	 * 기본 검색화면 (FindStay버튼 클릭시 이동됨)
	 */
	@GetMapping("search")
	public ModelAndView search(ModelAndView mav) {
		// 룸가격 최소값 최대값
		int maxPrice = roomsService.findRoomMaxPrice();
		int minPrice = roomsService.findRoomMinPrice();
		
		Map<String, Object> map = new HashMap<>();
		map.put("max_price", maxPrice);
		map.put("min_price", minPrice);
		mav.addObject("map", map);
		mav.setViewName("search/search");
		return mav;
	}
	
	/*
	 * 메인페이지에서 검색시 호출되는 메소드
	 * @PathVariable : 여행지검색키워드, 체크인날짜, 체크아웃날짜
	 * @RequestParam : page 파라미터값 저장
	 * @throws Exception	  
	 */
	@PostMapping("search/{cityname}/{checkin_date}/{checkout_date}")
	public ModelAndView search(	@PathVariable String cityname, 
			@PathVariable String checkin_date,
			@PathVariable String checkout_date, 
			@RequestParam(defaultValue = "1") int page,
			ModelAndView mav) throws Exception {

		// 검색갯수
		int count = roomsService.getRoomDefalutCount(cityname, checkin_date, checkout_date);
		// 룸가격 최소값 최대값
		int maxPrice = roomsService.findRoomMaxPrice();
		int minPrice = roomsService.findRoomMinPrice();

		int pageScale = 10; // 게시물 표시 갯수
		Pager pager = new Pager(pageScale, count, page);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		//검색리스트
		List<RoomsDTO> list = roomsService.getRoomDefalutList(start, end, cityname, checkin_date, checkout_date);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("cityname", cityname);
		map.put("checkin_date", checkin_date);
		map.put("checkout_date", checkout_date);
		map.put("max_price", maxPrice);
		map.put("min_price", minPrice);
		mav.addObject("map", map);
		mav.setViewName("search/search");
		return mav;
	}
	
	
	/*
	 * 검색화면에서 옵션검색 시 호출되는 메소드
	 * @PathVariable : 여행지검색키워드, 체크인날짜, 체크아웃날짜
	 * @RequestParam : Map형태로 넘어오는 모든 파라미터값을 저장 (sort, bed, bath, people, lower, higher, page) 
	 * @throws Exception
	 */
	@GetMapping("search/{cityname}/{checkin_date}/{checkout_date}")
	public ModelAndView search(@PathVariable String cityname, 
			@PathVariable String checkin_date,
			@PathVariable String checkout_date, 
			@RequestParam Map<String, Object> param, 
			ModelAndView mav)
			throws Exception {

		// PathVariable값 param으로 묶기
		param.put("cityname", cityname);
		param.put("checkin_date", checkin_date);
		param.put("checkout_date", checkout_date);

		log.info("param : " + param);

		// 룸가격 최소값 최대값
		int maxPrice = roomsService.findRoomMaxPrice();
		int minPrice = roomsService.findRoomMinPrice();
		// 이전날짜를 url로 입력하고 들어왔을때 조건 조회
		boolean previousDateCheck = roomsService.previousDateCheck(checkin_date);

		if (!previousDateCheck) { // 만약 이전날짜로 입력이 되었다면
//			// 이전날짜가 입력되었다면
			String msg = "이전 날짜를 입력하셨습니다. 날짜를 다시 선택해주세요";
			Map<String, Object> map = new HashMap<>();
			map.put("max_price", maxPrice);
			map.put("min_price", minPrice);
			map.put("error", msg);
			mav.addObject("map", map);
			mav.setViewName("search/search");
			return mav;
		}
		// 검색갯수
		int count = roomsService.getRoomOptionCount(param);
//							
//					// 옵션별 검색리스트
		int pageScale = 10; // 게시물 표시 갯수
		if (param.get("page") == null) { // 파라미터값 중 page 값이 null이면..
			param.put("page", 1); // page를 기본 1값으로 저장
		}
		// int 타입으로 page 형변환하여 변수에 저장
		int page = Integer.parseInt(param.get("page").toString());
		log.info("page : " + param.get("page"));
		Pager pager = new Pager(pageScale, count, page);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();

		List<RoomsDTO> list = roomsService.getRoomOptionList(start, end, param);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("cityname", cityname);
		map.put("checkin_date", checkin_date);
		map.put("checkout_date", checkout_date);
		map.put("max_price", maxPrice);
		map.put("min_price", minPrice);
		mav.addObject("map", map);
		mav.setViewName("search/search");
		return mav;
	}
	
	/*
	 * 검색결과 리스트만 ajax호출 시 json 타입으로 반환
	 * @RequestBody : ajax로 넘어온 데이터를 자바 객체타입으로 받음
	 * @  
	 */
//	
//	@GetMapping("api/search.do")
//	@ResponseBody
//	public Map<String, Object> search()
	
	
}
