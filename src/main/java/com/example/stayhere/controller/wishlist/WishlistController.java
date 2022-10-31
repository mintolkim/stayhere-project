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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.wishlist.dto.WishlistDTO;
import com.example.stayhere.service.wishlist.WishlistService;

@Controller
@RequestMapping("wishlist/*")
public class WishlistController {
	
	@Inject
	WishlistService wishlistService;
	
	@RequestMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		Map<String, Object> map = new HashMap<>();
		String userid = (String)session.getAttribute("userid");
		if(userid != null) {
			List<WishlistDTO> list = wishlistService.listWish(userid);
			map.put("list", list);
			map.put("count", list.size());
			mav.setViewName("wishlist/wish_list");
			mav.addObject("map",map);
			return mav;
		}else {
			return new ModelAndView("guest/guest_login","",null);			
		}
	}
	
	@RequestMapping("insert.do")
	public String insert(HttpSession session, @ModelAttribute WishlistDTO dto) {
		String userid=(String)session.getAttribute("userid");
		if(userid == null) {
			return "redirect:/guest/login.do";
		}
		dto.setUserid(userid);
		wishlistService.insertWish(dto);
		return "redirect:/wishlist/list.do";
	}
	
	@RequestMapping("delete.do")
	public String delete(@RequestParam int wish_num, HttpSession session) {
		if(session.getAttribute("userid") != null) wishlistService.deleteWish(wish_num);
		return "redirect:/wishlist/list.do";
	}
	
	@RequestMapping("deleteAll.do")
	public String deleteAll(HttpSession session) {
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
