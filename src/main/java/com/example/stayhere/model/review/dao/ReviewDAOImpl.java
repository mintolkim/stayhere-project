package com.example.stayhere.model.review.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.review.dto.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	SqlSession sqlSession;
	
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
	public List<ReviewDTO> listAll() throws Exception {
		
		return sqlSession.selectList("review.listAll");
	}

	@Override
	public void increaseViewcnt(int review_idx) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public int countArticle() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ReviewDTO read(int review_idx) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
