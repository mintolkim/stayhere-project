package com.example.stayhere.service.qna;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.stayhere.model.qna.dao.QnaDAO;
import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.qna_comment.dto.QnaCommentDTO;
@Service
public class QnaServiceImpl implements QnaService {
	
	@Inject
	QnaDAO qnaDao;
	
	@Override
	public List<QnaDTO> listQna(int start, int end, String keyword, String category, String select) {
		return qnaDao.listQna(start,end,keyword,category,select);
	}

	@Override
	public String passwdck(int q_idx) {
		return qnaDao.passwdck(q_idx);
	}

	@Override
	public QnaDTO detailQna(int q_idx) {
		return qnaDao.detailQna(q_idx);
	}

	@Override
	public int checkpd(int q_idx, String passwd) {
		return qnaDao.checkpd(q_idx,passwd);
	}

	@Override
	public List<QnaCommentDTO> comment(int q_idx) {
		return qnaDao.comment(q_idx);
	}

	@Override
	public void addcomment(int q_idx, String writer, String contents) {
		qnaDao.addcomment(q_idx, writer, contents);
	}

	@Override
	public QnaCommentDTO viewComment(int comment_idx) {
		return qnaDao.viewComment(comment_idx);
	}

	@Override
	public void updateStep(int ref, int re_step) {
		qnaDao.updateStep(ref,re_step);
		
	}

	@Override
	public void addcomment2(QnaCommentDTO dto) {
		qnaDao.addcomment2(dto);
	}

	@Override
	public void delcomment(int q_idx, int comment_idx) {
		qnaDao.delcomment(q_idx,comment_idx);
	}

	@Override
	public void addscrap(int q_idx, String userid) {
		qnaDao.addscrap(q_idx,userid);
	}

	@Override
	public void addlikey(int q_idx, String userid) {
		qnaDao.addlikey(q_idx,userid);
	}

	@Override
	public int scrapcheck(String user, int q_idx) {
		return qnaDao.scrapcheck(user,q_idx);
	}

	@Override
	public int likeycheck(String user, int q_idx) {
		return qnaDao.likeycheck(user,q_idx);
	}

	@Override
	public void delscrap(int q_idx, String userid) {
		qnaDao.delscrap(q_idx,userid);
	}

	@Override
	public void dellikey(int q_idx, String userid) {
		qnaDao.dellikey(q_idx,userid);
	}

	@Override
	public void addviewcount(int q_idx, HttpSession session) throws Exception {
		long update_time=0;
		if(session.getAttribute("update_time_"+q_idx)!=null) {
			//최근에 조회수를 올린 시간
			update_time=(long)session.getAttribute("update_time_"+q_idx);
		}
		long current_time=System.currentTimeMillis();
		//일정시간값 계산 후 조회수 증가
		if(current_time - update_time >24*60*60*1000) {//24시간에 한번
			qnaDao.addviewcount(q_idx);
			//조회수 올린시간값 저장처리
			session.setAttribute("update_time_"+q_idx, current_time);
		}
	}

	@Override
	public void selectcoment(int q_idx, int comment_idx) {
		qnaDao.selectcoment(q_idx,comment_idx);
	}

	@Override
	public int countqna(String keyword, String category) {
		return qnaDao.countqna(keyword,category);
	}

	@Override
	public void deleteFile(String fileName) {
			qnaDao.deleteFile(fileName);
	}
	@Transactional
	@Override
	public void create(QnaDTO dto) throws Exception{
		//qna테이블에 레코드추가
		qnaDao.create(dto);
		System.out.println("레코드추가했다.");
		//attach테이블에 레코드 추가
		String[] files=dto.getFiles();//첨부파일 이름 배열
		if(files==null) {
			System.out.println("파일들어온게 없다");
			return;} //첨부파일이 없으면 리턴
		for(String name:files) {
			System.out.println("들어온파일 : "+name);
			qnaDao.addAttach(name);//attach테이블에 insert
		}
	}

	@Override
	public List<String> getAttach(int q_idx) {
		return qnaDao.getAttach(q_idx);
	}

	@Override
	public void addAttach(String fullName) {
	}
	
	@Transactional
	@Override
	public void update(QnaDTO dto) {
		qnaDao.update(dto);
		String[] files=dto.getFiles();//첨부파일 이름 배열
		if(files==null)return; //첨부파일이 없으면 리턴
		for(String name:files) {
			if(qnaDao.checkattach(name,dto.getQ_idx())==0) {//이미 있는 파일인지 확인
				qnaDao.updateAttach(name,dto.getQ_idx());//없을때 insert
			}
		}
	}
	@Transactional
	@Override
	public void delete(int q_idx) throws Exception{
		qnaDao.delete(q_idx);
	}



}
