package com.example.stayhere.model.wishlist.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishlistDTO {
    private int wish_num; //위시리스트 번호, wishlist
    private String userid; //게스트 아이디, wishlist, guest
    private String name;//게스트 이름, guest
    private int room_idx; //방번호, wishlist, rooms
    private String room_name; //rooms
    private Date wish_date; //wishlist
}
