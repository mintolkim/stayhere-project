package com.example.stayhere.model.review.dao;

import java.util.Date;
import java.util.List;

import com.example.stayhere.model.review.dto.ReviewDTO;

public interface ReviewDAO {
	public void create(ReviewDTO dto) throws Exception; //리뷰작성
	public void update(ReviewDTO dto) throws Exception; //수정
	public void delete(int review_idx) throws Exception; //삭제
	public void increaseViewcnt(int review_idx) throws Exception; //조회수 증가 처리
	public int countArticle() throws Exception;//레코드 갯수 계산
	public ReviewDTO read(int review_idx) throws Exception; //레코드 조회
	public List<ReviewDTO> reviewsCategory(int review_idx, Date write_date, int view_count, int review_star);//조회(최신순, 조회수, 별점순)
	public List<ReviewDTO> listAll(int start, int end) throws Exception; //전체목록
	public List<ReviewDTO> reviewsByUser(int userid);//유저별 리뷰 목록
	public List<ReviewDTO> reviewsByRoom(int room_idx);//숙소 별 리뷰 목록
	public int countByRoom(int room_idx);//숙소 별 후기 개수
	public double starByRoom(int room_idx);//숙소 별 별점 평균
	//첨부파일 작업
	public void deleteFile(String fullName); //첨부파일 삭제 
	public List<String> getAttach(int review_idx); //첨부파일 정보 
	public void addAttach(String fullName); //첨부파일저장
	public void updateAttach(String fullName, int review_idx); //첨부파일 수정
	//public List<ReviewDTO> reviewsSearch(int room_idx, String r_title, String review_content);//리뷰검색기능(가능하면)
}
