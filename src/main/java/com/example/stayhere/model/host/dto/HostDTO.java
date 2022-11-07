package com.example.stayhere.model.host.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Setter
@Getter
@ToString
public class HostDTO {
	private String h_userid;
	private String h_name;
	private String h_passwd;
	private String h_email;
	private String h_phone;
	private String h_profile_img;
	private Date h_join_date;
	private String h_manager_num;
	private String h_blacklist;
	private int total_price;//연매출
	private int room_count;//룸갯수
	
}
