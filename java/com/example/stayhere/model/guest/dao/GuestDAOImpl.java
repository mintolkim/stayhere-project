package com.example.stayhere.model.guest.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.guest.dto.GuestDTO;

@Repository 
public class GuestDAOImpl implements GuestDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<GuestDTO> list_guest() {
		return sqlSession.selectList("guest.list_guest");
	}

	@Override
	public void insert_Guest(GuestDTO dto) {
		sqlSession.insert("guest.insert_guest", dto);
//		return result;
	}

	@Override
	public void update_Guest(GuestDTO dto) {
		sqlSession.update("guest.update_guest", dto);

	}

	@Override
	public void delete_Guest(String userid) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean loginCheck(GuestDTO dto) {
		String name = sqlSession.selectOne("guest.loginCheck",dto);
		return (name == null) ? false : true ;
	}

	@Override
	public GuestDTO view_Guest(String userid) {
		return sqlSession.selectOne("guest.view_guest", userid);
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		boolean result = false;
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		int count = sqlSession.selectOne("guest.checkPw", map);
		if(count == 1) result = true;
		return result;
	}

	@Override
	public int idCheck(String userid) throws Exception {
		return sqlSession.selectOne("guest.idCheck", userid);
	}

	@Override
	public Integer loginLookup(GuestDTO dto) {
		return sqlSession.selectOne("guest.login_lookup", dto);
	}



}
