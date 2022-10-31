package com.example.stayhere.model.qna.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.qna_comment.dto.QnaCommentDTO;
@Repository
public class QnaDAOImpl implements QnaDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<QnaDTO> listQna(int start, int end, String keyword, String category, String select) {
		Map<String,Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);
		map.put("select", select);
		map.put("keyword", "%"+keyword+"%");
		return sqlSession.selectList("qna.listQna",map);
	}
	@Override
	public String passwdck(int q_idx) {
		return sqlSession.selectOne("qna.passwdch",q_idx);
	}
	@Override
	public QnaDTO detailQna(int q_idx) {
		return sqlSession.selectOne("qna.detailQna",q_idx);
	}
	@Override
	public int checkpd(int q_idx, String passwd) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("passwd", passwd);
		return sqlSession.selectOne("qna.checkpd",map);
	}
	@Override
	public List<QnaCommentDTO> comment(int q_idx) {
		return sqlSession.selectList("qna.comment",q_idx);
	}
	@Override
	public void addcomment(int q_idx, String writer, String contents) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("writer", writer);
		map.put("contents", contents);
		sqlSession.insert("qna.addcomment",map);
	}
	@Override
	public QnaCommentDTO viewComment(int comment_idx) {
		return sqlSession.selectOne("qna.viewComment",comment_idx);
	}
	@Override
	public void updateStep(int ref, int re_step) {
		Map<String,Object> map = new HashMap<>();
		map.put("ref", ref);
		map.put("re_step", re_step);
		sqlSession.update("qna.updateStep",map);
		
	}
	@Override
	public void addcomment2(QnaCommentDTO dto) {
		sqlSession.insert("qna.addcomment2",dto);
	}
	@Override
	public void delcomment(int q_idx, int comment_idx) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("comment_idx", comment_idx);
		sqlSession.delete("qna.delcomment",map);
	}
	@Override
	public void addscrap(int q_idx, String userid) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("userid", userid);
		sqlSession.insert("qna.addscrap",map);
	}
	@Override
	public void addlikey(int q_idx, String userid) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("userid", userid);
		sqlSession.insert("qna.addlikey",map);
	}
	@Override
	public int scrapcheck(String user, int q_idx) {
		Map<String,Object> map = new HashMap<>();
		map.put("userid", user);
		map.put("q_idx", q_idx);
		return sqlSession.selectOne("qna.scrapcheck",map);
	}
	@Override
	public int likeycheck(String user, int q_idx) {
		Map<String,Object> map = new HashMap<>();
		map.put("userid", user);
		map.put("q_idx", q_idx);
		return sqlSession.selectOne("qna.likeycheck",map);
	}
	@Override
	public void delscrap(int q_idx, String userid) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("userid", userid);
		sqlSession.delete("qna.delscrap",map);
	}
	@Override
	public void dellikey(int q_idx, String userid) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("userid", userid);
		sqlSession.delete("qna.dellikey",map);
	}
	@Override
	public void addviewcount(int q_idx) throws Exception {
		sqlSession.update("qna.addviewcount",q_idx);
	}
	@Override
	public void selectcoment(int q_idx, int comment_idx) {
		Map<String,Object> map = new HashMap<>();
		map.put("q_idx", q_idx);
		map.put("comment_idx", comment_idx);
		sqlSession.update("qna.selectcoment",map);
	}
	@Override
	public int countqna(String keyword, String category) {
		Map<String,Object> map = new HashMap<>();
		map.put("keyword", "%"+keyword+"%");
		map.put("category", category);
		return sqlSession.selectOne("qna.countqna",map);
	}
	@Override
	public void deleteFile(String fileName) {
		sqlSession.delete("qna.deleteFile",fileName);
	}
	@Override
	public void create(QnaDTO dto) throws Exception {
		sqlSession.insert("qna.create",dto);
	}
	@Override
	public void addAttach(String name) {
		sqlSession.insert("qna.addAttach",name);
	}
	@Override
	public List<String> getAttach(int q_idx) {
		return sqlSession.selectList("qna.getAttach",q_idx);
	}
	@Override
	public void update(QnaDTO dto) {
		sqlSession.update("qna.update",dto);
	}
	@Override
	public void updateAttach(String name, int q_idx) {
		Map<String,Object> map=new HashMap<>();
		map.put("fullName", name);
		map.put("q_idx", q_idx);
		sqlSession.insert("qna.updateAttach",map);
	}
	@Override
	public int checkattach(String name, int q_idx) {
		Map<String,Object> map=new HashMap<>();
		map.put("fullName", name);
		map.put("q_idx", q_idx);
		return sqlSession.selectOne("qna.checkattach",map);
	}
	@Override
	public void delete(int q_idx) throws Exception{
		sqlSession.delete("qna.delete",q_idx);
	}
	

}
