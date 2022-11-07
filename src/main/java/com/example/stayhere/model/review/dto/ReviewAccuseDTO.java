package com.example.stayhere.model.review.dto;
s
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
 private String r_title;//review테이블에서 가져옴
 private int room_idx; //review테이블에서 가져옴

}
