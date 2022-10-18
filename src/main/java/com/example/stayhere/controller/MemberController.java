package com.example.stayhere.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.stayhere.model.dto.MemberDTO;
import com.example.stayhere.service.MemberService;

@Controller  //컨트롤러 빈으로 등록
public class MemberController {
	//MemberSerivce 인스턴스 주입
	@Inject
	MemberService memberService;
	
	@RequestMapping("member/list.do")
	public String memberList(Model model) {
		List<MemberDTO> list = memberService.memberList();
		model.addAttribute("list", list);
		return "member/member_list";
	}	
	
}
