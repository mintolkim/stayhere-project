package com.example.stayhere.model.review.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.review.dto.ReviewAccuseDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.review_comment.dto.ReCommentDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public void create(ReviewDTO dto) throws Exception {
		sqlSession.insert("review.insert", dto);

	}

	@Override
	public void update(ReviewDTO dto) throws Exception {
		sqlSession.update("review.update",dto);

	}

	@Override
	public void delete(int review_idx) throws Exception {
		sqlSession.delete("review.delete", review_idx);

	}

	//리뷰게시물 목록 리턴
	@Override
	public List<ReviewDTO> listAll(int start, int end) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("review.listAll", map);
	}

	@Override
	public void increaseViewcnt(int review_idx) throws Exception {
		sqlSession.update("review.increaseViewcnt",review_idx);

	}

	@Override
	public int countArticle() throws Exception {
		return sqlSession.selectOne("review.countArticle");
	}
	
	@Override
	public List<ReviewDTO> reviewsByRoom(int room_idx) {
		return sqlSession.selectList("review.reviewsByRoom", room_idx);
	}

	@Override
	public int countByRoom(int room_idx) {
		return sqlSession.selectOne("review.countByRoom", room_idx);
	}

	@Override
	public double starByRoom(int room_idx) {
		return sqlSession.selectOne("review.starByRoom" ,room_idx);
	}

	@Override
	public void deleteFile(String fileName) {
		sqlSession.delete("review.deleteFile",fileName);

	}

	@Override
	public List<String> getAttach(int review_idx) {
		return sqlSession.selectList("review.getAttach",review_idx);
	}

	@Override
	public void addAttach(String fullName) {
		sqlSession.insert("review.addAttach", fullName);

	}

	@Override
	public void updateAttach(String fullName, int review_idx) {
		Map<String, Object> map = new HashMap<>();
		map.put("fullName", fullName);
		map.put("review_idx", review_idx);
		sqlSession.insert("review.updateAttach",map);
	}

	@Override
	public ReviewDTO detail(int review_idx) {
		return sqlSession.selectOne("review.detail", review_idx);
	}

	@Override
	public List<ReCommentDTO> comment(int review_idx) {
		return sqlSession.selectList("review.comment",review_idx);
	}

	@Override
	public void addComment(int review_idx, String writer, String contents) {
		Map<String,Object> map = new HashMap<>();
		map.put("review_idx", review_idx);
		map.put("writer", writer);
		map.put("contents", contents);
		sqlSession.insert("review.addComment", map);
	}

	@Override
	public void delComment(int review_idx, int comment_idx) {
		Map<String,Object> map = new HashMap<>();
		map.put("review_idx", review_idx);
		map.put("comment_idx", comment_idx);
		sqlSession.delete("reivew.delComment", map);		
	}

	@Override
	public int checkAttach(String fullName, int review_idx) {
		Map<String,Object> map = new HashMap<>();
		map.put("fullName", fullName);
		map.put("review_idx", review_idx);
		return sqlSession.selectOne("review.checkattach",map);
	}

	@Override
	public List<ReviewDTO> getreview(String userid) {
		return sqlSession.selectList("review.getreview",userid);
	}

	@Override
	public List<ReviewDTO> roomreview(int room_idx) {
		return sqlSession.selectList("review.roomreview",room_idx);
	}

	@Override
	public List<ReviewAccuseDTO> getaccuse(String userid) {
		return sqlSession.selectList("review.getaccuse",userid);
	}

	@Override
	public void insertaccuse(ReviewAccuseDTO radto) {
		sqlSession.insert("review.insertaccuse",radto);
	}

	@Override
	public int countByUser(String userid) {
		return sqlSession.selectOne("review.countByUser",userid);
	}

	@Override
	public int getReviewId(int res_idx) {
		return sqlSession.selectOne("review.getReviewId",res_idx);
	}

}
