package com.example.stayhere.service.guest;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.example.stayhere.model.guest.dto.GuestDTO;

public interface GuestService {
	public List<GuestDTO> list_guest();
	public void insert_Guest(GuestDTO dto);
	public void update_Guest(GuestDTO dto);
	public void delete_Guest(String userid);
	public boolean loginCheck(GuestDTO dto, HttpSession session);
	public void logout(HttpSession session);
	public GuestDTO view_Guest(String userid);
	public boolean checkPw(String userid, String passwd);
	public int idCheck(String userid) throws Exception;
	public int loginLookup(GuestDTO dto);
}
