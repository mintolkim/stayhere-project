package com.example.stayhere.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.service.host.HostService;

@RequestMapping("host/*")
@Controller
public class HostController {
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@Inject
	HostService hostService;

	@RequestMapping("login.do")
	public String login() {
		return "host/login";
	} 
	
	@RequestMapping("login_check")
	public ModelAndView login_check(HostDTO dto, HttpSession session, ModelAndView mav) {
		boolean result = hostService.loginCheck(dto, session);
		if(result) {
			mav.setViewName("redirect:/main");
		}else {
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
	
	@RequestMapping("insert.do")
	public ModelAndView insert(HostDTO host, ModelAndView mav) {
		hostService.insert(host);
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
		boolean result = hostService.loginCheck(dto, session);
		HostDTO dto2= hostService.viewHost(dto.getH_userid());
		session.setAttribute("h_userid", dto.getH_userid());
		session.setAttribute("h_name", dto2.getH_name());
		if(result) {
			mav.addObject("dto", dto2);
			mav.setViewName("host/profile_update");
		}else {
			mav.addObject("message", "confirmPw");
			mav.setViewName("host/confirm_pw");
		}
		return mav;
	}
	
	
	@RequestMapping("updateImg")
	public ModelAndView updateImg (HostDTO dto, HttpSession session, MultipartFile file, ModelAndView mav) throws Exception{
		
		String h_userid=(String)session.getAttribute("h_userid");
		dto.setH_userid(h_userid);
		String H_profile_img = dto.getH_profile_img();
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String fileName = null;

		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		   fileName =  FileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes());   
		   mav.addObject("message","profile");
		   dto.setH_profile_img(File.separator + "imgUpload" + File.separator + fileName);
		} else {//file name dto.get으로 불러와서 저장 null이면
		   fileName = H_profile_img;
		   System.out.println(fileName);
		   dto.setH_profile_img(fileName);
		}
		
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
		boolean result = hostService.loginCheck(dto, session);
		HostDTO dto2= hostService.viewHost(dto.getH_userid());
		session.setAttribute("h_userid", dto.getH_userid());
		if(result) {
			mav.addObject("dto", dto2);
			mav.setViewName("host/delete");
		}else {
			mav.addObject("message", "confirmPw");
			mav.setViewName("host/confirm_pw");
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
	
	@RequestMapping("rooms_Confirm/{h_userid}")
	public ModelAndView rooms_Confirm(@PathVariable String h_userid,ModelAndView mav) {
		mav.setViewName("host/rooms_Confirm");
		List<RoomsDTO> list = hostService.rooms_Confirm(h_userid);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		mav.addObject("map", map);

		return mav;
	}
	
	@RequestMapping("rooms_List/{h_userid}")
	public ModelAndView rooms_Management(@PathVariable String h_userid,ModelAndView mav) {
		mav.setViewName("host/rooms_List");
		List<RoomsDTO> list = hostService.rooms_Confirm(h_userid);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		mav.addObject("map", map);
		return mav;
	}
}
