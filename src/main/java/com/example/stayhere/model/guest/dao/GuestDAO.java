package com.example.stayhere.model.guest.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.stayhere.model.guest.dto.GuestDTO;

public interface GuestDAO {
	public List<GuestDTO> list_guest(); //회원목록
	public void insert_Guest(GuestDTO dto); //회원 가입
	public void update_Guest(GuestDTO dto); //회원 수정
	public void delete_Guest(String userid); //회원 삭제
	public GuestDTO loginCheck(GuestDTO dto); //로그인 체크
	public GuestDTO view_Guest(String userid); //회원 상세보기
	public boolean checkPw(String userid, String passwd); //비밀번호확인
	public int idCheck(String userid) throws Exception; //중복 아이디 체크
	public Integer loginLookup(GuestDTO dto); //
	public int updatePw(GuestDTO dto) throws Exception; //비번변경
	public int emailCheck(String email); //중복 이메일 체크
	public GuestDTO loginOkNick(GuestDTO dto);
	public String memberOne(String email) throws Exception;
	public String findId(String email);

}
