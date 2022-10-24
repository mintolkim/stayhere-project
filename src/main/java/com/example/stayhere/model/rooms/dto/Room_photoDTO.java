package com.example.stayhere.model.rooms.dto;

public class Room_photoDTO {
    private int room_idx;
    private String photo;
    private int p_idx;
    private String photo1;
    private String photo2;
    private String photo3;
    private String photo4;
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public String getPhoto1() {
		return photo1;
	}
	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}
	public String getPhoto2() {
		return photo2;
	}
	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}
	public String getPhoto3() {
		return photo3;
	}
	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}
	public String getPhoto4() {
		return photo4;
	}
	public void setPhoto4(String photo4) {
		this.photo4 = photo4;
	}
	@Override
	public String toString() {
		return "Room_photoDTO [room_idx=" + room_idx + ", photo=" + photo + ", p_idx=" + p_idx + ", photo1=" + photo1
				+ ", photo2=" + photo2 + ", photo3=" + photo3 + ", photo4=" + photo4 + "]";
	}
	public Room_photoDTO() {
	}
    
}
