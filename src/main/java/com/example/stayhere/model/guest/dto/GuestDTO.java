package com.example.stayhere.model.guest.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class GuestDTO {
    private String userid; //게스트 아이디
    private String name; //게스트 이름
    private String passwd; //게스트 비밀번호
    private String email; //게스트 이메일
    private String phone; //게스트 연락처
    private String profile_img; //게스트 프로필사진
    private Date join_date; //게스트 가입일자
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	@Override
	public String toString() {
		return "GuestDTO [userid=" + userid + ", name=" + name + ", passwd=" + passwd + ", email=" + email + ", phone="
				+ phone + ", profile_img=" + profile_img + ", join_date=" + join_date + "]";
	}
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
