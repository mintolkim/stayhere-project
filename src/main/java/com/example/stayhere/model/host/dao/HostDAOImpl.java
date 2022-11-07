package com.example.stayhere.model.host.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

@Repository
public class HostDAOImpl implements HostDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public boolean loginCheck(HostDTO dto) {
		String name = sqlSession.selectOne("host.logcheck",dto);
		return (name==null) ? false : true;
	} 
	
	@Override
	public HostDTO viewHost(String h_userid) {
		return sqlSession.selectOne("host.viewHost",h_userid);
	} 
	
	@Override
	public void insert(HostDTO host) {
		sqlSession.insert("host.insert",host);
	}

	@Override
	public int idCheck(String h_userid) {
		int cnt = sqlSession.selectOne("host.idCheck",h_userid);
		return cnt;
	}

	@Override
	public void update(HostDTO host) {
		sqlSession.update("host.update",host);

	}

	@Override
	public void delete(String h_userid) {
		sqlSession.delete("host.delete",h_userid);
	}
	
	@Override
	public List<RoomsDTO> rooms_Confirm(String h_userid) {
		return sqlSession.selectList("host.rooms_Confirm",h_userid);
	}
	
	@Override
	public boolean delete_check(RoomsDTO dto) {
		List<Boolean> room_name = sqlSession.selectList("host.delete_check",dto);
		System.out.println(room_name.toString());
		return (room_name.toString()=="[]") ? false : true;
	}

	@Override
	public int hostcount() {
		return sqlSession.selectOne("host.hostcount");
	}

	@Override
	public List<HostDTO> gethost(int start, int end) {
		Map<String,Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("host.gethost",map);
	}

	@Override
	public void goh_normal(String h_userid) {
		sqlSession.update("host.goh_normal",h_userid);
	}

	@Override
	public void goh_black(String h_userid) {
		sqlSession.update("host.goh_black",h_userid);
	}

	@Override
	public List<HostDTO> getblackhost(int start, int end) {
		Map<String,Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("host.getblackhost",map);
	}

	@Override
	public int blackhostcount() {
		return sqlSession.selectOne("host.blackhostcount");
	}

	@Override
	public List<RoomsDTO> getroom(String h_userid) {
		return sqlSession.selectList("host.getroom",h_userid);
	}


}
