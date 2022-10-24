package com.example.stayhere.controller;

import java.io.File;
import java.util.Iterator;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.stayhere.model.host.dao.HostDAO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.service.host.HostService;
import com.mysql.cj.api.Session;

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
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(HostDTO dto, HttpSession session, ModelAndView mav) {
		boolean result = hostService.loginCheck(dto, session);
		if(result) {
			mav.setViewName("main");
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
		return "host/confirm_pw";
	}
	
	@RequestMapping("confirmPw.do")
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
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String fileName = null;

		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		   fileName =  FileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes());   
		   mav.addObject("message","profile");
		} else {//file name dto.get으로 불러와서 저장 null값이면
		   fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}
		
		dto.setH_profile_img(File.separator + "imgUpload" + File.separator + fileName);
		
		hostService.update(dto);

		mav.addObject("dto", hostService.viewHost(h_userid));
		mav.setViewName("host/profile");
		
		return mav;
	}
	
	@RequestMapping("delete.do")
	public String delete() {
		return "host/delete_pw";
	}
	
	@RequestMapping("deletePw.do")
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
	public ModelAndView delete_host(@PathVariable String h_userid,ModelAndView mav,HttpSession session) {
		hostService.delete(h_userid,session);
		mav.addObject("message", "delete");
		mav.setViewName("main");
		return mav;
	}

}
