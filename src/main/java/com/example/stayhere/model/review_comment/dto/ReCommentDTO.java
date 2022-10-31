package com.example.stayhere.model.review_comment.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReCommentDTO {
	private int comment_num; //댓글번호
	private int review_idx; //리뷰고유번호
	private String contents; //내용
	private String writer; //작성자이름
	//private String h_userid;//userid 또는 h_userid 로 작업추가확인(10.24.이후 작업예정)
	private Date write_date; //작성일자
	private String secret_reply; //비밀댓글 여부
		
}
