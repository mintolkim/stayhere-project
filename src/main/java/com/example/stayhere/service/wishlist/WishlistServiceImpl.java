package com.example.stayhere.service.wishlist;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.wishlist.dao.WishlistDAO;
import com.example.stayhere.model.wishlist.dto.WishlistDTO;

@Service
public class WishlistServiceImpl implements WishlistService {

	@Inject
	WishlistDAO wishlistDao;
	
	
	@Override
	public int wishCount(String userid) {
		return wishlistDao.wishCount(userid);
	}
	
	@Override
	public List<WishlistDTO> listWish(String userid, int start, int end) {
		return wishlistDao.listWish(userid, start, end);
	}

	@Override
	public void insertWish(WishlistDTO dto) {
		wishlistDao.insertWish(dto);

	}

	@Override
	public void deleteWish(WishlistDTO dto) {
		wishlistDao.deleteWish(dto);
	}

	@Override
	public void deleteAllWish(String userid) {
		wishlistDao.deleteAllWish(userid);

	}

	@Override
	public int checkWish(WishlistDTO dto) {
		return wishlistDao.checkWish(dto);
	}

	public int duplicateCehck(WishlistDTO dto) {
		return wishlistDao.duplicateCehck(dto);
	}

	@Override
	public List<WishlistDTO> addCheck(String userid) {
		return wishlistDao.addCheck(userid);
	}

	@Override
	public List<WishlistDTO> addressList(String userid) {
		return wishlistDao.addressList(userid);
	}

	@Override
	public int wishcheck(WishlistDTO dto) {
		return wishlistDao.wishcheck(dto);
	}

	@Override
	public void deleteWishlist(WishlistDTO dto) {
		wishlistDao.deleteWishlist(dto);
	}


}
