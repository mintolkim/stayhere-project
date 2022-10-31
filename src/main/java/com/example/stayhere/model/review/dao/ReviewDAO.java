package com.example.stayhere.model.review.dao;

import java.util.List;

import com.example.stayhere.model.review.dto.ReviewDTO;

public interface ReviewDAO {
	/* 첨부파일 작업할 때 다시 확인.*/
	public void deleteFile(String fullName); //첨부파일 삭제 
	public List<String> getAttach(int review_idx); //첨부파일 정보 
	public void addAttach(String fullName); //첨부파일저장
	public void updateAttach(String fullName, int review_idx); //첨부파일 수정	
	public void create(ReviewDTO dto) throws Exception; //글쓰기
	public void update(ReviewDTO dto) throws Exception; //글수정
	public void delete(int review_idx) throws Exception; //글삭제
	public List<ReviewDTO> listAll() throws Exception; //글목록
	public void increaseViewcnt(int review_idx) throws Exception; //조회수 증가 처리
	public int countArticle() throws Exception;//레코드 갯수 계산
	public ReviewDTO read(int review_idx) throws Exception; //레코드 조회
	public List<ReviewDTO> reviewsByRoom(int room_idx);//숙소 별 리뷰 목록
	public int countByRoom(int room_idx);//숙소 별 후기 개수
	public double starByRoom(int room_idx);//숙소 별 별점 평균
}
