package com.example.stayhere.model.chat.dao;

import java.io.IOException;
import java.util.List;

import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;

public interface ChatRoomDAO {

	public void addChatRoom(ChatRoomDTO dto) throws IOException;
	public void updateFileName(int c_idx, String fileName);
	public int countByChatId(int room_idx, String userid);
	public int getChatRoomIdx(int room_idx, String userid);
	public ChatRoomDTO findByChatInfo(int room_idx, String userid);
	public void updateChatReadUser(int c_idx, int chat_read_user);
	public void updateChatReadHost(int c_idx, int chat_read_host);
	public int getUnreadMessages(String userid);
	public List<ChatListDTO> findByUserId(String userid);
	public List<Integer> getUnreadChatRoom(String userid);
	public ChatRoomDTO findByReadCheck(int c_idx);
	public int countByUser(String userid);//게스트별 채팅 건수
	public int getChatRoomCount(String sessionId, String keyword);
	public List<ChatListDTO> getChatRoomList(int start, int end, String sessionId, String keyword);
	public String findByHostProfile(String h_userid);
}
