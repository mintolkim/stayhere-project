package com.example.stayhere.model.chat.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatRoomDTO {
	
	private int c_idx; // 채팅룸번호
	private int room_idx; //룸번호
	private String h_userid ; //호스트 아이디
	private String userid ; //게스트 아이디
	private String filename; //저장 파일이름
	private Date create_date; //생성시간
	private String h_name; //호스트 이름
	private String user_name; //게스트 이름
	private int chat_read_user;     
	private int chat_read_host;
	//임의생성
	private String content; //채팅내용
	private String sendTime; //작성시간
	private String senderName; //작성자이름
	private String senderId; //작성자아이디
	private String room_name; //룸이름
	private String photo1;
	
	
	public ChatRoomDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public ChatRoomDTO(int c_idx, int room_idx, String h_userid, String userid, String filename, Date create_date,
			String h_name, String user_name, int chat_read_user, int chat_read_host) {
		this.c_idx = c_idx;
		this.room_idx = room_idx;
		this.h_userid = h_userid;
		this.userid = userid;
		this.filename = filename;
		this.create_date = create_date;
		this.h_name = h_name;
		this.user_name = user_name;
		this.chat_read_user = chat_read_user;
		this.chat_read_host = chat_read_host;
	}
	
	public ChatRoomDTO(String content, String sendTime, String senderName, String senderId) {
		this.content = content;
		this.sendTime = sendTime;
		this.senderName = senderName;
		this.senderId = senderId;
	}
	

}
