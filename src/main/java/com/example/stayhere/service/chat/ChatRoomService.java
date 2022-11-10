package com.example.stayhere.service.chat;

import java.io.IOException;
import java.util.List;

import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;

public interface ChatRoomService {
	
	public void addChatRoom(ChatRoomDTO dto) throws Exception;  //채팅룸 추가
	public List<ChatRoomDTO> readChatHistory(ChatRoomDTO dto) throws IOException; //채팅이력 가져오기
	public void updateFileName(int c_idx, String fileName)  throws Exception; //채팅 파일 업데이트
	public void createFile(int room_idx, int c_idx) throws Exception; //채팅파일 생성
	public int countByChatId(int room_idx, String userid); //
	public ChatRoomDTO findByChatInfo(int room_idx, String userid);
	public int getChatRoomIdx(int room_idx, String userid);
	public void appendMessage(ChatRoomDTO chatRoom) throws IOException;
	public void updateChatReadUser(int c_idx, int chat_read_user);
	public void updateChatReadHost(int c_idx, int chat_read_host);
	public int getUnreadMessages(String userid);
	public List<ChatListDTO> findByUserId(String userid);
	public List<Integer> getUnreadChatRoom(String userid);
	public ChatRoomDTO findByReadCheck(int c_idx);
	public int getChatRoomCount(String sessionId, String keyword); //채팅 리스트 갯수
	public List<ChatListDTO> getChatRoomList(int start, int end, String sessionId, String keyword); // 채팅리스트
	public String findByHostProfile(String h_userid);


}
