package com.example.stayhere.model.rooms.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomsDTO {
	private int room_idx;  //룸번호
	private String h_userid; //호스트 아이디
	private String room_name;  // 룸이름
	private int room_price;  //방가격
	private String contents; //방정보
	private String city; // 도시
	private String country;  // 마을
	private String address1; // 주소
	private String address2; // 상세주소
	private String zipcode; //우편번호
	private Date check_in; // 체크인
	private Date check_out;  //체크아웃
	private int beds;  //침대수
	private int baths;  //화장실 수
	private String room_type; //방타입
	private String lat;  //위도
	private String lng;  //경도
	//임의 추가
	private int review_cnt; //리뷰 갯수
	private double review_avg; //리뷰평점
	private String photo1;
	private String photo2;
	private String photo3;
	private String photo4;
	
}
