package com.example.stayhere.model.reservations.dao;

import java.util.List;

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
	public int countRes(String userid, int res_idx) {
		// TODO Auto-generated method stub
		return 0;
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

}
