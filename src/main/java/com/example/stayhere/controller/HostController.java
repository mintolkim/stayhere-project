package com.example.stayhere.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.host.HostService;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.Pager;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("host/*")
public class HostController {
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@Inject
	HostService hostService;

	@Inject
	RoomsService roomsService;

	@RequestMapping("login.do")
	public String login() {
		return "host/login"; 
	}  
	
	@RequestMapping("login_check")
	public ModelAndView login_check(HostDTO dto, HttpSession session, ModelAndView mav) {
		//데이터베이스의 정보 가져오기
		HostDTO DBdto = hostService.viewHost(dto.getH_userid());
		dto.setH_name(DBdto.getH_name()); //가져온 데이터베이스 정보를 받아서 이름값 dto에 넣기
		//입력한 비밀번호와 db에 저장된 패스워드가 일치하는지 체크
		//pwdEncoder.matches(파라미터로 받은 패스워드값, DB에 저장되어 있는 패스워드값)
		boolean passcheck = pwdEncoder.matches(dto.getH_passwd(), DBdto.getH_passwd());
		if(passcheck) { //패스워드가 일치한다면 true
			dto.setH_passwd(DBdto.getH_passwd()); //db에서 가져온 패스워드를 dto에 저장
			boolean result = hostService.loginCheck(dto, session);
			if(result) { //로그인 체크 결과가 참이면 즉, 로그인 성공시
				mav.setViewName("redirect:/main");
			} else {
				mav.setViewName("host/login");
				mav.addObject("message", "error");
			}
		} else { //패스워드가 일치하지 않으면
			mav.setViewName("host/login");
			mav.addObject("message", "error");
		}
		return mav;
	}
	
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session,ModelAndView mav) {
		hostService.logout(session);
		mav.setViewName("host/login");
		mav.addObject("message", "logout");
		return mav;
	}
	
	@RequestMapping("join.do")
	public String join() {
		return "host/join";
	}
	
	@RequestMapping("idCheck.do")
	@ResponseBody
	public int idCheck(@RequestParam("h_userid") String h_userid) {
		int cnt = hostService.idCheck(h_userid);
		return cnt;
	}

	@RequestMapping("emailCheck.do")
	@ResponseBody
	public int emailCheck(@RequestParam("h_email") String h_email) {
		int cnt = hostService.emailCheck(h_email);
		return cnt;
	}

	/* 메일인증 */
	@RequestMapping(value="authokeyMail", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(@ModelAttribute HostDTO dto, HttpServletRequest request, HttpServletResponse response, String h_email) throws Exception {
		System.out.println("이메일"+h_email);

		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		System.out.println("인증번호 : " + checkNum);
		HttpSession session = request.getSession();
		String num = Integer.toString(checkNum);
		dto.setH_email(h_email);
		session.setAttribute("checkNum", checkNum);
		/* 인증키 전송 */
		//guestService.authEmail(response, session, dto);
		hostService.sendEmail(dto, "auth", num);
		//out.close();
		return num;

	}
	
	@RequestMapping("findPw.do")
	public String findPw() {
		return "host/findPw";
	}
	
	@RequestMapping(value = "findPw", method = RequestMethod.POST)
	public void findPwPOST(@ModelAttribute HostDTO dto, HttpServletResponse response) throws Exception{
		hostService.findPw(response, dto);
	}	
	
	@RequestMapping("insert.do")
	public ModelAndView insert(HostDTO dto, ModelAndView mav) {
		String inputpasswd = dto.getH_passwd();
		String encodeigpasswd = pwdEncoder.encode(inputpasswd);
		dto.setH_passwd(encodeigpasswd);
		hostService.insert(dto);
		mav.addObject("message","join");
		mav.setViewName("host/login");
		return mav;
	}
	
	@RequestMapping("profile/{h_userid}")
	public ModelAndView profile(@PathVariable String h_userid,ModelAndView mav) {
		mav.setViewName("host/profile");
		mav.addObject("dto", hostService.viewHost(h_userid));
		return mav;
	}
	
	@RequestMapping("edit.do")
	public String edit() {
		return "host/check_pw";
	}
	
	@RequestMapping("checkPw")
	public ModelAndView update(HostDTO dto, HttpSession session, ModelAndView mav) {
		String h_userid=(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		//저장된 아이디값으로 DB값 조회, 
		HostDTO DBdto = hostService.viewHost(dto.getH_userid());
		boolean passcheck = pwdEncoder.matches(dto.getH_passwd(), DBdto.getH_passwd());
		if(passcheck) {
			mav.addObject("dto", DBdto);
			mav.setViewName("host/profile_update");
		}else {
			mav.addObject("message", "confirmPw");
			mav.setViewName("host/check_pw");
		}
		return mav;
	}
	
	
	@RequestMapping("updateImg")
	public ModelAndView updateImg (HostDTO dto, HttpSession session, MultipartFile file, ModelAndView mav) throws Exception{
		
		String h_userid=(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		String H_profile_img = dto.getH_profile_img();
		//String imgUploadPath = uploadPath;
		String fileName = null;

		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		   fileName = FileUtils.fileUpload(uploadPath, file.getOriginalFilename(), file.getBytes());   
		   mav.addObject("message","profile");
		   dto.setH_profile_img(fileName);
		} else {//file name dto.get으로 불러와서 저장 null이면
		   fileName = H_profile_img;
		   System.out.println(fileName);
		   dto.setH_profile_img(fileName);
		}
		
		//입력받은 패스워드 (즉, 패스워드를 수정하지 않았다면)
		String inputPasswd = dto.getH_passwd();
		//현재 데이터베이스에 저장된 패스워드
		String dbPasswd = hostService.findByPasswd(dto.getH_userid());
		if(!inputPasswd.equals(dbPasswd)) { //두개의 값이 같지 않다면...
			//비밀번호 암호화 후 dto에 저장
			String encodePasswd = pwdEncoder.encode(inputPasswd);
			dto.setH_passwd(encodePasswd);
		} //만약 비밀번호가 일치한다면 암호화 없이 그대로 저장.
		
		hostService.update(dto);
		mav.addObject("dto", hostService.viewHost(h_userid));
		mav.setViewName("host/profile");
		return mav;
	}
	
	@RequestMapping("delete.do")
	public String delete() {
		return "host/delete_pw";
	}
	
	@RequestMapping("deletePw")
	public ModelAndView delete(HostDTO dto, HttpSession session, ModelAndView mav) {
		String h_userid=(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		HostDTO DBdto = hostService.viewHost(dto.getH_userid());
		boolean passcheck = pwdEncoder.matches(dto.getH_passwd(), DBdto.getH_passwd());
		session.setAttribute("h_userid", dto.getH_userid());
		if(passcheck) {
			mav.addObject("dto", DBdto);
			mav.setViewName("host/delete");
		}else {
			mav.addObject("message", "confirmPw");
			mav.setViewName("host/check_pw");
		}
		return mav;
	}
	
	@RequestMapping("delete/{h_userid}")
	public ModelAndView delete_host(@PathVariable String h_userid,ModelAndView mav,HttpSession session,RoomsDTO dto) {
			boolean result = hostService.delete_check(dto);
			
			if(result) {
				mav.addObject("message", "notDelete");
				mav.setViewName("host/delete_pw");
			}else {
				hostService.delete(h_userid,session);
				mav.addObject("message", "delete");
				mav.setViewName("main");
			}

			return mav;
	}
	
	@RequestMapping("rooms_Confirm.do")
	public ModelAndView rooms_Confirm(HttpSession session,ModelAndView mav,
									  @RequestParam(defaultValue="1") int curPage,
									  @RequestParam(defaultValue="승인대기") String select, RoomsDTO dto) {
		
		String h_userid =(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		
		Map<String, Object> map = new HashMap<>();
		
		int pageScale = 6; //게시물 표시 갯수
		int count = hostService.getRoomCount(h_userid,select);
		Pager pager = new Pager(pageScale, count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		
		List<RoomsDTO> list = hostService.rooms_Confirm(start,end,h_userid,select);
		
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("select", select);
		mav.addObject("map", map);
		
		if(list.size()==0) {
			mav.addObject("message", "exist");
		}

		mav.setViewName("host/rooms_Confirm");
		return mav;
	}
	
	@RequestMapping("rooms_List.do")
	public ModelAndView rooms_Management(HttpSession session,ModelAndView mav, 
										 @RequestParam(defaultValue ="1") int curPage, RoomsDTO dto) {
		
		String h_userid =(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		
		Map<String, Object> map = new HashMap<>();

		int pageScale = 6; //게시물 표시 갯수
		int count = hostService.getConfirmRoom(h_userid);
		Pager pager = new Pager(pageScale, count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<RoomsDTO> list = hostService.rooms_List(start,end,h_userid);
		
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		mav.addObject("map", map);
		
		if(count==0) {
			mav.addObject("message", "exist");
		}

		mav.setViewName("host/rooms_List");
		
		return mav;
	}
	
	@RequestMapping("rooms_Sales/{h_userid}")
	public ModelAndView rooms_Sales(@PathVariable String h_userid,ModelAndView mav) {
		mav.setViewName("host/rooms_Sales");
		mav.addObject("dto", hostService.viewHost(h_userid));
		return mav;
	}
}
