package com.example.stayhere.model.rooms.dto;

import java.util.Date;

public class RoomsDTO {
    private int room_idx;//숙소 번호
    private String h_userid;//호스트 아이디  
    private String room_name;//숙소 이름
    private int room_price;//숙소 가격
    private String contents;//숙소 설명
    private String city;//도시
    private String country;//마을명
    private String address1;//기본주소
    private String address2;//상세주소
    private String zipcode;//우편번호
    private Date check_in;//체크인 날짜
    private Date check_out;//체크아웃 날짜
    private int beds;//침대 수
    private int baths;//화장실 수
    private String room_type;//방 타입
    private String lat;//위도
    private String lng;//경도
    private String max_people;//최대인원
    //별점(리뷰테이블 조인)
    //후기 개수(리뷰테이블 조인)
    //호스트 이메일(호스트 테이블 조인)

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
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public int getRoom_price() {
		return room_price;
	}
	public void setRoom_price(int room_price) {
		this.room_price = room_price;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public Date getCheck_in() {
		return check_in;
	}
	public void setCheck_in(Date check_in) {
		this.check_in = check_in;
	}
	public Date getCheck_out() {
		return check_out;
	}
	public void setCheck_out(Date check_out) {
		this.check_out = check_out;
	}
	public int getBeds() {
		return beds;
	}
	public void setBeds(int beds) {
		this.beds = beds;
	}
	public int getBaths() {
		return baths;
	}
	public void setBaths(int baths) {
		this.baths = baths;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getMax_people() {
		return max_people;
	}
	public void setMax_people(String max_people) {
		this.max_people = max_people;
	}
	@Override
	public String toString() {
		return "RoomsDTO [room_idx=" + room_idx + ", h_userid=" + h_userid + ", room_name=" + room_name
				+ ", room_price=" + room_price + ", contents=" + contents + ", city=" + city + ", country=" + country
				+ ", address1=" + address1 + ", address2=" + address2 + ", zipcode=" + zipcode + ", check_in="
				+ check_in + ", check_out=" + check_out + ", beds=" + beds + ", baths=" + baths + ", room_type="
				+ room_type + ", lat=" + lat + ", lng=" + lng + ", max_people=" + max_people + "]";
	}
	public RoomsDTO() {
	}
   
}
