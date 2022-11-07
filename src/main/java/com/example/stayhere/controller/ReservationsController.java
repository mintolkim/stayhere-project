package com.example.stayhere.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		
		logger.info("예약하려는 숙소 정보"+dto);
		logger.info("예약자 정보"+g_dto);
		
		mav.addObject("checkin_date", checkin_date);
		mav.addObject("checkout_date", checkout_date);
		mav.addObject("res_person", res_person);
		mav.addObject("night", night);
		
		mav.addObject("room", dto);
		mav.addObject("guest", g_dto);
		mav.setViewName("reservations/res_detail");
		return mav;
	}
	
	//숙소 상세페이지에서 날짜 변경 시 중복날짜 체크(사용X)
	@RequestMapping("resdate_check")
	@ResponseBody
	public int resdate_check(
			@RequestParam("room_idx") String room_idx, 
			@RequestParam("checkin_date") String checkin_date, 
			@RequestParam("checkout_date") String checkout_date
			) {
		
		int result = reservationsService.resdateCheck(room_idx, checkin_date, checkout_date);

		return result;
	}
	
	//결제 완료 페이지
	//예약테이블에 정보 저장 및 게스트, 호스트에게 예약완료 메일 전송
	@Transactional
	@RequestMapping("result.do")
	public String pay_result(@ModelAttribute ReservationsDTO dto, HttpSession session) throws Exception{
		//세션의 게스트 아이디를 가져옴 
  		String userid=(String)session.getAttribute("userid");
		if(userid==null) { //로그아웃 상태
			return "guest/guest_login";
		 }
		//userid로 게스트의 정보를 가져옴 
		GuestDTO g_dto=guestService.view_Guest(userid);
		String name=g_dto.getName();
		String phone=g_dto.getPhone();

		//게스트의 정보를 예약dto에 저장
		dto.setUserid(userid);
		dto.setName(name);
		dto.setPhone(phone);
		reservationsService.insert(dto);//레코드 저장
		
		//게스트에게 예약 완료 메일 전송 (게스트dto,div이름,예약dto)
		reservationsService.sendEmail(g_dto, "reserveMail", dto);
		logger.info("1.예약한 게스트 정보"+g_dto);
		logger.info("2.예약정보"+dto);
		
		//h_userid로 호스트의 정보를 가져옴
		HostDTO h_dto=hostService.viewHost(dto.getH_userid());
		
		//호스트에게 예약 완료 메일 전송
		reservationsService.h_sendEmail(h_dto, "h_reserveMail", dto);
		logger.info("예약된 숙소 호스트 정보"+h_dto);
		
		//결제 후 게스트의 예약내역 페이지로 이동
		return "redirect:/reservations/list/guest";
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
			int cntRequest=reservationsService.cntRequest(userid);
			logger.info("예약요청 개수"+cntRequest);

			int cntApprove=reservationsService.cntApprove(userid);
			logger.info("예약완료 개수"+cntApprove);
			
			int cntCancel=reservationsService.cntCancel(userid);
			logger.info("취소완료 개수"+cntCancel);
				
			int cntUse=reservationsService.cntUse(userid);
			logger.info("이용중 개수"+cntUse);
			
			int cntCheckout=reservationsService.cntCheckout(userid);
			logger.info("이용완료 개수"+cntCheckout);
			
			list=reservationsService.guestResList(userid);
			logger.info("예약정보 : "+list.toString());
			
			GuestDTO g_dto=guestService.view_Guest(userid);
			logger.info("예약자 정보 : "+g_dto.toString());
				
			mav.addObject("cntRequest", cntRequest);
			mav.addObject("cntApprove", cntApprove);
			mav.addObject("cntCancel", cntCancel);
			mav.addObject("cntUse", cntUse);
			mav.addObject("cntCheckout", cntCheckout);
			mav.addObject("resList", list);
			mav.addObject("guest", g_dto);	
			mav.setViewName("reservations/list_guest");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//게스트가 예약취소
	@RequestMapping("cancel.do")
	public String cancel(int res_idx) throws Exception {
		reservationsService.reserveCancel(res_idx);
		return "redirect:/reservations/list/guest";
	}
	
	//예약정보 팝업
	@RequestMapping("popupDeatil.do")
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
			
			int h_cntRequest=reservationsService.h_cntRequest(h_userid);
			logger.info("예약요청 개수"+h_cntRequest);

			int h_cntApprove=reservationsService.h_cntApprove(h_userid);
			logger.info("예약완료 개수"+h_cntApprove);
			
			int h_cntCancel=reservationsService.h_cntCancel(h_userid);
			logger.info("취소완료 개수"+h_cntCancel);
				
			int h_cntUse=reservationsService.h_cntUse(h_userid);
			logger.info("이용중 개수"+h_cntUse);
			
			int h_cntCheckout=reservationsService.h_cntCheckout(h_userid);
			logger.info("이용완료 개수"+h_cntCheckout);
			
			list = reservationsService.hostResList(h_userid);
			logger.info(list.toString());
			
			mav.addObject("h_cntRequest", h_cntRequest);
			mav.addObject("h_cntApprove", h_cntApprove);
			mav.addObject("h_cntCancel", h_cntCancel);
			mav.addObject("h_cntUse", h_cntUse);
			mav.addObject("h_cntCheckout", h_cntCheckout);
			mav.addObject("resList", list);
			mav.setViewName("reservations/list_host");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//호스트의 예약승인
	@RequestMapping("approve.do")
	public String approve(int res_idx) throws Exception {
		reservationsService.reserveApprove(res_idx);
		return "redirect:/reservations/list/host";
	}
	
	//호스트의 예약거절
	@RequestMapping("refuse.do")
	public String refuse(int res_idx) throws Exception {
		reservationsService.reserveCancel(res_idx);
		return "redirect:/reservations/list/host";
	}
	
	//호스트의 입실완료 처리	
	@RequestMapping("checkin.do")
	public String checkin(int res_idx) throws Exception {
		reservationsService.reserveCheckin(res_idx);
		return "redirect:/reservations/list/host";
	}

	//호스트의 퇴실완료 처리	
	@RequestMapping("checkout.do")
	public String checkout(int res_idx) throws Exception {
		reservationsService.reserveCheckout(res_idx);
		return "redirect:/reservations/list/host";
	}
	
}
