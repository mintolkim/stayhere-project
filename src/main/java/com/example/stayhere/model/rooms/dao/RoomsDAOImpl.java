package com.example.stayhere.model.rooms.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

@Repository
public class RoomsDAOImpl implements RoomsDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public RoomsDTO detailRooms(int room_idx) {
		return sqlSession.selectOne("rooms.detail_rooms", room_idx);
	}

}
