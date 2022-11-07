package com.example.stayhere.model.review.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewAccuseDTO {
	private int acc_idx; //신고idx
	private int review_idx; //리뷰idx(review테이블)
    private String userid; //신고하는사람(guest테이블)
    private String writer; //리뷰작성자(신고받은사람)
    private String acc_content; //신고내용
}
