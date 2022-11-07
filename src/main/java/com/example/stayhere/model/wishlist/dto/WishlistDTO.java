package com.example.stayhere.model.wishlist.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishlistDTO {
    private int wish_num; //위시리스트 번호
    private int room_idx; //숙소 번호(rooms테이블)
    private String userid; //게스트 아이디(guest 테이블)
    private Date wish_date; 
    //rooms테이블
    private String room_name;//숙소 이름
    private int room_price;//숙소 가격
    private String contents;//숙소 소개글
    private String address1;//기본주소
    private String address2;//상세주소
	private String zipcode;//우편번호
	private String lat;//위도
	private String lng;//경도
	private Date check_in;
	private Date check_out;
	//room_photo테이블
	private String photo1;//room_photo 테이블
	private String photo2;//room_photo 테이블
	private String photo3;//room_photo 테이블
	private String photo4;//room_photo 테이블
}
