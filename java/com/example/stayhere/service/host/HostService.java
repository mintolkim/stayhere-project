package com.example.stayhere.service.host;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface HostService {
	 public boolean loginCheck(HostDTO dto, HttpSession session);
	 public HostDTO viewHost(String h_userid);
	 public void logout(HttpSession session);
	 public void insert(HostDTO host);
	 public int idCheck(String h_userid);
	 public void update(HostDTO host); 
	 public void delete(String h_userid,HttpSession session);
	 public List<RoomsDTO> rooms_Confirm(String h_userid);
	 public boolean delete_check(RoomsDTO dto);
}
