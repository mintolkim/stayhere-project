package com.example.stayhere.model.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.dto.MemberDTO;


@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	SqlSession sqlSession;

	@Override
	public List<MemberDTO> memberList() {
		return sqlSession.selectList("member.memberlist");
	}

}
