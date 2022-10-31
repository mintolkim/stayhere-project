package com.example.stayhere.model.review.dto;

import java.util.Arrays;
import java.util.Date;

public class ReviewDTO {
	private int review_idx; //리뷰번호
	private String userid; //게스트아이디
	private String r_title; //리뷰 제목
	private int review_star; //리뷰별점
	private String review_content; //리뷰내용
	private Date write_date; //작성일
	int view_count;	//조회수
	private String show; //화면 표시 여부(Y/N)
	private String[] files; //첨부파일 배열
	//getter, setter, toString
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public int getReview_star() {
		return review_star;
	}
	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getShow() {
		return show;
	}
	public void setShow(String show) {
		this.show = show;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	@Override
	public String toString() {
		return "ReviewDTO [review_idx=" + review_idx + ", userid=" + userid + ", r_title=" + r_title + ", review_star="
				+ review_star + ", review_content=" + review_content + ", write_date=" + write_date + ", view_count="
				+ view_count + ", show=" + show + ", files=" + Arrays.toString(files) + "]";
	}
	
}
