package com.example.stayhere.model.reservations.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationsDTO {
    private int res_idx;//예약 번호
    private String userid;//회원 아이디(guest테이블)
    private int room_idx;//숙소 번호(rooms테이블)
    private String h_userid;//호스트 아이디(host테이블)
    private String checkin_date;//체크인 날짜
    private String checkout_date;//체크아웃 날짜
    private String res_state;//예약 상태(default '예약 승인 요청')
    private Date res_date;//예약 확정날짜(default sysdate)
    private int total_price;//예약 총 금액(숙소가격+(추가인원*1인당 추가금액))
    private int res_person;//예약인원(2인 기준이며 2인 초과시 1인당 금액 추가/숙소별 상이)
    private int night;//숙박일수
    private String phone;//회원 이메일(guest테이블)
    private String name;//회원이름(guest테이블)
    //rooms테이블
    private String room_name;//숙소 이름
    private int room_price;//숙소 가격
    private String contenst;//숙소 소개글
    private String city;//도시
    private String country;//마을
    private String address1;//기본주소
    private String address2;//상세주소
	private String zipcode;//우편번호
	private int beds;//침대수
	private int baths;//화장실수
	private String room_type;//숙소타입
	private String lat;//위도
	private String lng;//경도
	private int max_people;//최대인원
	private int add_people;//추가인원 
	//room_photo테이블
	private String photo1;//room_photo 테이블
	private String photo2;//room_photo 테이블
	private String photo3;//room_photo 테이블
	private String photo4;//room_photo 테이블
	//admin-매출집계
	private String month;
	private int monthlymoney;
	private int yearmoney;
}
