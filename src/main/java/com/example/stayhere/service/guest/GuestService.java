package com.example.stayhere.service.guest;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.stayhere.model.guest.dto.GuestDTO;

public interface GuestService {
	public List<GuestDTO> list_guest();
	public void insert_Guest(GuestDTO dto);
	public void update_Guest(GuestDTO dto);
	public void delete_Guest(String userid);
	public GuestDTO loginCheck(GuestDTO dto, HttpSession session);
	public void logout(HttpSession session);
	public GuestDTO view_Guest(String userid);
	public boolean checkPw(String userid, String passwd);
	public int idCheck(String userid) throws Exception;
	public int loginLookup(GuestDTO dto);
	public void sendEmail(GuestDTO dto, String div, String num) throws Exception; //이메일발송
	public void findPw(HttpServletResponse resp, GuestDTO dto) throws Exception; //비밀번호찾기
	public int emailCheck(String email); //중복 이메일 체크
	//public void authEmail(HttpServletResponse response, HttpSession session, GuestDTO dto) throws Exception; //이메일인증
	public GuestDTO loginOkNick(GuestDTO dto);
	public String memberOne(String email) throws Exception;
	public String findId(String email);
}
