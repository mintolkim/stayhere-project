package com.example.stayhere.service.chat;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.stayhere.model.chat.dao.ChatRoomDAO;
import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;
import com.example.stayhere.util.UploadFileUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ChatRoomServiceImpl implements ChatRoomService {

	@Inject
	ChatRoomDAO chatRoomDao;
	
	@Resource(name="fileUploadPath")
	String fileUploadPath;
	
	
	@Override
	public void addChatRoom(ChatRoomDTO dto) throws Exception {
		Date createdDate = new Date();
		log.info("Service단 createdDate : "  + createdDate);
		dto.setCreate_date(createdDate);
		chatRoomDao.addChatRoom(dto);
	}

	
	//no connection with DB
	@Override
	public List<ChatRoomDTO> readChatHistory(ChatRoomDTO dto) throws IOException {
		
		String pathName = fileUploadPath + dto.getFilename();
		
		//DB에 저장된 chat.txt 파일 읽기
		BufferedReader br = new BufferedReader(new FileReader(pathName));
		//view에 chatRoom 객체로 전달
		ChatRoomDTO chatRoomLines = new ChatRoomDTO();
		List<ChatRoomDTO> chatHistory = new ArrayList<ChatRoomDTO>();
		String chatLine;
		int idx = 1;
		
		while ((chatLine = br.readLine()) != null ) {
			//1개 메시지는 3줄(보낸사람, 메시지 내용, 보낸시간)로 구성
			int answer = idx % 3;
			
			if (answer == 1) {
				//보낸사람
				chatRoomLines.setSenderName(chatLine);
				idx++;
			} else if (answer == 2) {
				//메시지내용 저장할때 개행처리를 치환한 문자를 <br>로 변경
				chatLine = chatLine.replace("&&", "<br>");
				chatRoomLines.setContent(chatLine);
				idx++;
			} else {
				//보낸시간
				chatRoomLines.setSendTime(chatLine);
				//메시지 담긴 ChatRoom 객체 List에 저장
				chatHistory.add(chatRoomLines);
				//객체 초기화, 줄(row)인덱스 초기화
				chatRoomLines = new ChatRoomDTO();
				idx = 1;
			}			
		}
		
		return chatHistory;
			
	}
		

	@Override
	public void updateFileName(int c_idx, String fileName) throws Exception {
		chatRoomDao.updateFileName(c_idx, fileName);
	}

	@Override
	public void createFile(int room_idx, int c_idx) throws Exception {
			
		String calcName = UploadFileUtils.calcName();
		log.info("calcName : " + calcName);
		
		String fileName = calcName + "_" + room_idx + "_" + c_idx + ".txt";
		log.info("filename : " + fileName);
		
		String pathName = fileUploadPath + fileName;
		log.info("pathName : " + pathName);
		
		//File 클래스에 pathName 할당
		File txtFile = new File(pathName);
		
		//로컬경로에 파일 생성
		txtFile.createNewFile();
		chatRoomDao.updateFileName(c_idx, fileName);
		
	}

	@Override
	public int countByChatId(int room_idx, String userid) {
		return chatRoomDao.countByChatId(room_idx, userid);
	}

	@Override
	public ChatRoomDTO findByChatId(int room_idx, String userid) {
		return chatRoomDao.findByChatId(room_idx, userid);
	}

	@Override
	public int getChatRoomIdx(int room_idx, String userid) {
		return chatRoomDao.getChatRoomIdx(room_idx, userid);
	}

	//no connection with DB
	@Override
	public void appendMessage(ChatRoomDTO chatRoom) throws IOException {
		
		int room_idx = chatRoom.getRoom_idx();
		String userid = chatRoom.getUserid();
		
		ChatRoomDTO chatRoomAppend = chatRoomDao.findByChatId(room_idx, userid);
				
		String pathName = fileUploadPath + chatRoomAppend.getFilename();
		
		FileOutputStream fos = new FileOutputStream(pathName, true);
		String content = chatRoom.getContent();
		String senderName = chatRoom.getSenderName();
		String senderId = chatRoom.getSenderId();
		String sendTime = chatRoom.getSendTime();
		log.info("print:" + content);
		//개행 처리 문자 변경하여 &&로 변경하여 txt 파일에 추가
		content = content.trim();
		content = content.replace("\n", "&&").replace("\r", "");
		log.info("print replace:" + content);
		String writeContent = senderName + "\n" + content + "\n" + sendTime  + "\n";
		
		byte[] b = writeContent.getBytes();
		
		fos.write(b);
		fos.close();
		
		log.info("senderId: "+ senderId);
		log.info("sellerId: "+ chatRoom.getH_userid());
		log.info(" " + senderId.equals(chatRoom.getH_userid()));
		if (senderId.equals(chatRoom.getH_userid())) {
			updateChatReadUser(chatRoom.getC_idx(), 0);
		} else {
			updateChatReadHost(chatRoom.getC_idx(), 0);
		}
		
	}

	@Override
	public void updateChatReadUser(int c_idx, int chat_read_user) {
		chatRoomDao.updateChatReadUser(c_idx, chat_read_user);
	}

	@Override
	public void updateChatReadHost(int c_idx, int chat_read_host) {
		chatRoomDao.updateChatReadHost(c_idx, chat_read_host);
	}

	@Override
	public int getUnreadMessages(String userid) {
		return chatRoomDao.getUnreadMessages(userid);
	}

	@Override
	public List<ChatListDTO> findByUserId(String userid) {
		return chatRoomDao.findByUserId(userid);
	}

	@Override
	public List<Integer> getUnreadChatRoom(String userid) {
		List<Integer> unread = chatRoomDao.getUnreadChatRoom(userid); 
		return unread;
	}


	@Override
	public ChatRoomDTO findByReadCheck(int c_idx) {
		return chatRoomDao.findByReadCheck(c_idx);
	}


	@Override
	public int countByUser(String userid) {
		return chatRoomDao.countByUser(userid);
	}

}
