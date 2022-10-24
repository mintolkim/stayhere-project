<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
		<div>
		 <table class="table table-striped">
		   <tr><h2 style="text-align: center;">회원 목록</h2></tr>
		   <hr>
		   <tr>
		    <th>아이디</th>
		    <th>이름</th>
		    <th>이메일</th>
		    <th>연락처</th>		    
		    <th>가입일자</th>
		   </tr>

		  <c:forEach var="row" items="${list}">
		   <tr>
		    <td>${row.userid}</td>
		    <td>${row.name}</td>
		    <td>${row.email}</td>
		    <td>${row.phone}</td>
		    <td>${row.join_date}</td>		    		    		    		    
		   </tr>
		   </c:forEach>

		 </table>
		</div>
		
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>