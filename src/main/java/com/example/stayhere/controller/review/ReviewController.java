package com.example.stayhere.controller.review;

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
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.service.review.ReviewService;

@Controller
@RequestMapping("reviews/*")
public class ReviewController {
	private static final Logger logger=LoggerFactory.getLogger(ReviewController.class);
	
	@Inject
	ReviewService reviewService;
	
	@RequestMapping("list.do")
	public ModelAndView list() throws Exception{
		List<ReviewDTO> list = reviewService.listAll();
		logger.info(list.toString());
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list); //map에 자료 저장
		map.put("count", list.size()); //레코드 갯수 파일
		mav.setViewName("reviews/reviewList"); //포워딩할 뷰
		mav.addObject("map", map); //보낼 데이터
		return mav;
	}
	
	@RequestMapping("write.do")
	public String write() {
		return "reviews/reviewWrite";
	}
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute ReviewDTO dto, HttpSession session)
		throws Exception {
		
		//게시물 목록으로 이동
		return "redirect:/reviews/list.do";
		
	}
	
}
