package com.example.stayhere.model.rooms.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

@Repository
public class RoomsDAOImpl implements RoomsDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<RoomsDTO> getRoomAllList(int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("rooms.getRoomAllList", map);
	}

	@Override
	public List<String> getRoomPhoto(int room_idx) {
		return sqlSession.selectList("rooms.getRoomPhoto", room_idx);
	}

	@Override
	public int getRoomAllCount() {
		return sqlSession.selectOne("rooms.getRoomAllCount");
	}

	@Override
	public int getRoomOptionCount(String city, String check_in, String check_out) {
		Map<String, Object> map = new HashMap<>();
		map.put("city", city);
		map.put("check_in", check_in);
		map.put("check_out", check_out);
		return sqlSession.selectOne("rooms.getRoomOptionCount", map);
	}

	@Override
	public List<RoomsDTO> getRoomOptionList(int start, int end, String city, String check_in, String check_out) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("city", city);
		map.put("check_in", check_in);
		map.put("check_out", check_out);
		return sqlSession.selectList("rooms.getRoomOptionList", map);
	}

}
