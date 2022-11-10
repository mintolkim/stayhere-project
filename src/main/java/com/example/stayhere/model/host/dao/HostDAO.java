package com.example.stayhere.model.host.dao;



import java.util.Date;
import java.util.List;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
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
	 public List<RoomsDTO> rooms_Confirm(String h_userid);
	 public List<RoomsDTO> rooms_List(int start, int end, String h_userid);
	 public boolean delete_check(RoomsDTO dto);
	 public int getRoomCount(String h_userid,String select); //룸 목록 
	 public int getConfirmRoom(String h_userid); //승인된목록 
	 public int emailCheck(String h_email);
	 public List<RoomsDTO> rooms_money(String h_userid,Date check_in);
	public int hostcount();//전체회원수
	public List<HostDTO> gethost(int start, int end);//전체 호스트목록
	public void goh_normal(String h_userid);//일반호스트 전환
	public void goh_black(String h_userid);//블랙호스트 전환
	public int blackhostcount();//블랙호스트수
	public List<HostDTO> getblackhost(int start, int end);//블랙호스트만
	public List<RoomsDTO> getroom(String h_userid);//호스트숙소불러오기
	public List<ReservationsDTO> hostMontlyMoney(String h_userid);
	public List<ReservationsDTO> hostWeeklyMoney(String h_userid,String today,String week);
	public List<ReservationsDTO> getRoomData(String h_userid);
	public Integer weeklySum(String h_userid, String today,String week);
	public int yearSum(String h_userid);
	public boolean resCheck(String h_userid);
}
