package com.example.stayhere.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("payment/*")
public class PaymentController {
	
	//결제 완료 페이지
	//Payment테이블에 결제고유번호,예약번호,회원아이디,결제상태,결제날짜 저장
	@RequestMapping("pay_result.do")
	public String pay_result() {
		//단순 페이지 로딩
		return "payment/pay_result";
	}
}
