package com.example.stayhere.model.qna.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaDTO {
	private int q_idx;
	private String userid;
	private String subject;
	private String contents;
	private String category;
	private int view_count;
	private Date write_date;
	private String show;
	private String passwd;
	private int comment_count;//qna_comment 테이블
	private String profile_img;//게스트테이블
	private int scrap;//qna_scrap 테이블
	private int likey;//qna_likey 테이블
	private int choose ;//qna_comment 테이블
	private String[] files;//첨부파일 이름 배열
	private String scraper;//스크랩한 사람
}
