package com.example.stayhere.model.wishlist.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.wishlist.dto.WishlistDTO;

@Repository
public class WishlistDAOImpl implements WishlistDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<WishlistDTO> listWish(String userid) {
		return sqlSession.selectList("wishlist.listWish", userid);
	}

	@Override
	public void insertWish(WishlistDTO dto) {
		sqlSession.insert("wishlist.insertWish", dto);
	}

	@Override
	public void deleteWish(int wish_num) {
		sqlSession.delete("wishlist.deleteWish", wish_num);
		
	}

	@Override
	public void deleteAllWish(String userid) {
		sqlSession.delete("wishlist.deleteAllWish", userid);
		
	}

	@Override
	public int checkWish(WishlistDTO dto) {
		return sqlSession.selectOne("wishlist.checkWish",dto);
	}



}
