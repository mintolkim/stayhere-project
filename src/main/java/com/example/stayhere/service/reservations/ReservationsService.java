package com.example.stayhere.service.reservations;

import java.util.List;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;

public interface ReservationsService {
	
	public List<ReservationsDTO> guestResList(String userid) throws Exception;//게스트의 예약내역 목록
	public List<ReservationsDTO> hostResList(String h_userid) throws Exception;//호스트의 예약내역 목록
	public void insert(ReservationsDTO dto) throws Exception;//예약테이블에 정보 저장
	public int countRes(String userid, int res_idx) throws Exception;//예약 개수
	public ReservationsDTO getReserveDetail(int res_idx);//예약정보
	public void reserveCancel(int res_idx) throws Exception;//예약 취소
	public void reserveApprove(int res_idx);//예약 승인
	public void reserveCheckin(int res_idx);//입실 완료 
	public void reserveCheckout(int res_idx);//퇴실 완료
	public List<ReservationsDTO> resTotalMoney();//월별 매출집계
	public List<ReservationsDTO> resCateTotalMoney();//카테고리별 매출집계

}