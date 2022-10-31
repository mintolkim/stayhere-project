package com.example.stayhere.model.qna.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaLikeyDTO {
	private String userid;
	private int likey_idx;
	private int q_idx;
}
