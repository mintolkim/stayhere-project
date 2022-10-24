package com.example.stayhere.service.review;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.review.dao.ReviewDAO;
import com.example.stayhere.model.review.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	ReviewDAO reviewDao;
	
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
		// TODO Auto-generated method stub

	}

	@Override
	public void update(ReviewDTO dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int review_idx) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ReviewDTO> listAll() throws Exception {
		return reviewDao.listAll();
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
