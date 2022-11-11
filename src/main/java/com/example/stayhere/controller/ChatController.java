package com.example.stayhere.controller;

import java.io.IOException;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.chat.dto.ChatListDTO;
import com.example.stayhere.model.chat.dto.ChatRoomDTO;
import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.service.chat.ChatRoomService;
import com.example.stayhere.service.guest.GuestService;
import com.example.stayhere.service.host.HostService;
import com.example.stayhere.util.Pager;
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
	private GuestService guestService;
	
	@Inject 
	HostService hostService;

	/*
	 * 채팅으로 문의하기 (roomdetail 화면에서 문의하기 버튼 클릭시 이동화면)
	 * @Param ChatRoomDTO (room_idx, room_name, h_userid, h_name, photo1)
	 * @Param Session은 userid 값 체크
	 * @throws Exception
	 */
	@PostMapping("/chat")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute ChatRoomDTO chatRoom)
			throws Exception {

		// detail 화면에서 Chat화면에 전달해줄 parameter
		String userid = (String) session.getAttribute("userid");
		log.info("chatMessage userid : " + userid);
		log.info("parma DTO : " + chatRoom);
		//유저 정보 불러오기
		GuestDTO guest = guestService.view_Guest(userid);
		chatRoom.setUserid(guest.getUserid());
		chatRoom.setUser_name(guest.getName());
		model.addAttribute("guest", guest) ;
		log.info("chatRoomDTO : " + chatRoom); 
		
		// 호스트 프로필 이미지 찾기
		String hostProfile = chatRoomService.findByHostProfile(chatRoom.getH_userid());
		chatRoom.setH_profile(hostProfile);
		
		// 이미 chatRoom이 만들어져있는지 확인
		if (chatRoomService.countByChatId(chatRoom.getRoom_idx(), chatRoom.getUserid()) > 0) {
			log.info("채팅 룸이 만들어 졌으면 실행!!!!!!!!");
			// get ChatRoomInfo
			ChatRoomDTO chatRoomTemp = chatRoomService.findByChatInfo(chatRoom.getRoom_idx(), 
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
	
	
	/*
	 * 프론트에서 메시지 입력시 연결되는 메소드
	 * 소켓연결 후 입력한 데이터 값들이 넘겨 받은 후 
	 * json데이터로 메시지를 반환
	 */
	@MessageMapping("/broadcast")
	public void send(ChatRoomDTO chatRoom) throws IOException {
		log.info("send DTO : " + chatRoom);
		chatRoom.setSendTime(TimeUtils.getCurrentTimeStamp());
		//append message to txtFile
		chatRoomService.appendMessage(chatRoom);
		int c_idx = chatRoom.getC_idx();
		String url = "/user/" + c_idx + "/queue/messages";
		simpMessage.convertAndSend(url, 
				new ChatRoomDTO(chatRoom.getContent(), chatRoom.getSendTime(), 
						chatRoom.getSenderName(), chatRoom.getSenderId())); 
	}
	
	
	/*
	 * chatroom 페이지에서 글을 읽었을때 호출
	 * @Param : c_idx, flag(user or host 구분용)
	 */
	@PostMapping("/chatread/chatroom/ajax")
	public void ajaxChatRoomRead(@RequestBody String json) throws IOException {
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

	
	/*
	 * room_detail페이지에서 열린 chat화면에서 글을 읽으면 호출
	 * @RequestBody : c_idx, userid
	 */
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
	
	
	/*
	 * 채팅 리스트 접속시 호출됨.
	 * 검색 및 페이지 이동시 호출
	 * @RequestParam : page(페이지), keyword(검색어)
	 */
	@GetMapping("/chatlist")
	public ModelAndView getChatList(Model model, HttpSession session, 
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "") String keyword) throws Exception {
		
		//세션값 기준으로 아이디 나누기
		String sessionId = "";
		String userid = (String)session.getAttribute("userid");
		String h_userid = (String)session.getAttribute("h_userid");
		if(userid != null) { sessionId = userid;}
		if(h_userid != null) { sessionId = h_userid;}
				
		int count = chatRoomService.getChatRoomCount(sessionId, keyword);
		int pageScale = 5; //게시물 표시 갯수
		Pager pager = new Pager(pageScale, count, page);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<ChatListDTO> chatlist = chatRoomService.getChatRoomList(start, end, sessionId, keyword);
		GuestDTO g_dto=guestService.view_Guest(userid);
		
		//senderid 적용
		for (ChatListDTO dto : chatlist) {
			String senderId = "";
			if(sessionId.equals(dto.getUserid())) {
				senderId = dto.getH_userid();
			}else {
				senderId = dto.getUserid();
			}
			dto.setSenderId(senderId);
		}
				
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("chatlist", chatlist);
		map.put("pager", pager);
		map.put("count", count);
		mav.addObject("map", map);
		mav.addObject("guest", g_dto);
		mav.setViewName("chat/chat_list");
		return mav;
	}
	
	
	/*
	 * 채팅리스트에서 채팅하기 버튼 클릭시 호출되는 메소드
	 * 채팅 이력 조회 후 데이터값 리턴해줌
	 * @PathVariable : 방번호, 호스트아이디, 게스트아이디
	 */
	@GetMapping("/chatroom/{room_idx}/{h_userid}/{userid}")
	public String getChatRoom(@PathVariable Map<String, String> requestVar,
			Model model) throws IOException {
		String userid = requestVar.get("userid");
		String h_userid = requestVar.get("h_userid");
		int room_idx = Integer.parseInt(requestVar.get("room_idx"));
		//유저 정보 불러와서 데이터 전달
		GuestDTO guest = guestService.view_Guest(userid);
		model.addAttribute("guest", guest);
		//호스트 정보 불러와서 데이터 전달
		HostDTO host = hostService.viewHost(h_userid);
		model.addAttribute("host", host);
							
		//read chatHistory
		ChatRoomDTO chatRoomRead = chatRoomService.findByChatInfo(room_idx, userid);
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
	
	
	/*
	 * 룸디테일 페이지에서 게스트가 채팅버튼 클릭시 호출되는 메소드
	 * ajax통신으로 읽음 여부를 확인한다.
	 * json통신시 한글깨짐을 방지하기 위해  produces="application/text; charset=UTF-8" 선언
	 */
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
	
	
//	/*
//	 * 채팅방에서 읽음 체크 처리... 
//	 * 아직 구현 X..
//	 */
//	@RequestMapping(value="/chatUnreadAlert/ajax", method=RequestMethod.POST, produces="application/text; charset=UTF-8" )
//	@ResponseBody
//	public int chatUnread(@RequestBody String json) {
//		JSONObject jsn = new JSONObject(json);
//		String userid = (String) jsn.get("userid");
//    	int messages = chatRoomService.getUnreadMessages(userid);
//    	
//		return messages;
//	}

	
	/*
	 * 채팅 리스트 페이지에서 새로운 메시지 기능여부를 체크하는 메소드
	 * 새로운 메시지가 있다면 new 메시지 보내는걸 완료했다면 send complete 리턴
	 * 모두 읽었다면 ""빈값으로 리턴함
	 */
	@RequestMapping(value="/chatUnreadMessageInfo/ajax", method=RequestMethod.POST, produces="application/text; charset=UTF-8" )
	@ResponseBody
	public String chatListUnread(@RequestBody String json) throws Exception {
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
			 jo.put("c_idx", chatList.getC_idx());
		 //읽지 않은 chatRoom이 0개일때
		 if (unreadChatId.size() == 0) {
			 jo.put("messageUnread", "");
		 	} else {
		 		//읽지 않은 chatRoomId들과 현재 chatRoomId 대조 후 처리 
				 for (int ele : unreadChatId) {
					 	if (chatList.getC_idx() == ele) {
					 		jo.put("messageUnread", "new message");
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
	
	
}