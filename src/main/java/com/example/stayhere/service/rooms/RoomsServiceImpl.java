package com.example.stayhere.service.rooms;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.stayhere.model.rooms.dao.RoomsDAO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

@Service
public class RoomsServiceImpl implements RoomsService {

	@Inject
	RoomsDAO roomsDao;
	
	@Override
	public RoomsDTO detailRooms(int room_idx) {
		return roomsDao.detailRooms(room_idx);
	}

}
