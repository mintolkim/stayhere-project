
package com.example.stayhere.service.rooms;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.example.stayhere.controller.MainController;
import com.example.stayhere.model.rooms.dao.RoomsDAO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;
import com.example.stayhere.util.DateParse;

@Service
public class RoomsServiceImpl implements RoomsService {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(MainController.class);

	@Inject
	RoomsDAO roomsDao;

	@Override
	public List<RoomsDTO> listMap(String cityname, RoomsDTO roomdto,
			int lower, int higher,String checkin_date, String checkout_date,String align,String userid) {
		return roomsDao.listMap(cityname,roomdto, lower, higher, checkin_date, checkout_date,align,userid);
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
			contents = contents.replace("&nbsp;", " ").replace("&n", " ").replace("&nb", " ").replace("&nbs", " ").replace("<br>","");
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
			contents = contents.replace("&nbsp;", " ").replace("&n", " ").replace("&nb", " ").replace("&nbs", " ").replace("<br>","");
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
		//String ??? Date????????? ???????????? ?????? sdf??????
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//?????? ????????? ?????? 
		Date nowDate = new Date();
		Date checkDate = sdf.parse(checkin_date);
		//date1.compareTo(date2) : ?????? ???????????? 0, ?????????????????? 0?????? ????????? ??????,
		//date1.before(date2) : date1??? date2?????? ?????????????????? true
		//date1.after(date2) : date1??? date2?????? ?????????????????? false
		//date1.equals(date2) : ????????? ?????? true
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

	@Override
	public List<String> search_list() {
		return roomsDao.search_list();
	}
	
	public List<String> matchDetail(int room_idx) {
		List<String> list=roomsDao.matchDetail(room_idx);
		for(int i=0; i<list.size(); i++) {
			Collections.replaceAll(list, list.get(i), DateParse.strToDate(list.get(i)));
		}
		logger.info("re_date??? yyyy-MM-dd????????? ?????? : "+list.toString());
		return list;
	}

	@Override
	public List<Map<String, Object>> searchList(String keyword) {
		return roomsDao.searchList(keyword);
	}	
}
