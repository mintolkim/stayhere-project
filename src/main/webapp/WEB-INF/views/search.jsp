<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path }/resources/css/styles.css" rel="stylesheet" />
<!-- custom css&javascript -->
<link rel="stylesheet" href="${path}/resources/css/common.css">
<script src="${path}/resources/js/common.js"></script>
</head>
<body class="d-flex flex-column h-100">
	<!-- nav -->
	<%@ include file="./include/nav_search_bar.jsp"%>

	<h2>검색 페이지</h2>

	${map.count} 개의 검색결과

	<c:forEach var="row" items="${map.list}">
	룸 이름 : ${row.room_name} <br>
	룸 가격 : ${row.room_price} <br>
		<hr>
	</c:forEach>

	${map.pager.totPage}
	<br>

	<!--footer  -->
	<%@ include file="./include/footer.jsp"%>
</body>
</html>