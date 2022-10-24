package com.example.stayhere.model.rooms.dto;

import java.util.Date;

public class RoomsDTO {
	private int room_idx;
	private String h_userid;
	private String room_name;
	private int room_price;
	private String contents;
	private String city;
	private String country;
	private String address1;
	private String address2;
	private String zipcode;
	private Date check_in;
	private Date check_out;
	private int beds;
	private int baths;
	private String room_type;
	private String lat;
	private String lng;	
	private int max_people;
	private String photo1;//room_photo 테이블
	private String photo2;//room_photo 테이블
	private String photo3;//room_photo 테이블
	private String photo4;//room_photo 테이블
	private int review_star;//리뷰별점평균(review테이블)
	private int review_count;//리뷰갯수(review테이블)
	
    public int getMax_people() {
		return max_people;
	}

	public void setMax_people(int max_people) {
		this.max_people = max_people;
	}

	public int getReview_star() {
		return review_star;
	}

	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	public RoomsDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getPhoto1() {
		return photo1;
	}

	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}

	public String getPhoto2() {
		return photo2;
	}

	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}

	public String getPhoto3() {
		return photo3;
	}

	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}

	public String getPhoto4() {
		return photo4;
	}

	public void setPhoto4(String photo4) {
		this.photo4 = photo4;
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

	@Override
	public String toString() {
		return "RoomsDTO [room_idx=" + room_idx + ", h_userid=" + h_userid + ", room_name=" + room_name
				+ ", room_price=" + room_price + ", contents=" + contents + ", city=" + city + ", country=" + country
				+ ", address1=" + address1 + ", address2=" + address2 + ", zipcode=" + zipcode + ", check_in="
				+ check_in + ", check_out=" + check_out + ", beds=" + beds + ", baths=" + baths + ", room_type="
				+ room_type + ", lat=" + lat + ", lng=" + lng + ", photo1=" + photo1 + ", photo2=" + photo2
				+ ", photo3=" + photo3 + ", photo4=" + photo4 + "]";
	}
	
	
    
}
