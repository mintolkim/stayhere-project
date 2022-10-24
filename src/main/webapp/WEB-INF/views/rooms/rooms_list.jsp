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
<link href="${path }/resources/css/styles.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
		
	 <!-- 숙소 리스트의 제목 예시 -->
	   <a href="${path}/rooms/detail/1">test숙소1</a> <br>
	   <a href="${path}/rooms/detail/2">test숙소2</a> <br>
	   <a href="${path}/rooms/detail/3">test숙소3</a> <br>
	   <a href="${path}/reservations/test.do">결제 테스트</a>
	   
	</div>
  </section>
 </main>
 <!-- footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>