package com.example.stayhere.model.reservations.dao;

import java.util.List;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;

public interface ReservationsDAO {
	
	public List<ReservationsDTO> listRes(String userid);//게스트 & 호스트 별 예약 목록
	public void insert(ReservationsDTO dto);//예약테이블에 정보 저장
	public void update(int res_idx);//예약 수정
	public void delete(int res_idx);//예약 취소
	public int sumMoney(int room_price, int res_person);//총 금액
	public int countRes(String userid, int res_idx);//예약 개수
	public void modifyRes(ReservationsDTO dto);//날짜 및 인원 수정

}
