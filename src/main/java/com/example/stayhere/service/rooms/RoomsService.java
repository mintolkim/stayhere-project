package com.example.stayhere.service.rooms;

import java.util.List;

import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface RoomsService {
	public List<RoomsDTO> getRoomAllList(int start, int end);  //메인페이지 룸 리스트 불러오기
	public List<String> getRoomPhoto(int room_idx); //방사진 불러오기
	public int getRoomAllCount(); //전체 룸갯수
	public int getRoomOptionCount(String city, String check_in, String check_out);
	public List<RoomsDTO> getRoomOptionList(int start, int end, String city, String check_in, String check_out);
}
