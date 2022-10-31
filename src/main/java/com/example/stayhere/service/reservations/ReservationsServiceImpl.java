package com.example.stayhere.service.reservations;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.stayhere.controller.MainController;
import com.example.stayhere.model.reservations.dao.ReservationsDAO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.reservations.dto.ReservedDTO;
import com.example.stayhere.util.DateParse;

@Service
public class ReservationsServiceImpl implements ReservationsService {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(MainController.class);
	
	@Inject
	ReservationsDAO reservationsDao;
	
	
	@Override
	public List<ReservationsDTO> guestResList(String userid) throws Exception{
		return reservationsDao.guestResList(userid);
	}
	
	@Override
	public List<ReservationsDTO> hostResList(String h_userid) throws Exception {
		return reservationsDao.hostResList(h_userid);
	}

	@Transactional
	@Override
	public void insert(ReservationsDTO dto) throws Exception {
		logger.info(dto.toString());
		reservationsDao.insert(dto);
		//숙박 날짜를 reserved테이블에 저장하여 날짜 중복을 확인하려고 함..but 달력으로 표시하기 힘듬 ㅠ
		int night=dto.getNight();
		for(int i=0;i<night;i++) {
						reservationsDao.insertReserved(
								new ReservedDTO(dto.getRoom_idx(),
										DateParse.datePlus(dto.getCheckin_date(), i)));
		}	
	}

	@Override
	public int countRes(String userid, int res_idx) throws Exception{
		// TODO Auto-generated method stub
		return 0;
	}

	@Transactional
	@Override
	public void reserveCancel(int res_idx) throws Exception {
		//예약 상태 변경 '취소완료'
		reservationsDao.refuseStatus(res_idx);
		
		ReservationsDTO dto=reservationsDao.getReserveDetail(res_idx);
		dto.setCheckout_date(DateParse.datePlus(dto.getCheckout_date(), -1));
		//예약중복 날짜 삭제
		reservationsDao.reserveCancel(dto);
	}

	@Override
	public ReservationsDTO getReserveDetail(int res_idx) {
		return reservationsDao.getReserveDetail(res_idx);
	}

	@Override
	public void reserveApprove(int res_idx) {
		//예약 상태 변경  '예약완료'
		reservationsDao.approveStatus(res_idx);
	}

	@Override
	public void reserveCheckin(int res_idx) {
		//예약 상태 변경 '입실완료'
		reservationsDao.checkinStatus(res_idx);
	}

	@Transactional
	@Override
	public void reserveCheckout(int res_idx) {
		//예약 상태 변경 '입실완료'
		reservationsDao.checkoutStatus(res_idx);
		
		ReservationsDTO dto=reservationsDao.getReserveDetail(res_idx);
		dto.setCheckout_date(DateParse.datePlus(dto.getCheckout_date(), -1));
		//예약중복 날짜 삭제
		reservationsDao.reserveCancel(dto);
	}


}
