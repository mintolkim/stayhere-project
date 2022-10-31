package com.example.stayhere.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.service.guest.GuestService;
import com.example.stayhere.service.review.ReviewService;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.Pager;

@Controller
@RequestMapping("reviews/*")
public class ReviewController {
	private static final Logger logger=LoggerFactory.getLogger(ReviewController.class);

	@Inject
	GuestService guestService;	

	@Inject
	RoomsService roomsService;
	
	@Inject
	ReviewService reviewService;

	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam(defaultValue = "1")int curPage) throws Exception{
		int review_count = reviewService.countArticle();//레코드 갯수 계산
		//페이지 설정
		Pager pager = new Pager(6,review_count, curPage);//한 페이지당 6개
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<ReviewDTO> list = reviewService.listAll(start, end);
		logger.info(list.toString());
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list); 
		map.put("review_count", review_count); //레코드 갯수 파일
		map.put("pager",pager);
		mav.setViewName("reviews/reviewList");
		mav.addObject("map", map);
		return mav;
	}

	@RequestMapping("write.do")
	public String write(HttpSession session) {
		String userid=(String)session.getAttribute("userid");
		if(userid == null) {
			return "redirect:/guest/login.do"; 
		}//인터셉터 설정하면 해당 코드 주석처리.로그인 후 리뷰작성페이지로 리턴필요.
		return "reviews/reviewWrite";
	}

	@RequestMapping("insert.do")
	public String insert(@ModelAttribute ReviewDTO dto, HttpSession session)
			throws Exception {
		String userid=(String)session.getAttribute("userid");
		dto.setUserid(userid);
		reviewService.create(dto);
		return "redirect:/reviews/list.do";
	}
	
}
