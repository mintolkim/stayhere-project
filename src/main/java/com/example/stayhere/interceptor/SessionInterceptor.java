package com.example.stayhere.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


//인터셉터는 bean으로 등록하지 않고, HandlerInterceptorAdapter라는 추상클래스는 상속 받는다
public class SessionInterceptor extends HandlerInterceptorAdapter {

	//로깅
	private static final Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);
	
	//Ctrl + Space한수 preHandle을 치면 추상메소드를 오버라이딩 할 수 있다.
	//선처리
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String PATH = request.getContextPath();
		String guest = (String) session.getAttribute("userid");
		String host = (String) session.getAttribute("h_userid");
		
		//게스트 값이 있거나 호스트가 널이면
		if(guest != null && host == null) {
			response.sendRedirect(PATH+"/check?msg=hasSessionGuest");
			return false;
		}
		
		//호스트 값이 있거나 게스트 값이 널이면
		if(host != null && guest == null) {
			response.sendRedirect(PATH+"/check?msg=hasSessionHost");
			return false;
		}
		
		return true;
		
	}
	
	//Ctrl + Space한수 postHandle을 치면 추상메소드를 오버라이딩 할 수 있다.
	//후처리
	@Override
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		
	}
	
}
