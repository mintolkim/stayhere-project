
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
	public List<RoomsDTO> listMap(String cityname,int bed, int bath, String reviewStar, int lower, int higher) {
		Map<String,Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("bed",bed );
		map.put("bath", bath);
		map.put("reviewStar", reviewStar);
		map.put("lower", lower);
		map.put("higher",higher);
		return sqlSession.selectList("search.listMap",map);
	}

	@Override
	public int countrooms(String cityname,int bed, int bath, String reviewStar, int lower, int higher) {
		Map<String,Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("bed",bed );
		map.put("bath", bath);
		map.put("reviewStar", reviewStar);
		map.put("lower", lower);
		map.put("higher",higher);
		return sqlSession.selectOne("search.countrooms",map);
	}

	@Override
	public List<RoomsDTO> address_list(String cityname,int bed, int bath, String reviewStar, int lower, int higher) {
		Map<String,Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("bed",bed );
		map.put("bath", bath);
		map.put("reviewStar", reviewStar);
		map.put("lower", lower);
		map.put("higher",higher);
		return sqlSession.selectList("search.address_list",map);
	}
  
  	@Override
	public RoomsDTO detailRooms(int room_idx) {
		return sqlSession.selectOne("rooms.detail_rooms", room_idx);
	}
  	
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
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date) {
		Map<String, Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("checkin_date", checkin_date);
		map.put("checkout_date", checkout_date);
		return sqlSession.selectOne("search.getRoomDefalutCount", map);
	}

	@Override
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, String checkin_date,
			String checkout_date) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("cityname", "%"+cityname+"%");
		map.put("checkin_date", checkin_date);
		map.put("checkout_date", checkout_date);
		return sqlSession.selectList("search.getRoomDefalutList", map);
	}
	

	@Override
	public int getRoomOptionCount(Map<String, Object> param) {
		String cityname = (String)param.get("cityname");
		param.put("cityname", "%"+cityname+"%");
		return sqlSession.selectOne("search.getRoomOptionCount", param);
	}

	@Override
	public List<RoomsDTO> getRoomOptionList(int start, int end,Map<String, Object> param) {
		param.put("start", start);
		param.put("end", end);
		return sqlSession.selectList("search.getRoomOptionList", param);
	}

	@Override
	public int findRoomMaxPrice() {
		return sqlSession.selectOne("search.findRoomMaxPrice");
	}

	@Override
	public int findRoomMinPrice() {
		return sqlSession.selectOne("search.findRoomMinPrice");
	}

}

