package com.example.stayhere.model.reservations.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservedDTO {
	private int room_idx;
    private String re_date;

    public ReservedDTO() {}

	public ReservedDTO(int room_idx, String re_date) {
		this.room_idx = room_idx;
		this.re_date = re_date;
	}
    
}
