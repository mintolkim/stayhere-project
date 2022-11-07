package com.example.stayhere.service.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.guest.dao.GuestDAO;
import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dao.HostDAO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.qna.dao.QnaDAO;
import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.reservations.dao.ReservationsDAO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.review.dao.ReviewDAO;
import com.example.stayhere.model.review.dto.ReviewAccuseDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.rooms.dao.RoomsDAO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
@Service
public class AdminServiceImpl implements AdminService {
	
	@Inject
	GuestDAO guestdao;
	
	@Inject
	HostDAO hostdao;
	
	@Inject
	ReviewDAO reviewdao;
	
	@Inject
	ReservationsDAO resdao;
	
	@Inject
	RoomsDAO roomdao;
	
	@Inject 
	QnaDAO qnadao;
	
	@Override
	public List<GuestDTO> getguest(int start, int end) {
		return guestdao.getguest(start,end);
	}
	@Override
	public int guestcount() {
		return guestdao.guestcount();
	}
	@Override
	public void goblack(String userid) {
		guestdao.goblack(userid);
	}
	@Override
	public void gonormal(String userid) {
		guestdao.gonormal(userid);
	}
	@Override
	public int hostcount() {
		return hostdao.hostcount();
	}
	@Override
	public List<HostDTO> gethost(int start, int end) {
		return hostdao.gethost(start,end);
	}
	@Override
	public void goh_normal(String h_userid) {
		hostdao.goh_normal(h_userid);
	}
	@Override
	public void goh_black(String h_userid) {
		hostdao.goh_black(h_userid);
	}
	@Override
	public List<GuestDTO> getblackguest(int start, int end) {
		return guestdao.getblackguest(start,end);
	}
	@Override
	public int blackguestcount() {
		return guestdao.blackguestcount();
	}
	@Override
	public int blackhostcount() {
		return hostdao.blackhostcount();
	}
	@Override
	public List<HostDTO> getblackhost(int start, int end) {
		return hostdao.getblackhost(start,end);
	}
	@Override
	public List<RoomsDTO> getroom(String h_userid) {
		return hostdao.rooms_Confirm(h_userid);
	}
	@Override
	public List<ReviewDTO> getreview(String userid) {
		return reviewdao.getreview(userid);
	}
	@Override
	public List<ReviewAccuseDTO> getaccuse(String userid) {
		return reviewdao.getaccuse(userid);
	}
	@Override
	public List<ReservationsDTO> getreservation(String userid) {
		return resdao.guestResList(userid);
	}
	@Override
	public int roomscount(String today) {
		return roomdao.getRoomAllCount(today);
	}
	@Override
	public List<RoomsDTO> getrooms(int start, int end,String select) {
		return roomdao.allroom_admin(start, end, select);
	}
	@Override
	public List<ReviewDTO> roomreview(int room_idx) {
		return reviewdao.roomreview(room_idx);
	}
	@Override
	public List<ReservationsDTO> roomreservation(int room_idx) {
		return resdao.roomreservation(room_idx);
	}
	@Override
	public void changestate(int room_idx, String state) {
		roomdao.changestate(room_idx,state);
		
	}
	@Override
	public List<RoomsDTO> getconfirm() {
		return roomdao.getconfirm();
	}
	@Override
	public List<RoomsDTO> getdelay() {
		return roomdao.getdelay();
	}
	@Override
	public List<RoomsDTO> getreject() {
		return roomdao.getreject();
	}
	@Override
	public int getThismonth(String today) {
		return resdao.getThismonth(today);
	}
	@Override
	public int getThisyear(String today) {
		return resdao.getThisyear(today);
	}
	@Override
	public int getmonthguest(String today) {
		return guestdao.getmonthguest(today);
	}
	@Override
	public List<RoomsDTO> getpopular(String today) {
		return roomdao.getpopular(today);
	}
	@Override
	public List<QnaDTO> getqnalist() {
		return qnadao.getqnalist();
	}
	

}
