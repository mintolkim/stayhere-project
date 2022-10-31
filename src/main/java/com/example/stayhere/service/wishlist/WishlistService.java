package com.example.stayhere.service.wishlist;

import java.util.List;

import com.example.stayhere.model.wishlist.dto.WishlistDTO;

public interface WishlistService {
	public List<WishlistDTO> listWish(String userid); //위시리스트 목록
	public void insertWish(WishlistDTO dto);
	public void deleteWish(int wish_num);
	public void deleteAllWish(String userid);
	public int checkWish(WishlistDTO dto);
}
