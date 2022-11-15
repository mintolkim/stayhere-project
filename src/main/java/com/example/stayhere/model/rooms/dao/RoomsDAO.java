package com.example.stayhere.model.rooms.dao;

import java.util.List;
import java.util.Map;

import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsDAO {
	public List<RoomsDTO> listMap(String cityname, RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date, String align, String userid);//숙소검색
	public int countrooms(String cityname, RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date);//숙소갯수출력(지도검색)
	public List<RoomsDTO> address_list(String cityname, RoomsDTO roomdto, int lower, int higher,String checkin_date, String checkout_date);//주소검색
	public RoomsDTO detailRooms(int room_idx);//숙소 상세정보
	public List<RoomsDTO> getRoomAllList(int start, int end, String today, String tomorrow);  //메인페이지 룸 리스트 불러오기
	public int getRoomAllCount(String today, String tomorrow);  
	public int getRoomAllCount(String today);  
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date); // 기본 검색 결과 갯수
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, String checkin_date, String checkout_date); //기본 검색 결과 리스트
	public int getRoomOptionCount(Map<String, Object> param); //옵션 검색 결과 갯수
	public List<RoomsDTO> getRoomOptionList(int start, int end, Map<String, Object> param); //옵션 검색 결과 리스트
	public int findRoomMaxPrice(); // 방가격 최대값
	public int findRoomMinPrice(); // 방가격 최소값
	public void insert(RoomsDTO dto);
	public RoomsDTO getRoomInfo(int room_idx);
	public void deleteConfirm(int room_idx);
	public void updateRoom(RoomsDTO dto);
	public void updateRoomphoto(RoomsDTO dto);
	public List<RoomsDTO> allroom_admin(int start, int end, String select);//모든숙소불러오기(어드민)
	public void changestate(int room_idx, String state);//숙소상태변경
	public List<RoomsDTO> getconfirm();//승인숙소불러오기
	public List<RoomsDTO> getdelay();//승인대기숙소 불러오기
	public List<RoomsDTO> getreject();//승인거절숙소 불러오기
	public List<RoomsDTO> getpopular(String today);//인기숙소 top10
	public List<String> search_list();//검색어 리스트
	public List<String> matchDetail(int room_idx);//해당숙소의 예약된 날짜 불러오기
	public List<Map<String, Object>> searchList(String keyword); //검색어 리스트 2
}
