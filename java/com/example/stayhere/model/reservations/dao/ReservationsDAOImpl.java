package com.example.stayhere.model.reservations.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;

@Repository
public class ReservationsDAOImpl implements ReservationsDAO {

	@Inject
	SqlSession SqlSession;
	
	@Override
	public List<ReservationsDTO> listRes(String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(ReservationsDTO dto) {
		SqlSession.insert("reservations.insert", dto);
	}

	@Override
	public void update(int res_idx) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int res_idx) {
		// TODO Auto-generated method stub

	}

	@Override
	public int sumMoney(int room_price, int res_person) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int countRes(String userid, int res_idx) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void modifyRes(ReservationsDTO dto) {
		// TODO Auto-generated method stub

	}

}
