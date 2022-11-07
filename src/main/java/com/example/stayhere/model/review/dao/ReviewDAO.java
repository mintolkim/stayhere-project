package com.example.stayhere.model.review.dao;

import java.util.Date;
import java.util.List;


import javax.servlet.http.HttpSession;

import com.example.stayhere.model.qna_comment.dto.QnaCommentDTO;
import com.example.stayhere.model.review.dto.ReviewAccuseDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.review_comment.dto.ReCommentDTO;

public interface ReviewDAO {
	public void create(ReviewDTO dto) throws Exception; //리뷰작성
	public void update(ReviewDTO dto) throws Exception; //수정
	public void delete(int review_idx) throws Exception; //삭제
	public void increaseViewcnt(int review_idx) throws Exception; //조회수 증가 처리
	public int countArticle() throws Exception;//레코드 갯수 계산
	public ReviewDTO read(int review_idx) throws Exception; //레코드 조회
	public List<ReviewDTO> reviewsCategory(int review_idx, Date write_date, int view_count, int review_star);//조회(최신순, 조회수, 별점순)
	public List<ReviewDTO> listAll(int start, int end) throws Exception; //전체목록
	public ReviewDTO detail(int review_idx);//리뷰상세보기
	public List<ReviewDTO> reviewsByUser(int userid);//유저별 리뷰 목록록
	public List<ReviewDTO> reviewsByRoom(int room_idx);//숙소 별 리뷰 목록
	public int countByRoom(int room_idx);//숙소 별 후기 개수
	public double starByRoom(int room_idx);//숙소 별 별점 평균점수
	//첨부파일 작업
	public void deleteFile(String fileName); //첨부파일 삭제 
	public List<String> getAttach(int review_idx); //첨부파일 정보 
	public void addAttach(String fullname); //첨부파일저장
	public void updateAttach(String fullname, int review_idx); //첨부파일 수정
	public int checkAttach(String fullname, int review_idx);//첨부파일 확인
	//리뷰상세(좋아요, 신고)
	public void addlikey(int review_idx, String userid);//좋아요추가
	public int likeycheck(int review_idx, String userid);//좋아요체크
	public void dellikey(int review_idx, String userid);//좋아요취소
	//public int accuseCheck(String user, int review_idx);//리뷰신고체크
	//public void accuseCancel(int review_idx);//리뷰신고취소
	//리뷰댓글관련
	public List<ReCommentDTO> comment(int review_idx);//댓글 리스트
	public void addComment(int review_idx, String writer, String contents);//댓글달기
	public void delComment(int review_idx, int comment_idx);//댓글삭제
	//어드민 화면단에서 사용
	//public List<ReviewAccuseDTO> acclist(int start, int end) throws Exception; //전체신고리뷰목록
	public void checkAcc(String review_idx);//신고체크
	public void cancelAcc(String review_idx);//신고체크취소
	public ReviewAccuseDTO accDetail(int acc_idx);//신고상세보기(신고의견)
	public int countByAcc(int review_idx);//신고 갯수
	public List<ReviewDTO> getreview(String userid);//게스트별 리뷰가져오기
	public List<ReviewAccuseDTO> getaccuse(String userid);//게스트 신고 가져오기
	public List<ReviewDTO> roomreview(int room_idx);//룸리뷰 불러오기
}

