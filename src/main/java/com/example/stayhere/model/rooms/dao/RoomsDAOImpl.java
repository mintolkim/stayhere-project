
package com.example.stayhere.model.rooms.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.util.DateParse;
@Repository
public class RoomsDAOImpl implements RoomsDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<RoomsDTO> listMap(String cityname,RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date) {
		Map<String,Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("bed",roomdto.getBeds());
		map.put("bath", roomdto.getBaths());
		map.put("reviewStar", roomdto.getReview_star());
		map.put("lower", lower);
		map.put("higher",higher);
		map.put("checkin_date",DateParse.dateToStr(checkin_date));
		map.put("checkout_date",DateParse.dateToStr(checkout_date));
		return sqlSession.selectList("search.listMap",map);
	}

	@Override
	public int countrooms(String cityname,RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date) {
		Map<String,Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("bed",roomdto.getBeds());
		map.put("bath", roomdto.getBaths());
		map.put("reviewStar", roomdto.getReview_star());
		map.put("lower", lower);
		map.put("higher",higher);
		map.put("checkin_date",DateParse.dateToStr(checkin_date));
		map.put("checkout_date",DateParse.dateToStr(checkout_date));
		return sqlSession.selectOne("search.countrooms",map);
	}

	@Override
	public List<RoomsDTO> address_list(String cityname,RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date) {
		Map<String,Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("bed",roomdto.getBeds());
		map.put("bath", roomdto.getBaths());
		map.put("reviewStar", roomdto.getReview_star());
		map.put("lower", lower);
		map.put("higher",higher);
		map.put("checkin_date",DateParse.dateToStr(checkin_date));
		map.put("checkout_date",DateParse.dateToStr(checkout_date));
		return sqlSession.selectList("search.address_list",map);
	}
  
	@Override
	public RoomsDTO detailRooms(int room_idx) {
		return sqlSession.selectOne("rooms.detail_rooms", room_idx);
	}
  	
	@Override
	public List<RoomsDTO> getRoomAllList(int start, int end, String today) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("today", today);
		return sqlSession.selectList("rooms.getRoomAllList", map);
	}


	@Override
	public int getRoomAllCount(String today) {
		return sqlSession.selectOne("rooms.getRoomAllCount", today);
	}
	
	@Override
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date) {
		Map<String, Object> map = new HashMap<>();
		map.put("cityname", "%"+cityname+"%");
		map.put("checkin_date", DateParse.dateToStr(checkin_date));
		map.put("checkout_date", DateParse.dateToStr(checkout_date));
		return sqlSession.selectOne("search.getRoomDefalutCount", map);
	}

	@Override
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, String checkin_date,
			String checkout_date) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("cityname", "%"+cityname+"%");
		map.put("checkin_date", DateParse.dateToStr(checkin_date));
		map.put("checkout_date", DateParse.dateToStr(checkout_date));
		return sqlSession.selectList("search.getRoomDefalutList", map);
	}

	@Override
	public int getRoomOptionCount(Map<String, Object> param) {
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

	@Override
	public List<String> matchDetail(int room_idx) {
		return sqlSession.selectList("rooms.matchDetail", room_idx);
	}	
	
	
}

