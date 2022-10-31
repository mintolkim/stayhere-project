package com.example.stayhere.model.qna_comment.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaCommentDTO {
	private int comment_idx;
	private int q_idx;
	private String writer;
	private String contents;
	private int ref;
	private int re_step;
	private int re_level;
	private int likey;//qnacomment_likey 테이블
	private Date write_date;
	private String choose;
	private String profile_img;
	private String h_profile_img;
	private String userid;//qna글 작성자
}
