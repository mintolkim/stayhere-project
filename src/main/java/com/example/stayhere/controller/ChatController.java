package com.example.stayhere.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;
import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.service.chat.ChatRoomService;
import com.example.stayhere.service.guest.GuestService;
import com.example.stayhere.util.TimeUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	

	@Inject
	private SimpMessagingTemplate simpMessage;
	
	@Inject
	private ChatRoomService chatRoomService;
	
	@Inject
	GuestService gusetService;

	
	/*
	 * 채팅으로 문의하기 (roomdetail 화면에서 문의하기 버튼 클릭시 이동화면)
	 * @Param userid
	 * @Param room_idx
	 * @throws Exception
	 * @chatRoom = ChatRoomDTO
	 */
	@PostMapping("/chat")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute ChatRoomDTO chatRoom)
			throws Exception {

		// detail 화면에서 Chat화면에 전달해줄 parameter
		String userid = (String) session.getAttribute("userid");
		log.info("chatMessage userid : " + userid);
		log.info("parma DTO : " + chatRoom);
		//유저 정보 불러오기
		GuestDTO guest = gusetService.view_Guest(userid);
		chatRoom.setUserid(guest.getUserid());
		chatRoom.setUser_name(guest.getName());
		model.addAttribute("guest", guest) ;
		log.info("chatRoomDTO : " + chatRoom); 
		
		// 이미 chatRoom이 만들어져있는지 확인
		if (chatRoomService.countByChatId(chatRoom.getRoom_idx(), chatRoom.getUserid()) > 0) {
			log.info("채팅 룸이 만들어 졌으면 실행!!!!!!!!");
			// get ChatRoomInfo
			ChatRoomDTO chatRoomTemp = chatRoomService.findByChatId(chatRoom.getRoom_idx(), 
					chatRoom.getUserid());
			log.info("chatRoomTemp DTO : " + chatRoomTemp);
			// load existing chat history
			List<ChatRoomDTO> chatHistory = chatRoomService.readChatHistory(chatRoomTemp);
			// transfer chatHistory Model to View
			log.info("chatHistory LIST : " + chatHistory);
			model.addAttribute("chatHistory", chatHistory);

		} else {
			log.info("채팅 룸이 안만들어져 있으면 실행!!!!!!!!");
			// chatRoom 생성
			chatRoomService.addChatRoom(chatRoom);
			// text file 생성
			chatRoomService.createFile(chatRoom.getRoom_idx(),
					chatRoomService.getChatRoomIdx(chatRoom.getRoom_idx(), 
							chatRoom.getUserid()));
		}
		// chatRoom Add 시 생성될 chatId
		chatRoom.setC_idx(chatRoomService.getChatRoomIdx(chatRoom.getRoom_idx(),
				chatRoom.getUserid()));
		// chatRoom 객체 Model에 저장해 view로 전달
		model.addAttribute("chatRoomInfo", chatRoom);
		log.info("getWebSocketWithSockJs 가 모두 실행되고 나서 dto : " + chatRoom);
		return "chat/chat";
	}
	
	
	@MessageMapping("/broadcast")
	public void send(ChatRoomDTO chatRoom) throws IOException {
		log.info("send 실행 !!!!!!!!!!!!!!!!");
		chatRoom.setSendTime(TimeUtils.getCurrentTimeStamp());
		log.info("send !!!!!!!! dto : " + chatRoom);
		//append message to txtFile
		chatRoomService.appendMessage(chatRoom);
		int c_idx = chatRoom.getC_idx();
		String url = "/user/" + c_idx + "/queue/messages";
		simpMessage.convertAndSend(url, 
				new ChatRoomDTO(chatRoom.getContent(), chatRoom.getSendTime(), 
						chatRoom.getSenderName(), chatRoom.getSenderId())); 
	}
	
	
	@PostMapping("/chatread/chatroom/ajax")
	public void ajaxChatRoomRead(@RequestBody String json) throws IOException {
		log.info("ajaxChatRoomRead 실행 !!!!!!!!!!!!!!!!");
		JSONObject jsn = new JSONObject(json);
		String c_idxStr = (String) jsn.get("c_idx");
		int c_idx = Integer.parseInt(c_idxStr);
		String flag = (String) jsn.get("flag");
		if (flag.equals("host")) {
			chatRoomService.updateChatReadHost(c_idx, 1);
		} else {
			chatRoomService.updateChatReadUser(c_idx, 1);
		}
		
//				if (!readerId.equals(buyerId)) {
//			chatRoomService.updateChatReadSell(id, 1);
//		} else {
//			chatRoomService.updateChatReadBuy(id, 1);
//		}
	}

	@PostMapping("/chatread/product/ajax")
	@ResponseBody
	public void ajaxChatProductRead(@RequestBody String json) throws IOException {
		log.info("ajaxChatProductRead 이게 실행되야 합니다. " );
		JSONObject jsn = new JSONObject(json);
		String c_idxStr = (String) jsn.get("c_idx");
		log.info("c_idxStr : " + c_idxStr);
		int c_idx = Integer.parseInt(c_idxStr);
		chatRoomService.updateChatReadUser(c_idx, 1);
	}
	
	@GetMapping("/chatlist")
	public String getChatList(Model model, HttpSession session) {
		 return "chat/chat_list";
	}
	
	@GetMapping("/chatroom/{room_idx}/{userid}")
	public String getChatRoom(@PathVariable Map<String, String> requestVar,
			Model model) throws IOException {
		String userid = requestVar.get("userid");
		int room_idx = Integer.parseInt(requestVar.get("room_idx"));
		//유저 정보 불러오기
		GuestDTO guest = gusetService.view_Guest(userid);
		model.addAttribute("guest", guest);
		
					
		//read chatHistory
		ChatRoomDTO chatRoomRead = chatRoomService.findByChatId(room_idx, userid);
		List<ChatRoomDTO> chatHistory = 
				chatRoomService.readChatHistory(chatRoomRead);
		log.info("chatHistory room_idx LIST : " + chatHistory);
		model.addAttribute("chatHistory", chatHistory);
		int c_idx = chatRoomService.getChatRoomIdx(room_idx, userid);
		log.info("chatRoomRead : " + chatRoomRead);
		model.addAttribute("c_idx", c_idx);
		model.addAttribute("room_idx", room_idx);
		model.addAttribute("userid", userid);
		model.addAttribute("h_userid", chatRoomRead.getH_userid());
		model.addAttribute("room_name", chatRoomRead.getRoom_name());
		model.addAttribute("photo1", chatRoomRead.getPhoto1());
		
		return "chat/chat_room";
	}
	
	
	@RequestMapping(value="/chatreadCheck/ajax", method=RequestMethod.POST, produces="application/text; charset=UTF-8" )
	@ResponseBody
	public String ajaxReadCheck(@RequestBody String json) throws Exception {
		JSONObject jsn = new JSONObject(json);
		String c_idxStr = (String) jsn.get("c_idx");
		int c_idx = Integer.parseInt(c_idxStr);
		ChatRoomDTO dto = chatRoomService.findByReadCheck(c_idx);
		log.info("chatreadCheck : " + dto);
		JSONObject jo = new JSONObject();
		jo.put("chat_read_user", dto.getChat_read_user());		
		jo.put("chat_read_host", dto.getChat_read_host());		
		String result = jo.toString();
		log.info("chatreadCheck : " + result);
		return result;
	}
	
	
	
	@RequestMapping(value="/chatUnreadAlert/ajax", method=RequestMethod.POST, produces="application/text; charset=UTF-8" )
	@ResponseBody
	public int chatUnread(@RequestBody String json) {
		JSONObject jsn = new JSONObject(json);
		String userid = (String) jsn.get("userid");
    	int messages = chatRoomService.getUnreadMessages(userid);
    	
		return messages;
	}

	@RequestMapping(value="/chatUnreadMessageInfo/ajax", method=RequestMethod.POST, produces="application/text; charset=UTF-8" )
	@ResponseBody
	public String chatListUnread(@RequestBody String json) {
		//ajax가 전송한 String을 key, value로 분류하기 위해 JSON Object convert
		JSONObject jsn = new JSONObject(json);
		//JSON.get([mapped name])으로 value 추출하기
		String userid = (String) jsn.get("userid");
		//userid에 해당되는 모든 chatRoom select 받기
		List<ChatListDTO> chatRoomList = chatRoomService.findByUserId(userid);
		
		log.info("chatListUnread의 chatRoomList : " + chatRoomList );
		
		//chatRoom 정보는 JSON Array에 저장됨
		JSONArray ja = new JSONArray();
		//userid에 해당되는 읽지 않은 chatRoom select 받기
		List<Integer> unreadChatId = chatRoomService.getUnreadChatRoom(userid);

		 for (ChatListDTO chatList : chatRoomList) {
			//chatRoom 정보를 JSON Object에 put 해줌, chatRoom이 반복문에서 넘어갈 때마다 객체 초기화 
			 JSONObject jo = new JSONObject();
			 jo.put("room_idx", chatList.getRoom_idx());
			 jo.put("userid", chatList.getUserid());
			 jo.put("photo1", chatList.getPhoto1());
		 	//리스트에 출력할 상대방 닉네임 확인
		 if (chatList.getUserid().equals(userid)) {
			 jo.put("senderName", chatList.getH_name());
		 } else {
			 jo.put("senderName", chatList.getUser_name());
		 }
		 
		 	 jo.put("room_name", chatList.getRoom_name());
		 //읽지 않은 chatRoom이 0개일때
		 if (unreadChatId.size() == 0) {
			 jo.put("messageUnread", "");
		 	} else {
		 		//읽지 않은 chatRoomId들과 현재 chatRoomId 대조 후 처리 
				 for (int ele : unreadChatId) {
					 	if (chatList.getC_idx() == ele) {
					 		jo.put("messageUnread", "새 메세지");
					 		break;
					 	} else {
					 		jo.put("messageUnread", "");
					 	}
				 }
			}
		 	ja.put(jo);
		}
		 //Javascript에 parsing 할 수 있도록 JSON Object에 Array를 담아줌
		 JSONObject jsnResult = new JSONObject();
		 jsnResult.put("chatList", ja);
		 //String으로 변환해주면 끝, 프런트<->백엔드 전달은 String으로 이루어지며 형식은 JSON을 선택했음 
		 String result = jsnResult.toString();
		 
		 log.info(result);
		 
		 
		 //View로 result를 return해줌
		 return result;
	}
	
	
	@PostMapping("/chatList/ajax")
	@ResponseBody
	public String chatList(@RequestBody String json) {
		
		JSONObject jsn = new JSONObject(json);
		String userid = (String) jsn.get("userid");
		List<ChatListDTO> chatRoomList = chatRoomService.findByUserId(userid);	 
		JSONArray ja = new JSONArray();

		 for (ChatListDTO chatList : chatRoomList) {
			
			 JSONObject jo = new JSONObject();
			 jo.put("photo1", chatList.getPhoto1());
			 ja.put(jo);
		}
		 JSONObject jsnResult = new JSONObject();
		 jsnResult.put("chatList", ja);
		 String result = jsnResult.toString();
		 System.out.println("chatResult toString: " + result);
		
		 return result;
	}
	
	
}