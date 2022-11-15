package com.example.stayhere.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.review.dto.ReviewAccuseDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.admin.AdminService;
import com.example.stayhere.util.DateParse;
import com.example.stayhere.util.Pager;

@Controller
@RequestMapping("admin/*")
public class AdminController {
	
	@Inject
	AdminService adminService;
	
	@RequestMapping("main")
	public ModelAndView list() {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yy-MM-dd");
		String today = formatter.format(date);//오늘날짜
		//1. 이번달 매출
		int thismonth = adminService.getThismonth(today);
		//2. 이번년도 매출
		int thisyear = adminService.getThisyear(today);
		//3. 이번달 회원 유입수
		int monthguest = adminService.getmonthguest(today);
		//4. 총 회원수
		int totalguest = adminService.guestcount();
		//5. 이번달 최고 매출 숙소 top10
		List<RoomsDTO> roomlist = adminService.getpopular(today);
		//6. qna 답변대기 목록
		List<QnaDTO> qnalist = adminService.getqnalist();
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map=new HashMap<>();
		map.put("thismonth", thismonth);
		map.put("thisyear", thisyear);
		map.put("monthguest", monthguest);
		map.put("totalguest", totalguest);
		map.put("roomlist", roomlist);
		map.put("qnalist", qnalist);
		mav.setViewName("admin/admin_main");//포워딩할 뷰
		mav.addObject("map", map);
		return mav;
	}
	//전체 유저목록
	@RequestMapping("guest")
	public ModelAndView guest(@RequestParam(defaultValue = "1") int page) throws Exception {
		//전체회원수
		int count = adminService.guestcount();
		Pager pager=new Pager(8,count,page);
		int start=pager.getPageBegin();
		int end=pager.getPageEnd();
		List<GuestDTO> guestlist = adminService.getguest(start,end);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map=new HashMap<>();
		map.put("guestlist", guestlist);//map에 자료 저장
		map.put("count", count); //레코드 갯수 파일
		map.put("pager", pager); //페이지 네비게이션을 위한 변수
		map.put("page", page); //페이지 네비게이션을 위한 변수
		mav.setViewName("admin/admin_userlist");//포워딩할 뷰
		mav.addObject("map", map);//보낼 데이터
		return mav;
	}
	//블랙리스트전환
	@RequestMapping("goblack")
	public String goblack(@RequestParam String userid,@RequestParam(defaultValue = "1") int page) {
			adminService.goblack(userid);
		return "redirect:/admin/guest?page="+page;
	}
	//블랙호스트전환
		@RequestMapping("goh_black")
		public String goh_black(@RequestParam String h_userid,@RequestParam(defaultValue = "1") int page) {
				adminService.goh_black(h_userid);
			return "redirect:/admin/host?page="+page;
		}
	//일반회원전환
	@RequestMapping("gonormal")
	public String gonormal(@RequestParam String userid,@RequestParam(defaultValue = "1") int page) {
			adminService.gonormal(userid);
			return "redirect:/admin/guest?page="+page;
	}
	//일반호스트 전환
		@RequestMapping("goh_normal")
		public String goh_normal(@RequestParam String h_userid,@RequestParam(defaultValue = "1") int page) {
				adminService.goh_normal(h_userid);
				return "redirect:/admin/host?page"+page;
		}
	//전체 호스트목록
	@RequestMapping("host")
	public ModelAndView host(@RequestParam(defaultValue = "1") int page) throws Exception {
		//전체회원수
		int count = adminService.hostcount();
		Pager pager=new Pager(8,count,page);
		int start=pager.getPageBegin();
		int end=pager.getPageEnd();
		List<HostDTO> hostlist = adminService.gethost(start,end);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map=new HashMap<>();
		map.put("hostlist", hostlist);//map에 자료 저장
		map.put("count", count); //레코드 갯수 파일
		map.put("pager", pager); //페이지 네비게이션을 위한 변수
		map.put("page", page); //페이지 네비게이션을 위한 변수
		mav.setViewName("admin/admin_hostlist");//포워딩할 뷰
		mav.addObject("map", map);//보낼 데이터
		return mav;
	}
	//블랙게스트만보기
	@RequestMapping("blackguest")
	public ModelAndView blackguest(@RequestParam(defaultValue = "1") int page) throws Exception {
		//전체 블랙회원수
		int count = adminService.blackguestcount();
		Pager pager=new Pager(8,count,page);
		int start=pager.getPageBegin();
		int end=pager.getPageEnd();
		List<GuestDTO> blackguest = adminService.getblackguest(start,end);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map=new HashMap<>();
		map.put("blackguest", blackguest);//map에 자료 저장
		map.put("count", count); //레코드 갯수 파일
		map.put("pager", pager); //페이지 네비게이션을 위한 변수
		map.put("page", page); //페이지 네비게이션을 위한 변수
		mav.setViewName("admin/admin_userlist");//포워딩할 뷰
		mav.addObject("map", map);//보낼 데이터
		return mav;
	}
	//블랙호스트만보기
		@RequestMapping("blackhost")
		public ModelAndView blackhost(@RequestParam(defaultValue = "1") int page) throws Exception {
			//전체 블랙회원수
			int count = adminService.blackhostcount();
			Pager pager=new Pager(8,count,page);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			List<HostDTO> blackhost = adminService.getblackhost(start,end);
			ModelAndView mav = new ModelAndView();
			Map<String, Object> map=new HashMap<>();
			map.put("blackhost", blackhost);//map에 자료 저장
			map.put("count", count); //레코드 갯수 파일
			map.put("pager", pager); //페이지 네비게이션을 위한 변수
			map.put("page", page); //페이지 네비게이션을 위한 변수
			mav.setViewName("admin/admin_hostlist");//포워딩할 뷰
			mav.addObject("map", map);//보낼 데이터
			return mav;
		}
		//호스트숙소정보 불러오기
		@RequestMapping("roomdetail")
		public ModelAndView roomdetail(@RequestParam String h_userid) throws Exception {
			List<RoomsDTO> list = adminService.getroom(h_userid);
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("admin/roomdetail");
			return mav;
		}
		//게스트 리뷰글 불러오기
		@RequestMapping("reviewdetail")
		public ModelAndView reviewdetail(@RequestParam String userid) throws Exception {
			List<ReviewDTO> list = adminService.getreview(userid);
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("admin/reviewdetail");
			return mav;
		}
		
