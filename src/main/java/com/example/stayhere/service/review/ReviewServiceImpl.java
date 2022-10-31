package com.example.stayhere.service.review;

import java.util.Date;
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
		reviewDao.create(dto);
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
	public List<ReviewDTO> listAll(int start, int end) throws Exception {
		return reviewDao.listAll(start, end);
	}

	@Override
	public void increaseViewcnt(int review_idx) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public int countArticle() throws Exception {
		return reviewDao.countArticle();
	}

	@Override
	public ReviewDTO read(int review_idx) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<ReviewDTO> reviewsByRoom(int room_idx) {
		return reviewDao.reviewsByRoom(room_idx);
	}

	@Override
	public int countByRoom(int room_idx) {
		return reviewDao.countByRoom(room_idx);
	}

	@Override
	public double starByRoom(int room_idx) {
		return reviewDao.starByRoom(room_idx);
	}

	@Override
	public List<ReviewDTO> reviewsCategory(int review_idx, Date write_date, int view_count, int review_star) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReviewDTO> reviewsByUser(int userid) {
		// TODO Auto-generated method stub
		return null;
	}

}
