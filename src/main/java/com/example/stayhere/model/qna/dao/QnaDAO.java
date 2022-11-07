package com.example.stayhere.model.qna.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.qna_comment.dto.QnaCommentDTO;

public interface QnaDAO {
	public List<QnaDTO> listQna(int start, int end, String keyword, String category, String select);//qna전체목록
	public String passwdck(int q_idx);//qna비밀글 확인
	public QnaDTO detailQna(int q_idx);//qna글 상세보기
	public int checkpd(int q_idx, String passwd);//qna 비밀번호 확인
	public List<QnaCommentDTO> comment(int q_idx);//qna댓글리스트
	public void addcomment(int q_idx, String writer, String contents);//댓글달기
	public QnaCommentDTO viewComment(int comment_idx);//댓글 불러오기
	public void updateStep(int ref, int re_step);//댓글 순서조정
	public void addcomment2(QnaCommentDTO dto);//대댓글쓰기
	public void delcomment(int q_idx, int comment_idx);//댓글삭제
	public void addscrap(int q_idx, String userid);//스크랩추가
	public void addlikey(int q_idx, String userid);//좋아요추가
	public int scrapcheck(String user, int q_idx);//스크랩체크
	public int likeycheck(String user, int q_idx);//좋아요체크
	public void delscrap(int q_idx, String userid);//스크랩취소
	public void dellikey(int q_idx, String userid);//좋아요취소
	public void addviewcount(int q_idx) throws Exception;//조회수 증가
	public void selectcoment(int q_idx, int comment_idx);//댓글채택
	public int countqna(String keyword, String category);//페이징(글 갯수)
	public void deleteFile(String fileName);//업로드파일 삭제
	public void create(QnaDTO dto) throws Exception;//qna글 삽입
	public void addAttach(String name);//qna 업로드파일삽입
	public List<String> getAttach(int q_idx);//첨부파일목록 불러오기
	public void update(QnaDTO dto);//글수정
	public void updateAttach(String name, int q_idx);//글첨부파일수정
	public int checkattach(String name, int q_idx);//첨부파일 확인
	public void delete(int q_idx) throws Exception;//글삭제
	public List<QnaDTO> getqnalist();//qna 답변대기 글 불러오기
}
