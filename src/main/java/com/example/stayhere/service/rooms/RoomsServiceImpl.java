
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
	public List<RoomsDTO> listMap(String cityname, RoomsDTO roomdto,int lower, int higher,String checkin_date, String checkout_date) {
		return roomsDao.listMap(cityname,roomdto, lower, higher, checkin_date, checkout_date);
	}

	@Override
	public int countrooms(String cityname, RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date) {
		return roomsDao.countrooms(cityname, roomdto,  lower, higher, checkin_date, checkout_date);
	}

	@Override
	public List<RoomsDTO> address_list(String cityname, RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date) {
		return roomsDao.address_list(cityname, roomdto,  lower, higher,checkin_date,checkout_date);
	}

	@Override
	public RoomsDTO detailRooms(int room_idx) {
		return roomsDao.detailRooms(room_idx);
	}

	@Override
	public List<RoomsDTO> getRoomAllList(int start, int end, String today, String tomorrow) {
		return roomsDao.getRoomAllList(start, end, today, tomorrow);
	}

	@Override
	public int getRoomAllCount(String today, String tomorrow) {
		return roomsDao.getRoomAllCount(today, tomorrow);
	}
	
	@Override
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date) {
		return roomsDao.getRoomDefalutCount(cityname, checkin_date, checkout_date);
	}

	@Override
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, 
			String checkin_date, String checkout_date) {
		
		List<RoomsDTO> list = roomsDao.getRoomDefalutList(start, end, cityname, checkin_date, checkout_date);
		for(RoomsDTO dto : list) {
			String contents = dto.getContents();
			contents = contents.replace("<p>", "").replace("</p>", "").replace("<br>","");
			dto.setContents(contents);
		}
		return list;
	}

	@Override
	public int getRoomOptionCount(Map<String, Object> param) {
		return roomsDao.getRoomOptionCount(param);
	}

	@Override
	public List<RoomsDTO> getRoomOptionList(int start, int end, Map<String, Object> param) {
		List<RoomsDTO> list = roomsDao.getRoomOptionList(start, end, param);
		for(RoomsDTO dto : list) {
			String contents = dto.getContents();
			contents = contents.replace("<p>", "").replace("</p>", "").replace("<br>","");
			dto.setContents(contents);
		}
		return list;
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
	public void insert(RoomsDTO dto) {
		roomsDao.insert(dto);
	}
	
	@Override
	public RoomsDTO getRoomInfo(int room_idx) {
		return roomsDao.getRoomInfo(room_idx);
	}
	
	@Override
	public void deleteConfirm(int room_idx) {
		roomsDao.deleteConfirm(room_idx);
	}
	
	@Override
	public void updateRoom(RoomsDTO dto) {
		roomsDao.updateRoom(dto);
	}
	
	@Override
	public void updateRoomphoto(RoomsDTO dto) {
		roomsDao.updateRoomphoto(dto);
	}	
}
