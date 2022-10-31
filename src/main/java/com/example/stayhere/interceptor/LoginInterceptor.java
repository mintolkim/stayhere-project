package com.example.stayhere.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	//메인액션이 실행되기 전 항상 실행됨
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
	//세션객체 생성
	HttpSession session=request.getSession();
	//게스트, 호스트 둘다 로그인이 안되어 있으면
	if(session.getAttribute("userid")==null&&session.getAttribute("h_userid")==null) {
		response.sendRedirect(request.getContextPath()+"/guest/login.do?msg=nologin");
		return false; //메인 액션으로 가지 않음
	}else {
		return true;//메인액션으로 이동시킴
		}
	}

//메인액션이 실행 된 후(추상메소드로써 오버라이딩만 한것이고 인터셉터는 메인액션 전에만 실행된다)
@Override
public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
		ModelAndView modelAndView) throws Exception {
}
}
