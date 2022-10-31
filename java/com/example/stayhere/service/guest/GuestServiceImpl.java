package com.example.stayhere.service.guest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.stayhere.model.guest.dao.GuestDAO;
import com.example.stayhere.model.guest.dto.GuestDTO;

@Service
public class GuestServiceImpl implements GuestService {

	@Inject
	GuestDAO guestDao;
	
	@Override
	public List<GuestDTO> list_guest() {
		return guestDao.list_guest();
	}

	@Override
	public void insert_Guest(GuestDTO dto){
		guestDao.insert_Guest(dto);
		/*
		 * int ok = 1; int result = guestDao.insert_Guest(dto); if(result ==1) ok=0;
		 * return ok;
		 */
	}

	@Override
	public void update_Guest(GuestDTO dto) {
		guestDao.update_Guest(dto);

	}

	@Override
	public void delete_Guest(String userid) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean loginCheck(GuestDTO dto, HttpSession session) {
		boolean result = guestDao.loginCheck(dto);
		if(result) { //로그인 성공시 세션에 저장
			GuestDTO dto2 = view_Guest(dto.getUserid());
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", dto2.getName());
			System.out.println(session.getAttribute("userid"));
			System.out.println(session.getAttribute("name"));
		}
		return result;
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
		
	}

	@Override
	public GuestDTO view_Guest(String userid) {
		return guestDao.view_Guest(userid);
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		return guestDao.checkPw(userid, passwd);
	}

	@Override
	public int idCheck(String userid) throws Exception {
		return guestDao.idCheck(userid);
	}

	@Override
	public int loginLookup(GuestDTO dto) {
		return guestDao.loginLookup(dto);
	}


}
