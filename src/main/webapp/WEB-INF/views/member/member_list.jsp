<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
</head>
<body>
<h2>회원목록</h2>
<table border="1" style="width: 100%">
 <tr>
  <th>아이디</th>
  <th>이름</th>
  <th>이메일</th>
  <th>가입일시</th>
 </tr>
<c:forEach var="row" items="${list}">
 <tr>
  <td>${row.userid}</td>
  <td>${row.name}</td>
  <td>${row.email}</td>
  <td><fmt:formatDate value="${row.join_date}" 
  pattern="yyyy-MM-dd HH:mm:ss"/> </td>
 </tr>
</c:forEach> 
</table>
</body>
</html>
