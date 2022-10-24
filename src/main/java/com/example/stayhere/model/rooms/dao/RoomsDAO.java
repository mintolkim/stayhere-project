
package com.example.stayhere.model.rooms.dao;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsDAO {
	public List<RoomsDTO> listMap(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//숙소검색
	public int countrooms(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//숙소갯수출력(지도검색)
	public List<RoomsDTO> address_list(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//주소검색
  RoomsDTO detailRooms(int room_idx);//숙소 상세정보
}
