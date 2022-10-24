package com.example.stayhere.service.rooms;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.rooms.dao.RoomsDAO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
@Service
public class RoomsServiceImpl implements RoomsService {

	@Inject
	RoomsDAO roomsDao;
	
	@Override
	public List<RoomsDTO> listMap(String cityname, int bed, int bath, String reviewStar, int lower, int higher) {
		return roomsDao.listMap(cityname,bed,bath,reviewStar,lower,higher);
	}

	@Override
	public int countrooms(String cityname, int bed, int bath, String reviewStar, int lower, int higher) {
		return roomsDao.countrooms(cityname,bed,bath,reviewStar,lower,higher);
	}

	@Override
	public List<RoomsDTO> address_list(String cityname, int bed, int bath, String reviewStar, int lower, int higher) {
		return roomsDao.address_list(cityname,bed,bath,reviewStar,lower,higher);
	}

}
