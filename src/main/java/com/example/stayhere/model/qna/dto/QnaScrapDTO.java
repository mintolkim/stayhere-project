package com.example.stayhere.model.qna.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaScrapDTO {
	private String userid;
	private int scrap_idx;
	private int q_idx;
}
