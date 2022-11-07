package com.example.stayhere.model.review.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
	private int review_idx;//리뷰번호
	private int room_idx;//룸번호(review 테이블, room 테이블)
	private String room_name;//룸이름(room 테이블)
	private String userid;//게스트아이디(review 테이블, guest테이블)
	private String name;//게스트이름(guest테이블)
	private String r_title;//리뷰 제목
	private int review_star;//리뷰별점
	private String review_content;//리뷰내용
	private Date write_date;//작성일
	private int view_count;//조회수
	private String show;//화면 표시 여부(Y/N)
	private String[] files;//첨부파일 배열
	private String profile_img;//리뷰프로필 이미지
	private String reviewAcc;//리뷰신고여부
}