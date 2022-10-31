package com.example.stayhere.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.service.reservations.ReservationsService;

@Controller
@RequestMapping("reservations/*")
public class ReservationsController {

	@Inject
	ReservationsService reservationsService;

	//예약 상세 페이지
	@RequestMapping("detail/{res_idx}")
	public ModelAndView detail(ModelAndView mav) {
		//예약 테이블의 값을 가져와서 ...........출력?
		
		return mav;			
	}
	
	//예약테이블에 데이터 입력
	@RequestMapping("reserve.do")
	public String insert(@ModelAttribute ReservationsDTO dto, HttpSession session) throws Exception {
		//숙소 상세정보에서 가져온 값 예약 테이블에 저장
		
		/*
		 * //세션의 게스트 아이디를 가져옴 
		 * String userid=(String)session.getAttribute("userid");
		 * if(userid==null) { //로그아웃 상태
		 *  return "redirect:/guset/login.do";
		 * }
		 */
		
		String userid="kim";
		dto.setUserid(userid);//게스트 아이디 저장
		String h_userid="testhost";
		dto.setH_userid(h_userid);//호스트 아이디 저장
		
		String res_state="예약 승인요청";
		dto.setRes_state(res_state);
		
		//총 금액 계산
		//예약 총 금액 계산
		//int night = DateParse.dateDif(dto.getCheckin_date(), booking.getCheckout_date()); // (checkout-checkin)
		//dto.setTotal_price((Integer.parseInt(dto.getPrice()) * night)+"");//방 가격*숙박일수

		reservationsService.insert(dto);
		
		//데이터 저장 후 예약 상세 페이지로 이동
		session.setAttribute("dto", dto);
		return "reservations/res_detail";
		//return "redirect:/reservations/detail.do";
	}
	
	@RequestMapping("test.do")
	public String test() {
		return "reservations/res_detail";
	}
	
	
	
}
