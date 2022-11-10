package com.example.stayhere.service.chat;

import java.io.IOException;
import java.util.List;

import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;

public interface ChatRoomService {
	
	public void addChatRoom(ChatRoomDTO dto) throws Exception;
	public List<ChatRoomDTO> readChatHistory(ChatRoomDTO dto) throws IOException;
	public void updateFileName(int c_idx, String fileName)  throws Exception;
	public void createFile(int room_idx, int c_idx) throws Exception;
	public int countByChatId(int room_idx, String userid);
	public ChatRoomDTO findByChatId(int room_idx, String userid);
	public int getChatRoomIdx(int room_idx, String userid);
	public void appendMessage(ChatRoomDTO chatRoom) throws IOException;
	public void updateChatReadUser(int c_idx, int chat_read_user);
	public void updateChatReadHost(int c_idx, int chat_read_host);
	public int getUnreadMessages(String userid);
	public List<ChatListDTO> findByUserId(String userid);
	public List<Integer> getUnreadChatRoom(String userid);
	public ChatRoomDTO findByReadCheck(int c_idx);
	public int countByUser(String userid);//게스트별 채팅 건수


}
