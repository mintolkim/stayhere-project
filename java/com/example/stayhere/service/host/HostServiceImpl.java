package com.example.stayhere.service.host;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.host.dao.HostDAO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

@Service
public class HostServiceImpl implements HostService {

	@Inject
	HostDAO hostDao;
	 
	@Override
	public boolean loginCheck(HostDTO dto, HttpSession session) {
		boolean result =hostDao.loginCheck(dto);
		if(result) {//로그인 성공
			//세션변수에 값 저장
			HostDTO dto2=viewHost(dto.getH_userid());
			//setAttribute("변수명",값)
			session.setAttribute("h_userid", dto.getH_userid());
			session.setAttribute("h_name", dto2.getH_name());
			System.out.println(session.getAttribute("h_userid"));
			System.out.println(session.getAttribute("h_name"));
		}
		return result;
	}

	@Override
	public HostDTO viewHost(String h_userid) {
		return hostDao.viewHost(h_userid);
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public void insert(HostDTO host) {
		hostDao.insert(host);
	}

	@Override
	public int idCheck(String h_userid) {
		int cnt = hostDao.idCheck(h_userid);
		return cnt;
	}

	@Override
	public void update(HostDTO host) {
		hostDao.update(host);

	}

	@Override
	public void delete(String h_userid,HttpSession session) {
		session.invalidate();
		hostDao.delete(h_userid);

	}
	
	@Override
	public List<RoomsDTO> rooms_Confirm(String h_userid) {
		return hostDao.rooms_Confirm(h_userid);
	}
	
	@Override
	public boolean delete_check(RoomsDTO dto) {
		boolean result =hostDao.delete_check(dto);
		return result;
	}
}
