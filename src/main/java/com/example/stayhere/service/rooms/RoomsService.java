
package com.example.stayhere.service.rooms;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsService {
	public List<RoomsDTO> listMap(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//지도출력
	public int countrooms(String cityname, int bed, int bath, String reviewStar, int lower, int higher);//숙소갯수확인(지도검색)
	public List<RoomsDTO> address_list(String cityname, int bed, int bath, String reviewStar, int lower, int higher);
  RoomsDTO detailRooms(int room_idx);//숙소 상세정보
}

