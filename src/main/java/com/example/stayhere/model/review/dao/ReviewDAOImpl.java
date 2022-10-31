package com.example.stayhere.model.review.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.review.dto.ReviewDTO;

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
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int review_idx) throws Exception {
		// TODO Auto-generated method stub

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
		// TODO Auto-generated method stub

	}

	@Override
	public int countArticle() throws Exception {
		return sqlSession.selectOne("review.countArticle");
	}

	@Override
	public ReviewDTO read(int review_idx) throws Exception {
		// TODO Auto-generated method stub
		return null;
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
	public List<ReviewDTO> reviewsByUser(int userid) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void deleteFile(String fullName) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<String> getAttach(int review_idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addAttach(String fullName) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateAttach(String fullName, int review_idx) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ReviewDTO> reviewsCategory(int review_idx, Date write_date, int view_count, int review_star) {
		// TODO Auto-generated method stub
		return null;
	}

}
