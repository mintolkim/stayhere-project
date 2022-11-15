package com.example.stayhere.service.rooms;

import java.util.List;
import java.util.Map;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsService {
	public List<RoomsDTO> listMap(String cityname, RoomsDTO roomdto, int lower, int higher, String checkin_date, String checkout_date, String align, String userid);//지도출력
	public int countrooms(String cityname, RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date);//숙소갯수확인(지도검색)
	public List<RoomsDTO> address_list(String cityname,RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date);
	public RoomsDTO detailRooms(int room_idx);//숙소 상세정보
	public List<RoomsDTO> getRoomAllList(int start, int end, String today, String tomorrow);  //메인페이지 룸 리스트 불러오기
	public int getRoomAllCount(String today, String tomorrow); //전체 룸갯수
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date); //기본검색 갯수
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, String checkin_date, String checkout_date); //기본검색 리스트
	public int getRoomOptionCount(Map<String, Object> param); // 옵션검색 갯수
	public List<RoomsDTO> getRoomOptionList(int start, int end, Map<String, Object> param);  // 옵션검색 리스트
	public int findRoomMaxPrice(); // 방가격 최대값
	public int findRoomMinPrice(); // 방가격 최소값
	public boolean previousDateCheck(String checkin_date) throws Exception; //이전날짜 체크
	public void insert(RoomsDTO dto); 
	public RoomsDTO getRoomInfo(int room_idx);
	public void deleteConfirm(int room_idx);
	public void updateRoom(RoomsDTO dto); 
	public void updateRoomphoto(RoomsDTO dto);
	public List<String> search_list();//검색어 리스트
	public List<String> matchDetail(int room_idx);//해당숙소의 예약된 날짜 불러오기
	public List<Map<String, Object>> searchList(String keyword); //검색어 리스트2
}

