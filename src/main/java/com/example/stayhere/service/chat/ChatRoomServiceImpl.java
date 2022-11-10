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
		
		String path = "chat" + File.separator;
		String savedPath = fileUploadPath + path;
		String pathName = savedPath + dto.getFilename();
		
		//DB에 저장된 chat.txt 파일 읽기
		BufferedReader br = new BufferedReader(new FileReader(pathName));
		//view에 chatRoom 객체로 전달
		ChatRoomDTO chatRoomLines = new ChatRoomDTO();
		List<ChatRoomDTO> chatHistory = new ArrayList<ChatRoomDTO>();
		String chatLine;
		int idx = 1;
		
		while ((chatLine = br.readLine()) != null ) {
			//1개 메시지는 4줄(보낸사람ID, 보낸사람, 메시지 내용, 보낸시간)로 구성
			int answer = idx % 3;
			
			if(answer == 1) {
				//보낸사람 아이디
				chatRoomLines.setSenderId(chatLine);
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
		
		//파일이름 생성 (생성일자_룸고유번호_채팅고유번호.txt)
		String calcName = UploadFileUtils.calcName();
		String fileName = calcName + "_" + room_idx + "_" + c_idx + ".txt";
		//파일 경로 설정
		String path = "chat" + File.separator;
		String savedPath = fileUploadPath + path;
		File dirPath = new File(savedPath); 
		if(!dirPath.exists()) { //파일 경로가 존재하지 않으면...
			dirPath.mkdir(); //디렉토리 생성
		}
		//생성파일 경로 및 이름 설정
		String pathName = savedPath + fileName;
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
	public ChatRoomDTO findByChatInfo(int room_idx, String userid) {
		return chatRoomDao.findByChatInfo(room_idx, userid);
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
		
		ChatRoomDTO chatRoomAppend = chatRoomDao.findByChatInfo(room_idx, userid);
				
		String path = "chat" + File.separator;
		String savedPath = fileUploadPath + path;
		String pathName = savedPath + chatRoomAppend.getFilename();
		
		FileOutputStream fos = new FileOutputStream(pathName, true);
		String content = chatRoom.getContent();
//		String senderName = chatRoom.getSenderName();
		String senderId = chatRoom.getSenderId();
		String sendTime = chatRoom.getSendTime();
		log.info("print:" + content);
		//개행 처리 문자 변경하여 &&로 변경하여 txt 파일에 추가
		content = content.trim();
		content = content.replace("\n", "&&").replace("\r", "");
		log.info("print replace:" + content);
		String writeContent = senderId + "\n" + content + "\n" + sendTime  + "\n";
		
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
	
  @Override
  public int getChatRoomCount(String sessionId, String keyword) {
		return chatRoomDao.getChatRoomCount(sessionId, keyword);
	}

	@Override
	public List<ChatListDTO> getChatRoomList(int start, int end, String sessionId, String keyword) {
		return chatRoomDao.getChatRoomList(start, end, sessionId, keyword);
	}

	@Override
	public String findByHostProfile(String h_userid) {
		return chatRoomDao.findByHostProfile(h_userid);
	}

}
