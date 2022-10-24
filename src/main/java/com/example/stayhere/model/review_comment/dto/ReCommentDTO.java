package com.example.stayhere.model.review_comment.dto;

import java.util.Date;

public class ReCommentDTO {
	private int comment_num; //댓글번호
	private int review_idx; //리뷰고유번호
	private String contents; //내용
	private String writer; //작성자이름
	//private String h_userid;//userid 또는 h_userid 로 작업추가확인(10.24.이후 작업예정)
	private Date write_date; //작성일자
	private String secret_reply; //비밀댓글 여부
	//getter, setter, toString
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public String getSecret_reply() {
		return secret_reply;
	}
	public void setSecret_reply(String secret_reply) {
		this.secret_reply = secret_reply;
	}
	@Override
	public String toString() {
		return "ReCommentDTO [comment_num=" + comment_num + ", review_idx=" + review_idx + ", contents=" + contents
				+ ", writer=" + writer + ", write_date=" + write_date + ", secret_reply=" + secret_reply + "]";
	}
		
}
