package com.example.stayhere.model.wishlist.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.wishlist.dto.WishlistDTO;

@Repository
public class WishlistDAOImpl implements WishlistDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public int wishCount(String userid) {
		return sqlSession.selectOne("wishlist.wishCount", userid);
	}
	
	@Override
	public List<WishlistDTO> listWish(String userid, int start, int end) {
		Map<String, Object>map = new HashMap<>();
		map.put("userid", userid);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("wishlist.listWish", map);
	}
	

	@Override
	public void insertWish(WishlistDTO dto) {
		sqlSession.insert("wishlist.insertWish", dto);
	}

	@Override
	public void deleteWish(WishlistDTO dto) {
		sqlSession.delete("wishlist.deleteWish", dto);
		
	}

	@Override
	public void deleteAllWish(String userid) {
		sqlSession.delete("wishlist.deleteAllWish", userid);
		
	}

	@Override
	public int checkWish(WishlistDTO dto) {
		return sqlSession.selectOne("wishlist.checkWish",dto);
	}

	@Override
	public int duplicateCehck(WishlistDTO dto) {
		return sqlSession.selectOne("wishlist.duplicateCehck", dto);
	}

	@Override
	public List<WishlistDTO> addCheck(String userid) {
		return sqlSession.selectList("wishlist.addCheck", userid);
	}

	@Override
	public List<WishlistDTO> addressList(String userid) {
		return sqlSession.selectList("wishlist.addressList", userid);
	}

	@Override
	public int wishcheck(WishlistDTO dto) {
		return sqlSession.selectOne("wishlist.wishcheck",dto);
	}

	@Override
	public void deleteWishlist(WishlistDTO dto) {
		sqlSession.delete("wishlist.deleteWishlist",dto);
	}

}
