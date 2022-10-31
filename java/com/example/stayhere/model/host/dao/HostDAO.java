package com.example.stayhere.model.host.dao;



import java.util.List;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface HostDAO { 
	 public boolean loginCheck(HostDTO dto);
	 public HostDTO viewHost(String h_userid);
	 public void insert(HostDTO host);
	 public int idCheck(String h_userid);
	 public void update(HostDTO host); 
	 public void delete(String h_userid);
	 public List<RoomsDTO> rooms_Confirm(String h_userid);
	 public boolean delete_check(RoomsDTO dto);
}
