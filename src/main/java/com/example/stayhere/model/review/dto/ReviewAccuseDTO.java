package com.example.stayhere.model.review.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewAccuseDTO {
 private int acc_idx;
 private int review_idx;
 private String userid;
 private String writer;
 private String acc_content;
 private String r_title;//review테이블에서 가져옴
 private int room_idx; //review테이블에서 가져옴
}
