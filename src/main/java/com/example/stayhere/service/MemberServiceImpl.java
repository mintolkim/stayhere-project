package com.example.stayhere.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.MemberDAO;
import com.example.stayhere.model.MemberDTO;
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;

	@Override
	public List<MemberDTO> list() {
		return memberDao.list();
	}

}
