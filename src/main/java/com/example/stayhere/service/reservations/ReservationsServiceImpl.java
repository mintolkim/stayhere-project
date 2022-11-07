package com.example.stayhere.service.reservations;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.stayhere.controller.MainController;
import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.reservations.dao.ReservationsDAO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.reservations.dto.ReservedDTO;
import com.example.stayhere.model.rooms.dao.RoomsDAO;
import com.example.stayhere.util.DateParse;

@Service
public class ReservationsServiceImpl implements ReservationsService {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(MainController.class);
	
	@Inject
	ReservationsDAO reservationsDao;
	
	@Inject
	RoomsDAO roomsDao;
	
	
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
		logger.info("예약테이블에 들어갈 값"+dto);
		//예약 테이블에 데이터 저장
		reservationsDao.insert(dto);
		//숙박 날짜 reserved테이블에 저장
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

	@Override
	public int resdateCheck(String room_idx, String checkin_date, String checkout_date) {	
		return reservationsDao.resdateCheck(room_idx, checkin_date, checkout_date);
	}

	@Override
	public int cntRequest(String userid) {
		return reservationsDao.cntRequest(userid);
	}

	@Override
	public int cntApprove(String userid) {
		return reservationsDao.cntApprove(userid);
	}

	@Override
	public int cntCancel(String userid) {
		return reservationsDao.cntCancel(userid);
	}
	
	@Override
	public int cntUse(String userid) {
		return reservationsDao.cntUse(userid);
	}

	@Override
	public int cntCheckout(String userid) {
		return reservationsDao.cntCheckout(userid);
	}

	@Override
	public int h_cntRequest(String h_userid) {
		return reservationsDao.h_cntRequest(h_userid);
	}

	@Override
	public int h_cntApprove(String h_userid) {
		return reservationsDao.h_cntApprove(h_userid);
	}

	@Override
	public int h_cntCancel(String h_userid) {
		return reservationsDao.h_cntCancel(h_userid);
	}

	@Override
	public int h_cntCheckout(String h_userid) {
		return reservationsDao.h_cntCheckout(h_userid);
	}

	@Override
	public int h_cntUse(String h_userid) {
		return reservationsDao.h_cntUse(h_userid);
	}

