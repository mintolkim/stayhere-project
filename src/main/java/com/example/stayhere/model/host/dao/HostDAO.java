package com.example.stayhere.model.host.dao;



import java.util.Date;
import java.util.List;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface HostDAO { 
	 public HostDTO loginCheck(HostDTO dto);
	 public HostDTO loginOkNick(HostDTO dto);
	 public HostDTO viewHost(String h_userid);
	 public void insert(HostDTO host);
	 public int idCheck(String h_userid);
	 public int updatePw(HostDTO dto) throws Exception;
	 public void update(HostDTO host); 
	 public void delete(String h_userid);
	 public List<RoomsDTO> rooms_Confirm(int start, int end, String h_userid, String select);
	 public List<RoomsDTO> rooms_List(int start, int end, String h_userid);
	 public boolean delete_check(RoomsDTO dto);
	 public int getRoomCount(String h_userid,String select); //룸 목록 
	 public int getConfirmRoom(String h_userid); //승인된목록 
	 public int emailCheck(String h_email);
	 public List<RoomsDTO> rooms_money(String h_userid,Date check_in);
}
