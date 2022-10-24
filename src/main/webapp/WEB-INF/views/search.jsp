<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp"%>
<%@ include file="./include/nav_search_bar.jsp"%>


<h2> 검색 페이지 </h2>

${map.count} 개의 검색결과

<c:forEach var="row" items="${map.list}">
	룸 이름 : ${row.room_name} <br>
	룸 가격 : ${row.room_price} <br>
	<hr>
</c:forEach>

${map.pager.totPage} <br>

<%@ include file="./include/footer.jsp"%>