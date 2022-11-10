package com.example.stayhere.service.review;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.stayhere.model.review.dao.ReviewDAO;
import com.example.stayhere.model.review.dto.ReviewAccuseDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.review_comment.dto.ReCommentDTO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	ReviewDAO reviewDao;
	
	@Override
	public void deleteFile(String fileName) {
		reviewDao.deleteFile(fileName);

	}

	@Override
	public List<String> getAttach(int review_idx) {
		return reviewDao.getAttach(review_idx);
	}

	@Override
	public void addAttach(String fullName) {
		//return reviewDao.addAttach(fullName);
	}

	@Override
	public void create(ReviewDTO dto) throws Exception {
		reviewDao.create(dto);
	}
	
	@Transactional
	@Override
	public void update(ReviewDTO dto) throws Exception {
		reviewDao.update(dto);
		//첨부파일 확인
		String[] files = dto.getFiles();
		if(files==null) return;
		for(String fullName: files) { 
			if(reviewDao.checkAttach(fullName, dto.getReview_idx())==0){
				reviewDao.updateAttach(fullName, dto.getReview_idx()); 
			} 
		}
	}
	
	@Transactional
	@Override
	public void delete(int review_idx) throws Exception {
		//댓글삭제
		//첨부삭제
		//리뷰게시물 삭제
		reviewDao.delete(review_idx);
	}

	@Override
	public List<ReviewDTO> listAll(int start, int end) throws Exception {
		return reviewDao.listAll(start, end);
	}

	@Override
	public void increaseViewcnt(int review_idx, HttpSession session) throws Exception {
		long update_time=0;
		if(session.getAttribute("update_time_"+review_idx)!=null) {
			//최근에 조회수를 올린 시간
			update_time=(long)session.getAttribute("update_time_"+review_idx);
		}
		long current_time=System.currentTimeMillis();
		//일정시간값 계산 후 조회수 증가
		if(current_time - update_time >24*60*60*1000) {//24시간에 한번
			reviewDao.increaseViewcnt(review_idx);//하나만 들어와도됨
			//조회수 올린시간값 저장처리
			session.setAttribute("update_time_"+review_idx, current_time);
		}

	}

	@Override
	public int countArticle() throws Exception {
		return reviewDao.countArticle();
	}

	@Override
	public ReviewDTO read(int review_idx) throws Exception {
		return reviewDao.read(review_idx);
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

	@Override
	public ReviewDTO detail(int review_idx) {
		return reviewDao.detail(review_idx);
	}

	@Override
	public void addlikey(int review_idx, String userid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int likeycheck(int review_idx, String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void dellikey(int review_idx, String userid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ReCommentDTO> comment(int review_idx) {
		return reviewDao.comment(review_idx);
	}

	@Override
	public void addComment(int review_idx, String writer, String contents) {
		reviewDao.addComment(review_idx, writer, contents);
		
	}

	@Override
	public void delComment(int review_idx, int comment_idx) {
		reviewDao.delComment(review_idx, comment_idx);
		
	}

	/*
	 * public List<ReviewAccuseDTO> acclist(int start, int end) throws Exception {
	 * // TODO Auto-generated method stub return null; }
	 */

	@Override
	public void checkAcc(String review_idx) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void cancelAcc(String review_idx) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int countByAcc(int review_idx) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ReviewAccuseDTO accDetail(int acc_idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertaccuse(ReviewAccuseDTO radto) {
		reviewDao.insertaccuse(radto);
	}

	
	/*
	 * @Override public int accuseCheck(String user, int review_idx) { return
	 * reviewDao.accuseCheck(user, review_idx); }
	 * 
	 * @Override public void accuseCancel(int review_idx) {
	 * reviewDao.accuseCancel(review_idx); }
	 */

	


	

}