		//게스트신고글 불러오기
		@RequestMapping("accusedetail")
		public ModelAndView accusedetail(@RequestParam String userid) throws Exception {
			List<ReviewAccuseDTO> list = adminService.getaccuse(userid);
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("admin/accusedetail");
			return mav;
		}
		//게스트 예약내역 불러오기
		@RequestMapping("reservationdetail")
		public ModelAndView reservationdetail(@RequestParam String userid) throws Exception {
			List<ReservationsDTO> list = adminService.getreservation(userid);
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("admin/reservationdetail");
			return mav;
		}
		//전체 숙소목록
		@RequestMapping("rooms")
		public ModelAndView rooms(@RequestParam(defaultValue = "1") int page,
				@RequestParam(defaultValue = "room_idx") String select) throws Exception {
			//전체회원수
			String today = DateParse.strToDate(DateParse.getTodayPlus(1));
			int count = adminService.roomscount(today);
			Pager pager=new Pager(8,count,page);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			List<RoomsDTO> roomlist = adminService.getrooms(start,end,select);
			ModelAndView mav = new ModelAndView();
			Map<String, Object> map=new HashMap<>();
			map.put("roomlist", roomlist);//map에 자료 저장
			map.put("count", count); //레코드 갯수 파일
			map.put("select", select); 
			map.put("pager", pager); //페이지 네비게이션을 위한 변수
			map.put("page", page); //페이지 네비게이션을 위한 변수
			mav.setViewName("admin/admin_roomlist");//포워딩할 뷰
			mav.addObject("map", map);//보낼 데이터
			return mav;
		}
		//룸 리뷰글 불러오기
		@RequestMapping("roomreview")
		public ModelAndView roomreview(@RequestParam int room_idx) throws Exception {
			List<ReviewDTO> list = adminService.roomreview(room_idx);
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("admin/reviewdetail");
			return mav;
		}
		//룸 예약내역 불러오기
		@RequestMapping("roomreservation")
		public ModelAndView roomreservation(@RequestParam int room_idx) throws Exception {
			List<ReservationsDTO> list = adminService.roomreservation(room_idx);
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("admin/reservationdetail");
			return mav;
		}
		//숙소승인
		@RequestMapping("changestate")
		public String changestate(@RequestParam int room_idx, 
				@RequestParam String state,
				@RequestParam(defaultValue = "1") int page) {
				System.out.println("요청상태 : "+state+", room_idx: "+room_idx);
				adminService.changestate(room_idx,state);
				return "redirect:/admin/rooms?page="+page;
		}
		//숙소승인 현황판
		@RequestMapping("confirm")
		public ModelAndView confirm() throws Exception {
			List<RoomsDTO> confirmlist = adminService.getconfirm();
			List<RoomsDTO> delaylist = adminService.getdelay();
			List<RoomsDTO> rejectlist = adminService.getreject();
			ModelAndView mav = new ModelAndView();
			Map<String, Object> map=new HashMap<>();
			map.put("confirmlist", confirmlist);
			map.put("delaylist", delaylist); 
			map.put("rejectlist", rejectlist);
			mav.setViewName("admin/admin_confirmlist");//포워딩할 뷰
			mav.addObject("map", map);//보낼 데이터
			return mav;
		}
		//숙소승인
				@RequestMapping("roomConfirm")
				public String roomConfirm(@RequestParam int room_idx, 
						@RequestParam String state) {
						System.out.println("요청상태 : "+state+", room_idx: "+room_idx);
						adminService.changestate(room_idx,state);
						return "redirect:/admin/confirm";
				}
}
