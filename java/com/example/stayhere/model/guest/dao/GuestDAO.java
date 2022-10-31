package com.example.stayhere.model.guest.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.stayhere.model.guest.dto.GuestDTO;

public interface GuestDAO {
	public List<GuestDTO> list_guest();
	public void insert_Guest(GuestDTO dto);
	public void update_Guest(GuestDTO dto);
	public void delete_Guest(String userid);
	public boolean loginCheck(GuestDTO dto);
	public GuestDTO view_Guest(String userid);
	public boolean checkPw(String userid, String passwd);
	public int idCheck(String userid) throws Exception;
	public Integer loginLookup(GuestDTO dto);
}
