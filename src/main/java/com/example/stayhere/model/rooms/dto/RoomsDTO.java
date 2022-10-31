package com.example.stayhere.model.rooms.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date check_in;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date check_out;
	private int beds;
	private int baths;
	private String room_type;
	private String lat;
	private String lng;	
	private String admin_confirm;
	private int max_people;//최대인원
	private int add_people;//추가인원 
	private String photo1;//room_photo 테이블
	private String photo2;//room_photo 테이블
	private String photo3;//room_photo 테이블
	private String photo4;//room_photo 테이블
	//임의추가영역
	private double review_star;//리뷰별점평균(review테이블)
	private int review_count;//리뷰갯수(review테이블)
	private int res_count; //예약갯수

}
