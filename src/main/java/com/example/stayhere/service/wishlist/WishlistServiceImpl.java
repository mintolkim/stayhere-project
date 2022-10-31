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
	public List<WishlistDTO> listWish(String userid) {
		return wishlistDao.listWish(userid);
	}

	@Override
	public void insertWish(WishlistDTO dto) {
		wishlistDao.insertWish(dto);

	}

	@Override
	public void deleteWish(int wish_num) {
		wishlistDao.deleteWish(wish_num);
	}

	@Override
	public void deleteAllWish(String userid) {
		wishlistDao.deleteAllWish(userid);

	}

	@Override
	public int checkWish(WishlistDTO dto) {
		return wishlistDao.checkWish(dto);
	}

}
