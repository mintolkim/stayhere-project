package com.example.stayhere.service.admin;

import java.util.List;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.host.dto.HostDTO;
import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.model.review.dto.ReviewAccuseDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.rooms.dto.RoomsDTO;

public interface AdminService {

	public List<GuestDTO> getguest(int start, int end);//게스트 목록조회
	public int guestcount();//게스트 수
	public void goblack(String userid);//블랙리스트로 전환
	public void gonormal(String userid);//일반회원 전환
	public int hostcount();//호스트 회원수
	public List<HostDTO> gethost(int start, int end);//호스트목록
	public void goh_normal(String h_userid);//일반호스트 전환
	public void goh_black(String h_userid);//블랙호스트 전환
	public List<GuestDTO> getblackguest(int start, int end);//블랙회원만
	public int blackguestcount();//블랙회원수
	public int blackhostcount();//블랙호스트수
	public List<HostDTO> getblackhost(int start, int end);//블랙호스트만
	public List<RoomsDTO> getroom(String h_userid);//호스트 숙소목록
	public List<ReviewDTO> getreview(String userid);//게스트 리뷰글 불러오기
	public List<ReviewAccuseDTO> getaccuse(String userid);//게스트 받은신고 불러오기
	public List<ReservationsDTO> getreservation(String userid);//게스트 구매이력 불러오기
	public int roomscount(String today);//숙소갯수구하기
	public List<RoomsDTO> getrooms(int start, int end, String select);//모든 숙소 불러오기
	public List<ReviewDTO> roomreview(int room_idx);//룸리뷰 불러오기
	public List<ReservationsDTO> roomreservation(int room_idx);//룸예약정보 불러오기
	public void changestate(int room_idx, String state);//숙소상태변경
	public List<RoomsDTO> getconfirm();//승인숙소불러오기
	public List<RoomsDTO> getdelay();//승인대기숙소불러오기
	public List<RoomsDTO> getreject();//승인거절숙소불러오기
	public int getThismonth(String today);//이번달 매출
	public int getThisyear(String today);//이번년도 매출
	public int getmonthguest(String today);//이번달 신규 회원
	public List<RoomsDTO> getpopular(String today);//이번달 인기숙소
	public List<QnaDTO> getqnalist();//qna답변대기목록
}
