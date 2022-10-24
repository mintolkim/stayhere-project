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
	

}
