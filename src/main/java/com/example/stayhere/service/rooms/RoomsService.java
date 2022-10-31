
package com.example.stayhere.service.rooms;

import java.util.List;
import java.util.Map;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsService {
	public List<RoomsDTO> listMap(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//지도출력
	public int countrooms(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//숙소갯수확인(지도검색)
	public List<RoomsDTO> address_list(String cityname, int bed, int bath, String reviewStar, int lower, int higher);
	public RoomsDTO detailRooms(int room_idx);//숙소 상세정보
	public List<RoomsDTO> getRoomAllList(int start, int end);  //메인페이지 룸 리스트 불러오기
	public List<String> getRoomPhoto(int room_idx); //방사진 불러오기
	public int getRoomAllCount(); //전체 룸갯수
	public int getRoomDefalutCount(String cityname, String checkin_date, String checkout_date); //기본검색 갯수
	public List<RoomsDTO> getRoomDefalutList(int start, int end, String cityname, String checkin_date, String checkout_date); //기본검색 리스트
	public int getRoomOptionCount(Map<String, Object> param); // 옵션검색 갯수
	public List<RoomsDTO> getRoomOptionList(int start, int end, Map<String, Object> param);  // 옵션검색 리스트
	public int findRoomMaxPrice(); // 방가격 최대값
	public int findRoomMinPrice(); // 방가격 최소값
	public boolean previousDateCheck(String checkin_date) throws Exception; //이전날짜 체크
	public int getRoomOptionCount(String city, String check_in, String check_out); //
	public List<RoomsDTO> getRoomOptionList(int start, int end, String city, String check_in, String check_out);

}

