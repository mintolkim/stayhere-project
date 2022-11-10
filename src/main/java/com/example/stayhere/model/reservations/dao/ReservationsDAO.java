package com.example.stayhere.model.reservations.dao;

import java.util.List;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.reservations.dto.ReservedDTO;

public interface ReservationsDAO {
	
	public List<ReservationsDTO> guestResList(String userid);//게스트의 예약내역 목록
	public List<ReservationsDTO> hostResList(String h_userid);//호스트의 예약 내역 목록
	public void insert(ReservationsDTO dto);//예약테이블에 정보 저장
	public int countAllRes(String userid);//이용완료 제외한 예약 총 건수
	public void insertReserved(ReservedDTO r_dto) throws Exception;//예약 날짜 저장
	public ReservationsDTO getReserveDetail(int res_idx);//예약 정보 불러오기
	public void reserveCancel(ReservationsDTO dto);//중복날짜 삭제
	public void refuseStatus(int res_idx);//예약 취소
	public void approveStatus(int res_idx);//예약 승인
	public void checkinStatus(int res_idx);//입실 완료
	public void checkoutStatus(int res_idx);//퇴실 완료
	public List<ReservationsDTO> resTotalMoney();//월별매출집계
	public List<ReservationsDTO> resCateTotalMoney();//카테고리별 매출집계
	public List<ReservationsDTO> roomreservation(int room_idx);//룸예약정보
	public int getThismonth(String today);//이번달 매출
	public int getThisyear(String today);//이번년도 매출
	public int resdateCheck(String room_idx, String checkin_date, String checkout_date);//예약 중복날짜 확인
	public int cntRequest(String userid);//게스트의 예약요청 개수
	public int cntApprove(String userid);//게스트의 예약완료 개수
	public int cntCancel(String userid);//게스트의 취소완료 개수
	public int cntUse(String userid);//게스트의 이용중 개수
	public int cntCheckout(String userid);//게스트의 이용완료 개수
	public int h_cntRequest(String h_userid);//호스트의 예약승인 개수
	public int h_cntApprove(String h_userid);//호스트의 예약완료 개수
	public int h_cntCancel(String h_userid);//호스트의 취소완료 개수
	public int h_cntCheckout(String h_userid);//호스트의 입실완료 개수
	public int h_cntUse(String h_userid);//호스트의 이용완료 개수
	public ReservationsDTO mailReserve(int room_idx, String checkin_date, String checkout_date);//메일전송용 예약정보
	public void reviewCheck(int res_idx);//예약번호를 이용하여 예약테이블의 리뷰 유무 컬럼을 y로 변경

}