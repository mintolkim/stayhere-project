package com.example.stayhere.model.wishlist.dao;

import java.util.List;

import com.example.stayhere.model.wishlist.dto.WishlistDTO;

public interface WishlistDAO {
	public List<WishlistDTO> listWish(String userid); //위시리스트 목록
	public void insertWish(WishlistDTO dto);
	public void deleteWish(int wish_num);
	public void deleteAllWish(String userid);
	public int checkWish(WishlistDTO dto);
	public int wishcheck(WishlistDTO dto);//게스트 찜확인
	public void deleteWishlist(WishlistDTO dto);//게스트 위시리트스 삭제
}
