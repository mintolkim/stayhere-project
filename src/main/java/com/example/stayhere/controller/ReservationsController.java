package com.example.stayhere.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.guest.GuestService;
import com.example.stayhere.service.host.HostService;
import com.example.stayhere.service.reservations.ReservationsService;
import com.example.stayhere.service.rooms.RoomsService;

@Controller
@RequestMapping("reservations/*")
public class ReservationsController {

	private static final Logger logger = 
			LoggerFactory.getLogger(MainController.class);
	
	@Inject
	ReservationsService reservationsService;

	@Inject
	RoomsService roomsService;
	
	@Inject
	GuestService guestService;
	
	@Inject
	HostService hostService;
	
	
	//결제 전 예약상세 페이지
	@RequestMapping("reserve/{room_idx}")
	public ModelAndView reserve(@ModelAttribute RoomsDTO dto, @PathVariable int room_idx, HttpSession session, HttpServletRequest request,
								@RequestParam("checkin_date") String checkin_date,
								@RequestParam("checkout_date") String checkout_date,
								@RequestParam("res_person") int res_person,
								@RequestParam("night") String night) throws Exception {
		ModelAndView mav = new ModelAndView();
		//세션의 게스트 아이디를 가져옴 
  		String userid=(String)session.getAttribute("userid");
		if(userid==null) { //로그아웃 상태
			mav.setViewName("guest/guest_login");
			return mav;
		 }
		
		GuestDTO g_dto=new GuestDTO();
		g_dto=guestService.view_Guest(userid);//게스트 정보 불러오기
		dto=roomsService.detailRooms(room_idx);//룸정보 불러오기
		
		logger.info(dto.toString());
		logger.info(g_dto.toString());
		
		mav.addObject("checkin_date", checkin_date);
		mav.addObject("checkout_date", checkout_date);
		mav.addObject("res_person", res_person);
		mav.addObject("night", night);
		
		mav.addObject("room", dto);
		mav.addObject("guest", g_dto);
		mav.setViewName("reservations/res_detail");
		return mav;
	}
	
	//결제 완료 페이지
	//예약테이블에 정보 저장
	@RequestMapping("result.do")
	public String pay_result(@ModelAttribute ReservationsDTO dto, HttpSession session) throws Exception{
		//세션의 게스트 아이디를 가져옴 
  		String userid=(String)session.getAttribute("userid");
		if(userid==null) { //로그아웃 상태
			return "guest/guest_login";
		 }
		GuestDTO g_dto=guestService.view_Guest(userid);
		String name=g_dto.getName();
		String phone=g_dto.getPhone();
		
		dto.setUserid(userid);
		dto.setName(name);		
		dto.setPhone(phone);
		reservationsService.insert(dto);//레코드 저장
		//결제 후 게스트의 예약내역 페이지로 이동
		return "redirect:/reservations/list/guest";
		//return "redirect:/";
	}
	
	//게스트의 예약내역 페이지
	@RequestMapping("list/guest")
	public ModelAndView guestReservations(HttpSession session, ModelAndView mav) {
		//세션의 게스트 아이디를 가져옴
  		String userid=(String)session.getAttribute("userid");
		if(userid==null) { //로그아웃 상태
			mav.setViewName("guest/guest_login");
			return mav;
		}
		List<ReservationsDTO> list;
		try {
			list = reservationsService.guestResList(userid);
			logger.info("예약된정보"+list.toString());
			
			mav.addObject("resList", list);
			mav.setViewName("reservations/list_guest");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//게스트가 예약취소
	@RequestMapping("cancel")
	public String cancel(int res_idx) throws Exception {
		reservationsService.reserveCancel(res_idx);
		return "redirect:/reservations/list/guest";
	}
	
	//예약정보 팝업
	@RequestMapping("popupDeatil")
	public ModelAndView detail(int res_idx, ModelAndView mav,HttpSession session) {
		String userid=(String)session.getAttribute("userid");
		if(userid==null) { //로그아웃 상태
			mav.setViewName("guest/guest_login");
			return mav;
		}
		ReservationsDTO res_dto=reservationsService.getReserveDetail(res_idx);
		RoomsDTO r_dto=roomsService.detailRooms(res_dto.getRoom_idx());
		
		mav.addObject("res", res_dto);
		mav.addObject("room", r_dto);
		mav.setViewName("reservations/popupDetail");
		return mav;
	}
	
	//호스트의 예약내역 페이지
	@RequestMapping("list/host")
	public ModelAndView hostReservations(HttpSession session, ModelAndView mav) {
		//세션의 게스트 아이디를 가져옴
  		String h_userid=(String)session.getAttribute("h_userid");
		if(h_userid==null) { //로그아웃 상태
			mav.setViewName("host/login");
			return mav;
		}		
		
		List<ReservationsDTO> list;
		try {
			list = reservationsService.hostResList(h_userid);
			logger.info(list.toString());
			
			mav.addObject("resList", list);
			mav.setViewName("reservations/list_host");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//호스트의 예약승인
	@RequestMapping("approve")
	public String approve(int res_idx) throws Exception {
		reservationsService.reserveApprove(res_idx);
		return "redirect:/reservations/list/host";
	}
	
	//호스트의 예약거절
	@RequestMapping("refuse")
	public String refuse(int res_idx) throws Exception {
		reservationsService.reserveCancel(res_idx);
		return "redirect:/reservations/list/host";
	}
	
	//호스트의 입실완료 처리	
	@RequestMapping("checkin")
	public String checkin(int res_idx) throws Exception {
		reservationsService.reserveCheckin(res_idx);
		return "redirect:/reservations/list/host";
	}

	//호스트의 퇴실완료 처리	
	@RequestMapping("checkout")
	public String checkout(int res_idx) throws Exception {
		reservationsService.reserveCheckout(res_idx);
		return "redirect:/reservations/list/host";
	}
	
}
