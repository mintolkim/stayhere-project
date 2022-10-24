package com.example.stayhere.model.rooms.dao;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsDAO {
	
	public List<RoomsDTO> getRoomAllList(int start, int end);  //메인페이지 룸 리스트 불러오기
	public List<String> getRoomPhoto(int room_idx);
	public int getRoomAllCount();
	public int getRoomOptionCount(String city, String check_in, String check_out);
	public List<RoomsDTO> getRoomOptionList(int start, int end, String city, String check_in, String check_out);

}
