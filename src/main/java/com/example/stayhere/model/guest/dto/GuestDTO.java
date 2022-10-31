package com.example.stayhere.model.guest.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class GuestDTO {
    private String userid; //게스트 아이디
    private String name; //게스트 이름
    private String passwd; //게스트 비밀번호
    private String email; //게스트 이메일
    private String phone; //게스트 연락처
    private String profile_img; //게스트 프로필사진
    private Date join_date; //게스트 가입일자

	public GuestDTO(String userid, String name, String passwd, String email, String phone, String profile_img,
			Date join_date) {
		this.userid = userid;
		this.name = name;
		this.passwd = passwd;
		this.email = email;
		this.phone = phone;
		this.profile_img = profile_img;
		this.join_date = join_date;
	}

	public GuestDTO(String userid, String name, String passwd) {
		this.userid = userid;
		this.name = name;
		this.passwd = passwd;
	}
	
	public GuestDTO(String userid, String name, String email, String phone, String profile_img) {
		this.userid = userid;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.profile_img = profile_img;
	}
	
	public GuestDTO(String userid, String name, String passwd, String email) {
		this.userid = userid;
		this.name = name;
		this.passwd = passwd;
		this.email = email;
	}
	
	
	public GuestDTO() {
	}

}
