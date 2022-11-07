package com.example.stayhere.model.wishlist.dao;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.model.wishlist.dto.WishlistDTO;

public interface WishlistDAO {
	public int wishCount(String userid); //목록 갯수
	public List<RoomsDTO> listWish(String userid, int start, int end); //위시리스트 목록
	public void insertWish(WishlistDTO dto);
	public void deleteWish(WishlistDTO dto);
	public void deleteAllWish(String userid);
	public int checkWish(WishlistDTO dto);
	public int duplicateCehck(WishlistDTO dto);
	public List<WishlistDTO> addCheck(String userid);
}
