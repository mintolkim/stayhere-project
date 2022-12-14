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
			//????????? ???????????? ?????? ??????
			update_time=(long)session.getAttribute("update_time_"+q_idx);
		}
		long current_time=System.currentTimeMillis();
		//??????????????? ?????? ??? ????????? ??????
		if(current_time - update_time >24*60*60*1000) {//24????????? ??????
			qnaDao.addviewcount(q_idx);
			//????????? ??????????????? ????????????
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
		//qna???????????? ???????????????
		qnaDao.create(dto);
		System.out.println("?????????????????????.");
		//attach???????????? ????????? ??????
		String[] files=dto.getFiles();//???????????? ?????? ??????
		if(files==null) {
			System.out.println("?????????????????? ??????");
			return;} //??????????????? ????????? ??????
		for(String name:files) {
			System.out.println("??????????????? : "+name);
			qnaDao.addAttach(name);//attach???????????? insert
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
		String[] files=dto.getFiles();//???????????? ?????? ??????
		if(files==null)return; //??????????????? ????????? ??????
		for(String name:files) {
			if(qnaDao.checkattach(name,dto.getQ_idx())==0) {//?????? ?????? ???????????? ??????
				qnaDao.updateAttach(name,dto.getQ_idx());//????????? insert
			}
		}
	}
	@Transactional
	@Override
	public void delete(int q_idx) throws Exception{
		qnaDao.delete(q_idx);
	}

	@Override
	public int countguestQna(String userid) {
		return qnaDao.countguestQna(userid);
	}

	@Override
	public List<QnaDTO> listguestQna(int start, int end, String userid) {
		return qnaDao.listguestQna(start,end,userid);
	}



}
