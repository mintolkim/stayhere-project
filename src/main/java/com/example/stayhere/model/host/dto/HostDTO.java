package com.example.stayhere.model.host.dto;

import java.util.Date;

public class HostDTO {
	private String h_userid;
	private String h_name;
	private String h_passwd;
	private String h_email;
	private String h_phone;
	private String h_profile_img;
	private Date h_join_date;
	private String h_manager_num;
	public String getH_userid() {
		return h_userid;
	}
	public void setH_userid(String h_userid) {
		this.h_userid = h_userid;
	}
	public String getH_name() {
		return h_name;
	}
	public void setH_name(String h_name) {
		this.h_name = h_name;
	}
	public String getH_passwd() {
		return h_passwd;
	}
	public void setH_passwd(String h_passwd) {
		this.h_passwd = h_passwd;
	}
	public String getH_email() {
		return h_email;
	}
	public void setH_email(String h_email) {
		this.h_email = h_email;
	}
	public String getH_phone() {
		return h_phone;
	}
	public void setH_phone(String h_phone) {
		this.h_phone = h_phone;
	}
	public String getH_profile_img() {
		return h_profile_img;
	}
	public void setH_profile_img(String h_profile_img) {
		this.h_profile_img = h_profile_img;
	}
	public Date getH_join_date() {
		return h_join_date;
	}
	public void setH_join_date(Date h_join_date) {
		this.h_join_date = h_join_date;
	}
	public String getH_manager_num() {
		return h_manager_num;
	}
	public void setH_manager_num(String h_manager_num) {
		this.h_manager_num = h_manager_num;
	}
	public HostDTO() {
	}
	public HostDTO(String h_userid, String h_name, String h_passwd, String h_email, String h_phone,
			String h_profile_img, Date h_join_date, String h_manager_num) {
		this.h_userid = h_userid;
		this.h_name = h_name;
		this.h_passwd = h_passwd;
		this.h_email = h_email;
		this.h_phone = h_phone;
		this.h_profile_img = h_profile_img;
		this.h_join_date = h_join_date;
		this.h_manager_num = h_manager_num;
	}
	@Override
	public String toString() {
		return "HostDTO [h_userid=" + h_userid + ", h_name=" + h_name + ", h_passwd=" + h_passwd + ", h_email="
				+ h_email + ", h_phone=" + h_phone + ", h_profile_img=" + h_profile_img + ", h_join_date=" + h_join_date
				+ ", h_manager_num=" + h_manager_num + "]";
	}
	
}
