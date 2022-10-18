package com.example.stayhere.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.dao.MemberDAO;
import com.example.stayhere.model.dto.MemberDTO;
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;

	@Override
	public List<MemberDTO> memberList() {
		return memberDao.memberList();
	}

}
