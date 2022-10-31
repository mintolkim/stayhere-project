
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

	@Override
	public void insert(RoomsDTO dto) {
		sqlSession.insert("rooms.insert",dto);
	}
	
	@Override
	public RoomsDTO getRoomInfo(int room_idx) {
		return sqlSession.selectOne("rooms.getRoomInfo", room_idx);
	}
	
	@Override
	public void deleteConfirm(int room_idx) {
		sqlSession.update("rooms.deleteConfirm",room_idx);
	}
	
	@Override
	public void updateRoom(RoomsDTO dto) {
		sqlSession.update("rooms.updateRoom",dto);
	}
	
	@Override
	public void updateRoomphoto(RoomsDTO dto) {
		sqlSession.update("rooms.updateRoomphoto",dto);
	}

}

