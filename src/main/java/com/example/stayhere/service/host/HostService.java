package com.example.stayhere.service.host;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface HostService {
	 public HostDTO loginCheck(HostDTO dto, HttpSession session);
	 public HostDTO loginOkNick(HostDTO dto);
	 public HostDTO viewHost(String h_userid);
	 public void logout(HttpSession session);
	 public void insert(HostDTO host);
	 public void sendEmail(HostDTO dto, String div, String num) throws Exception;
	 public void findPw(HttpServletResponse response, HostDTO dto) throws Exception;
	 public int idCheck(String h_userid);
	 public void update(HostDTO host);
	 public void delete(String h_userid,HttpSession session);
	 public List<RoomsDTO> rooms_Confirm(int start, int end, String h_userid, String select);
	 public List<RoomsDTO> rooms_List(int start, int end, String h_userid);
	 public boolean delete_check(RoomsDTO dto);
	 public int getRoomCount(String h_userid,String select); //룸 목록
	 public int getConfirmRoom(String h_userid); //룸 목록
	 public int emailCheck(String h_email);
	 public JSONObject getChartData(String h_userid);
	 public List<ReservationsDTO> hostMontlyMoney(String h_userid);
	 public JSONObject getweeklyData(String h_userid,String today,String week);
	 public List<ReservationsDTO> hostWeeklyMoney(String h_userid, String today,String week);
	 public JSONObject getRoom_Data(String h_userid);
	 public List<ReservationsDTO> getRoomData(String h_userid);
	 public Integer weeklySum(String h_userid, String today,String week);
	 public int yearSum(String h_userid);
	 public boolean resCheck(String h_userid);
	 
}
