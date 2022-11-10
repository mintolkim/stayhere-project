package com.example.stayhere.service.wishlist;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.model.wishlist.dto.WishlistDTO;

public interface WishlistService {
	public int wishCount(String userid); //위시리스트 갯수
	public List<WishlistDTO> listWish(String userid, int start, int end); //위시리스트 목록
	public void insertWish(WishlistDTO dto);//위시리스트 추가
	public void deleteWish(WishlistDTO dto);//위시리스트 삭제
	public void deleteAllWish(String userid);//위시리스트 모두 삭제
	public int checkWish(WishlistDTO dto);
	public int duplicateCehck(WishlistDTO dto); //위시리스트 중복체크
	public List<WishlistDTO> addCheck(String userid);
	public List<WishlistDTO> addressList(String userid);//위시리스트 숙소 주소 목록
	public void deleteWishlist(WishlistDTO dto);//게스트 위시리스트 삭제
	public int wishcheck(WishlistDTO dto);//게스트 찜목록 확인
}
