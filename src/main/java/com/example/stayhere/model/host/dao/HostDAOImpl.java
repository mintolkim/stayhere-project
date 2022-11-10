package com.example.stayhere.model.host.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

@Repository
public class HostDAOImpl implements HostDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public boolean loginCheck(HostDTO dto) {
		String name = sqlSession.selectOne("host.loginCheck", dto);
		return (name == null) ? false : true;
	}
	
	@Override
	public HostDTO loginOkNick(HostDTO dto) {
		dto = sqlSession.selectOne("host.loginOkNick", dto);
		return dto;
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
	public int emailCheck(String h_email) {
		int cnt = sqlSession.selectOne("host.emailCheck",h_email);
		return cnt;
	}
	
	@Override
	public int updatePw(HostDTO dto) throws Exception {
		return sqlSession.update("host.updatePw", dto);
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
	public List<RoomsDTO> rooms_Confirm(int start, int end, String h_userid, String select) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("h_userid", h_userid);
		map.put("select", select);
		return sqlSession.selectList("host.rooms_Confirm", map);
	}
	
	@Override
	public List<RoomsDTO> rooms_List(int start, int end, String h_userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("h_userid", h_userid);
		return sqlSession.selectList("host.rooms_List", map);
	}
	
	@Override
	public boolean delete_check(RoomsDTO dto) {
		List<Boolean> room_name = sqlSession.selectList("host.delete_check",dto);
		System.out.println(room_name.toString());
		return (room_name.toString()=="[]") ? false : true;
	}
	
	@Override
	public int getRoomCount(String h_userid , String select) {
		Map<String, Object> map = new HashMap<>();
		map.put("select", select);
		map.put("h_userid", h_userid);
		return sqlSession.selectOne("host.getRoomCount", map);
	}
	
	@Override
	public int getConfirmRoom(String h_userid) {
		return sqlSession.selectOne("host.getConfirmRoom", h_userid);
	}
	
	@Override
	public List<RoomsDTO> rooms_money(String h_userid, Date check_in) {
		Map<String, Object> map = new HashMap<>();
		map.put("check_in", check_in);
		map.put("h_userid", h_userid);
		return sqlSession.selectList("host.rooms_money",map);
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

	@Override
	public List<RoomsDTO> rooms_Confirm(String h_userid) {
		return sqlSession.selectList("host.roomsConfirm",h_userid);
	}

	@Override
	public String findByPasswd(String h_userid) {
		return sqlSession.selectOne("host.findByPasswd", h_userid);
	}


}
