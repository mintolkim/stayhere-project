
package com.example.stayhere.service.rooms;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
		return roomsDao.listMap(cityname, bed, bath, reviewStar, lower, higher);
	}

	@Override
	public int countrooms(String cityname, int bed, int bath, String reviewStar, int lower, int higher) {
		return roomsDao.countrooms(cityname, bed, bath, reviewStar, lower, higher);
	}

	@Override
	public List<RoomsDTO> address_list(String cityname, int bed, int bath, String reviewStar, int lower, int higher) {
		return roomsDao.address_list(cityname, bed, bath, reviewStar, lower, higher);
	}

	@Override
	public RoomsDTO detailRooms(int room_idx) {
		return roomsDao.detailRooms(room_idx);
	}

	@Override
	public List<RoomsDTO> getRoomAllList(int start, int end) {
		return roomsDao.getRoomAllList(start, end);
	}

	@Override
	public List<String> getRoomPhoto(int room_idx) {
		return roomsDao.getRoomPhoto(room_idx);
	}

	@Override
	public int getRoomAllCount() {
		return roomsDao.getRoomAllCount();
	}
	
	@Override
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date) {
		return roomsDao.getRoomDefalutCount(cityname, checkin_date, checkout_date);
	}

	@Override
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, 
			String checkin_date, String checkout_date) {
		return roomsDao.getRoomDefalutList(start, end, cityname, checkin_date, checkout_date);
	}

	@Override
	public int getRoomOptionCount(Map<String, Object> param) {
		return roomsDao.getRoomOptionCount(param);
	}

	@Override
	public List<RoomsDTO> getRoomOptionList(int start, int end, Map<String, Object> param) {
		return roomsDao.getRoomOptionList(start, end, param);
	}

	@Override
	public int findRoomMaxPrice() {
		return roomsDao.findRoomMaxPrice();
	}

	@Override
	public int findRoomMinPrice() {
		return roomsDao.findRoomMinPrice();
	}

	@Override
	public boolean previousDateCheck(String checkin_date) throws Exception {
		//String 값 Date값으로 변환하기 위한 sdf선언
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//현재 날짜값 저장 
		Date nowDate = new Date();
		Date checkDate = sdf.parse(checkin_date);
		//date1.compareTo(date2) : 값이 동일하면 0, 이전날짜이면 0보다 작은값 반환,
		//date1.before(date2) : date1이 date2보다 이전날짜이면 true
		//date1.after(date2) : date1이 date2보다 이전날짜이면 false
		//date1.equals(date2) : 동일한 시점 true
		return checkDate.after(nowDate);
	}
	
	@Override
	public int getRoomOptionCount(String city, String check_in, String check_out) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<RoomsDTO> getRoomOptionList(int start, int end, String city, String check_in, String check_out) {
		// TODO Auto-generated method stub
		return null;
	}

}
