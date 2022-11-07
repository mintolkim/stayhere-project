package com.example.stayhere.controller.wishlist;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.model.wishlist.dto.WishlistDTO;
import com.example.stayhere.service.wishlist.WishlistService;
import com.example.stayhere.util.Pager;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("wishlist/*")
public class WishlistController {
	
	@Inject
	WishlistService wishlistService;
	
	@RequestMapping("list.do")
	public ModelAndView list(HttpSession session, 
			@RequestParam(defaultValue = "1") int page) throws Exception {

		String userid = (String) session.getAttribute("userid");
		log.info("위시리스트 userid : " + userid);
		ModelAndView mav = new ModelAndView();

		int count = wishlistService.wishCount(userid);
		log.info("위시리스트 목록갯수 : " + count);
		int pageScale = 6; // 게시물 표시 갯수
		Pager pager = new Pager(pageScale, count, page);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<RoomsDTO> list = wishlistService.listWish(userid, start, end);
		log.info("위시리스트 목록 : " + list);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		mav.addObject("map", map);
		mav.setViewName("wishlist/wish_list");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("insert.do")
	public String insert(HttpSession session, 
			@ModelAttribute WishlistDTO dto) throws Exception {
		log.info("위시리스트 추가 넘어온 값 : " + dto);
		int result = wishlistService.duplicateCehck(dto); //중복체크
		log.info("중복값 확인 : " + result); //1이면 중복처리
		if(result == 0) { // 값이 0 이면 저장후 true 반환
			wishlistService.insertWish(dto);
			return "true"; 
		} else { //없으면  false반환  (해당 데이터 값으로 ajax에서 처리)
			return "false";
		}
	}
	
	
	@ResponseBody
	@GetMapping("addCheck.do")
	public List<WishlistDTO> addCheck(@RequestParam String userid) throws Exception{	
		return wishlistService.addCheck(userid);
	}
	
	
	@ResponseBody
	@RequestMapping("delete.do")
	public String delete(HttpSession session, @ModelAttribute WishlistDTO dto) throws Exception {
		log.info("위시리스트 추가 넘어온 값 : " + dto);
		int result = wishlistService.duplicateCehck(dto); //중복여부 체크
		log.info("중복값 확인 : " + result); 
		if(result == 1) { //중복값이 있으면 삭제처리 
			wishlistService.deleteWish(dto);
			return "true"; 
		} else { //없으면  false반환  (해당 데이터 값으로 ajax에서 처리)
			return "false";
		}
	}
	
	
	@RequestMapping("deleteAll.do")
	public String deleteAll(HttpSession session) throws Exception {
		String userid = (String)session.getAttribute("userid");
		if(userid != null) {
			wishlistService.deleteAllWish(userid);
		}
		return "redirect:/wishlist/list.do";
	}
	
	@RequestMapping("check.do")
	public String checkWish(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		int room_idx = Integer.parseInt(request.getParameter("room_idx"));
		WishlistDTO dto = new WishlistDTO();
		dto.setRoom_idx(room_idx);
		int using_room = wishlistService.checkWish(dto);
		String result = "" + using_room;
		return result;
	}
}
