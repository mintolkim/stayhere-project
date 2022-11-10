package com.example.stayhere.model.reservations.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.reservations.dto.ReservedDTO;

@Repository
public class ReservationsDAOImpl implements ReservationsDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public List<ReservationsDTO> guestResList (String userid) {
		return sqlSession.selectList("reservations.guestResList", userid);
	}
	
	@Override
	public List<ReservationsDTO> hostResList(String h_userid) {
		return sqlSession.selectList("reservations.hostResList", h_userid);
	}
	
	@Override
	public ReservationsDTO getReserveDetail(int res_idx) {
		return sqlSession.selectOne("reservations.getReserveDetail", res_idx);
	}

	@Override
	public void insert(ReservationsDTO dto) {
		sqlSession.insert("reservations.insert", dto);
	}

	@Override
	public int countAllRes(String userid) {
		return sqlSession.selectOne("reservations.countAllRes", userid);
	}

	@Override
	public void insertReserved(ReservedDTO r_dto) throws Exception {
		sqlSession.insert("reservations.insertReserved",r_dto);
	}

	@Override
	public void refuseStatus(int res_idx) {
		sqlSession.update("reservations.refuseStatus", res_idx);
	}

	@Override
	public void reserveCancel(ReservationsDTO dto) {
		sqlSession.delete("reservations.reserveCancel", dto);
	}

	@Override
	public void approveStatus(int res_idx) {
		sqlSession.update("reservations.approveStatus", res_idx);
	}

	@Override
	public void checkinStatus(int res_idx) {
		sqlSession.update("reservations.checkinStatus", res_idx);
	}

	@Override
	public void checkoutStatus(int res_idx) {
		sqlSession.update("reservations.checkoutStatus", res_idx);
	}

	@Override
	public List<ReservationsDTO> resTotalMoney() {
		return sqlSession.selectList("reservations.totalmoney");
	}

	@Override
	public List<ReservationsDTO> resCateTotalMoney() {
		return sqlSession.selectList("reservations.catetotalmoney");
	}

	@Override
	public List<ReservationsDTO> roomreservation(int room_idx) {
		return sqlSession.selectList("reservations.roomreservation",room_idx);
	}

	@Override
	public int getThismonth(String today) {
		return sqlSession.selectOne("reservations.getThismonth",today);
	}

	@Override
	public int getThisyear(String today) {
		return sqlSession.selectOne("reservations.getThisyear",today);
	}

	public int resdateCheck(String room_idx, String checkin_date, String checkout_date) {
		Map<String,Object> map = new HashMap<>();
		map.put("room_idx", room_idx);
		map.put("checkin_date", checkin_date);
		map.put("checkout_date", checkout_date);
		return sqlSession.selectOne("reservations.resdateCheck", map);
	}

	@Override
	public int cntRequest(String userid) {
		return sqlSession.selectOne("reservations.cntRequest",userid);
	}

	@Override
	public int cntApprove(String userid) {
		return sqlSession.selectOne("reservations.cntApprove",userid);

	}

	@Override
	public int cntCancel(String userid) {
		return sqlSession.selectOne("reservations.cntCancel",userid);

	}

	@Override
	public int cntUse(String userid) {
		return sqlSession.selectOne("reservations.cntUse", userid);
	}

	@Override
	public int cntCheckout(String userid) {
		return sqlSession.selectOne("reservations.cntCheckout",userid);

	}

	@Override
	public int h_cntRequest(String h_userid) {
		return sqlSession.selectOne("reservations.h_cntRequest", h_userid);
	}

	@Override
	public int h_cntApprove(String h_userid) {
		return sqlSession.selectOne("reservations.h_cntApprove", h_userid);
	}

	@Override
	public int h_cntCancel(String h_userid) {
		return sqlSession.selectOne("reservations.h_cntCancel", h_userid);
	}

	@Override
	public int h_cntCheckout(String h_userid) {
		return sqlSession.selectOne("reservations.h_cntCheckout", h_userid);
	}

	@Override
	public int h_cntUse(String h_userid) {
		return sqlSession.selectOne("reservations.h_cntUse", h_userid);
	}

	@Override
	public ReservationsDTO mailReserve(int room_idx, String checkin_date, String checkout_date) {
		Map<String,Object> map = new HashMap<>();
		map.put("room_idx", room_idx);
		map.put("checkin_date", checkin_date);
		map.put("checkout_date", checkout_date);
		return sqlSession.selectOne("reservations.mailReserve", map);
	}

	@Override
	public void reviewCheck(int res_idx) {
		sqlSession.update("reservations.reviewCheck" ,res_idx);
	}


}
