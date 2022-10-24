package com.example.stayhere.model.reservations.dto;

import java.util.Date;

public class ReservationsDTO {
    int res_idx;//예약 번호
    String userid;//회원 아이디(guest테이블)
    int room_idx;//숙소 번호(rooms테이블)
    String h_userid;//호스트 아이디(host테이블)
    Date checkin_date;//체크인 날짜
    Date checkout_date;//체크아웃 날짜
    String res_state;//예약 상태
    Date res_date;//예약 확정날짜
    int room_price;//숙소 가격(rooms테이블)
    int res_person;//예약인원(2인 기준이며 2인 초과시 인당 3만원씩 금액 추가) 
    int total_price;//예약 총 금액(숙소가격+(추가인원*30000))
	public int getRes_idx() {
		return res_idx;
	}
	public void setRes_idx(int res_idx) {
		this.res_idx = res_idx;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public String getH_userid() {
		return h_userid;
	}
	public void setH_userid(String h_userid) {
		this.h_userid = h_userid;
	}
	public Date getCheckin_date() {
		return checkin_date;
	}
	public void setCheckin_date(Date checkin_date) {
		this.checkin_date = checkin_date;
	}
	public Date getCheckout_date() {
		return checkout_date;
	}
	public void setCheckout_date(Date checkout_date) {
		this.checkout_date = checkout_date;
	}
	public String getRes_state() {
		return res_state;
	}
	public void setRes_state(String res_state) {
		this.res_state = res_state;
	}
	public Date getRes_date() {
		return res_date;
	}
	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}
	public int getRoom_price() {
		return room_price;
	}
	public void setRoom_price(int room_price) {
		this.room_price = room_price;
	}
	public int getRes_person() {
		return res_person;
	}
	public void setRes_person(int res_person) {
		this.res_person = res_person;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	@Override
	public String toString() {
		return "ReservationsDTO [res_idx=" + res_idx + ", userid=" + userid + ", room_idx=" + room_idx + ", h_userid="
				+ h_userid + ", checkin_date=" + checkin_date + ", checkout_date=" + checkout_date + ", res_state="
				+ res_state + ", res_date=" + res_date + ", room_price=" + room_price + ", res_person=" + res_person
				+ ", total_price=" + total_price + "]";
	}
	public ReservationsDTO() {
	}
    
}
