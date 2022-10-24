
package com.example.stayhere.model.rooms.dao;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsDAO {
	public List<RoomsDTO> listMap(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//숙소검색
	public int countrooms(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//숙소갯수출력(지도검색)
	public List<RoomsDTO> address_list(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//주소검색
	public RoomsDTO detailRooms(int room_idx);//숙소 상세정보
	public List<RoomsDTO> getRoomAllList(int start, int end);  //메인페이지 룸 리스트 불러오기
	public List<String> getRoomPhoto(int room_idx); //사진정보 불러오기
	public int getRoomAllCount();
	public int getRoomOptionCount(String city, String check_in, String check_out);
	public List<RoomsDTO> getRoomOptionList(int start, int end, String city, String check_in, String check_out);
}
