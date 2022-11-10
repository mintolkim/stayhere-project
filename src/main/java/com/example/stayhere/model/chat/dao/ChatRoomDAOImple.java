package com.example.stayhere.model.chat.dao;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;

@Repository
public class ChatRoomDAOImple implements ChatRoomDAO {

	@Inject
	SqlSession sqlSession;
	
	
	@Override
	public void addChatRoom(ChatRoomDTO dto) throws IOException {
		sqlSession.insert("chat.addChatRoom", dto);

	}

	@Override
	public void updateFileName(int c_idx, String fileName) {
		Map<String, Object> map = new HashMap<>();
		map.put("c_idx", c_idx);
		map.put("fileName", fileName);
		sqlSession.update("chat.updateFileName",map);
		
	}

	@Override
	public int countByChatId(int room_idx, String userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("room_idx", room_idx);
		map.put("userid", userid);
		return sqlSession.selectOne("chat.countByChatId", map);
	}

	@Override
	public int getChatRoomIdx(int room_idx, String userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("room_idx", room_idx);
		map.put("userid", userid);
		return sqlSession.selectOne("chat.getChatRoomIdx", map);
	}

	@Override
	public ChatRoomDTO findByChatId(int room_idx, String userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("room_idx", room_idx);
		map.put("userid", userid);
		return sqlSession.selectOne("chat.findByChatId", map);
	}

	@Override
	public void updateChatReadUser(int c_idx, int chat_read_user) {
		Map<String, Object> map = new HashMap<>();
		map.put("c_idx", c_idx);
		map.put("chat_read_user", chat_read_user);
		sqlSession.update("chat.updateChatReadUser", map);

	}

	@Override
	public void updateChatReadHost(int c_idx, int chat_read_host) {
		Map<String, Object> map = new HashMap<>();
		map.put("c_idx", c_idx);
		map.put("chat_read_host", chat_read_host);
		sqlSession.update("chat.updateChatReadHost", map);
	}

	@Override
	public int getUnreadMessages(String userid) {
		return sqlSession.selectOne("chat.getUnreadMessages", userid);
	}

	@Override
	public List<ChatListDTO> findByUserId(String userid) {
		return sqlSession.selectList("chat.findByUserId", userid);
	}

	@Override
	public List<Integer> getUnreadChatRoom(String userid) {
		return sqlSession.selectList("chat.getUnreadChatRoom", userid);
	}

	@Override
	public ChatRoomDTO findByReadCheck(int c_idx) {
		return sqlSession.selectOne("chat.findByReadCheck", c_idx);
	}

	@Override
	public int countByUser(String userid) {
		return sqlSession.selectOne("chat.countByUser", userid);
	}


}
