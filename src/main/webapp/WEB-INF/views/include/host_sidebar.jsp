<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="host_profile_url" value="/stayhere/host/profile/${sessionScope.h_userid}"/>
	
	<p class="lead">
		<a href="${path}/host/profile/${sessionScope.h_userid}" class="menu-item <c:if test="${not fn:contains(url, host_profile_url)}">no</c:if>selected">프로필</a>
	</p>
	<p class="lead">
		<a href="${path}/host/edit.do" class="menu-item <c:if test="${not fn:contains(url, '/stayhere/host/checkPw')}">no</c:if>selected" >회원정보수정</a>
	</p>
	<p class="lead">
		<a href="${path}/chatlist" class="menu-item <c:if test="${not fn:contains(url, '/stayhere/chatlist')}">no</c:if>selected" >채팅목록</a>
	</p>
	<p class="lead">
		<a href="${path}/host/rooms_List.do" class="menu-item <c:if test="${not fn:contains(url, '/stayhere/host/rooms_List.do')}">no</c:if>selected">숙소관리</a>
	</p>
	<p class="lead">
		<a href="${path}/rooms/write.do" class="menu-item <c:if test="${not fn:contains(url, '/stayhere/rooms/write.do')}">no</c:if>selected">숙소등록</a>
	</p>
	<p class="lead">
		<a href="${path}/host/rooms_Confirm.do" class="menu-item <c:if test="${not fn:contains(url, '/stayhere/host/rooms_Confirm.do')}">no</c:if>selected">숙소승인현황</a>
	</p>
	<p class="lead">
		<a href="${path}/reservations/list/host" class="menu-item noselected">예약현황</a>
	</p>
	<p class="lead">
		<a href="${path}/host/rooms_Sales/${sessionScope.h_userid}" class="menu-item noselected">매출현황</a>
	</p>
	<p class="lead">
		<a href="${path}/host/delete.do" class="menu-item noselected">회원 탈퇴</a>
	</p>