	@Override
	public void sendEmail(GuestDTO g_dto, String div, ReservationsDTO dto) {
		//룸아이디, 체크인,체크아웃 날짜로 해당 예약정보를 가져온다.(예약 아이디는 아직 생성되지 않아서 매개변수로 사용하지 못함)
		dto=reservationsDao.mailReserve(dto.getRoom_idx(), dto.getCheckin_date(), dto.getCheckout_date());
		
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com"; //구글 이용시 smtp.gmail.com
		String hostSMTPid = "project-test-user@naver.com";
		String hostSMTPpwd = "project!test";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "project-test-user@naver.com";
		String fromName = "stayhere 관리자";
		String subject = "";
		String msg = "";
		
		//예약dto의 값을 가져와 메일로 전송한다.
		if(div.equals("reserveMail")) {
			System.out.println("게스트에게 메일 발송");
			subject = "[STAYHERE] "+g_dto.getUserid()+"님의 예약내역입니다.";
			msg += "<div align='center' style='border:1px solid black; text-align: center; padding: 30px; background: #e6e6e6; font-family:verdana'>";
			msg += "<h3>💛"+ dto.getUserid() + "님의 예약요청이 완료되었습니다.💛</h3>";
			msg += "<table border='1' style=\'width: 50%; margin: auto; border-collapse: collapse; padding: 5px;\'>";
			msg += "<tr><td>예약번호</td><td>"+dto.getRes_idx()+"</td></tr>";
			msg += "<tr><td>예약스테이</td><td>"+dto.getRoom_name()+"</td></tr>";
			msg += "<tr><td>체크인</td><td>"+dto.getCheckin_date()+" 오후 3:00</td></tr>";
			msg += "<tr><td>체크아웃</td><td>"+dto.getCheckout_date()+" 오전 11:00</td></tr>";
			msg += "<tr><td>예약자명</td><td>"+dto.getName()+"</td></tr>";
			msg += "<tr><td>연락처</td><td>"+dto.getPhone()+"</td></tr>";
			msg += "<tr><td>예약상태</td><td>"+dto.getRes_state()+"</td></tr>";
			msg += "<tr><td>예약인원</td><td>"+dto.getRes_person()+"</td></tr>";
			msg += "<tr><td>결제금액</td><td>"+dto.getTotal_price()+"</td></tr>";
			msg += "</table></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = g_dto.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSLOnConnect(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //구글 이용시 465
			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setStartTLSEnabled(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	@Override
	public void h_sendEmail(HostDTO h_dto, String div, ReservationsDTO dto) {
		//룸아이디, 체크인,체크아웃 날짜로 해당 예약정보를 가져온다.(예약 아이디는 아직 생성되지 않아서 매개변수로 사용하지 못함)
				dto=reservationsDao.mailReserve(dto.getRoom_idx(), dto.getCheckin_date(), dto.getCheckout_date());
				
				// Mail Server 설정
				String charSet = "utf-8";
				String hostSMTP = "smtp.naver.com"; //구글 이용시 smtp.gmail.com
				String hostSMTPid = "project-test-user@naver.com";
				String hostSMTPpwd = "project!test";

				// 보내는 사람 EMail, 제목, 내용
				String fromEmail = "project-test-user@naver.com";
				String fromName = "stayhere 관리자";
				String subject = "";
				String msg = "";
				
				//예약dto의 값을 가져와 메일로 전송한다.
				if(div.equals("h_reserveMail")) {
					System.out.println("호스트에게 메일 발송");
					subject = "[STAYHERE] "+h_dto.getH_userid()+"님이 호스팅중인 숙소의 예약내역입니다.";
					msg += "<div align='center' style='border:1px solid black; text-align: center; padding: 30px; background: #e6e6e6; font-family:verdana'>";
					msg += "<h3>💛"+ h_dto.getH_userid() + "님이 호스팅중인 숙소에 예약요청이 있습니다.💛</h3>";
					msg += "<table border='1' style=\'width: 50%; margin: auto; border-collapse: collapse; padding: 5px;\'>";
					msg += "<tr><td>예약번호</td><td>"+dto.getRes_idx()+"</td></tr>";
					msg += "<tr><td>예약스테이</td><td>"+dto.getRoom_name()+"</td></tr>";
					msg += "<tr><td>체크인</td><td>"+dto.getCheckin_date()+" 오후 3:00</td></tr>";
					msg += "<tr><td>체크아웃</td><td>"+dto.getCheckout_date()+" 오전 11:00</td></tr>";
					msg += "<tr><td>예약자명</td><td>"+dto.getName()+"</td></tr>";
					msg += "<tr><td>연락처</td><td>"+dto.getPhone()+"</td></tr>";
					msg += "<tr><td>예약상태</td><td>"+dto.getRes_state()+"</td></tr>";
					msg += "<tr><td>예약인원</td><td>"+dto.getRes_person()+"</td></tr>";
					msg += "<tr><td>결제금액</td><td>"+dto.getTotal_price()+"</td></tr>";
					msg += "</table></div>";
				}

				// 받는 사람 E-Mail 주소
				String mail = h_dto.getH_email();
				try {
					HtmlEmail email = new HtmlEmail();
					email.setDebug(true);
					email.setCharset(charSet);
					email.setSSLOnConnect(true);
					email.setHostName(hostSMTP);
					email.setSmtpPort(465); //구글 이용시 465
					email.setAuthentication(hostSMTPid, hostSMTPpwd);
					email.setStartTLSEnabled(true);
					email.addTo(mail, charSet);
					email.setFrom(fromEmail, fromName, charSet);
					email.setSubject(subject);
					email.setHtmlMsg(msg);
					email.send();
				} catch (Exception e) {
					System.out.println("메일발송 실패 : " + e);
				}
		
	}


}
