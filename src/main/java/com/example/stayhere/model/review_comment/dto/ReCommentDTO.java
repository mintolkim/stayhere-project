package com.example.stayhere.model.review_comment.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReCommentDTO {
	private int comment_idx; //댓글번호
	private int review_idx; //리뷰고유번호
	private String contents; //내용
	private String userid; //리뷰작성자 아이디(리뷰.게스트)
	private String writer; //댓글작성자이름(댓글.게스트/호스트)
	private String profile_img;
	private String h_profile_img;
	private Date write_date; //작성일자
	private int ref;//댓글 그룹
	private int re_step;//댓글그룹의 순서
	private int re_level;//대댓글단계
}
