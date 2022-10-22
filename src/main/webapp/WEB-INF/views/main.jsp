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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path }/resources/css/styles.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
  <header>
	<jsp:include page="navbar.jsp"></jsp:include>
  </header>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
		
	 <!-- 요기 안에서 코드작성해주시면 됩니다..! -->
		
	</div>
  </section>
 </main>
 <!--footer  -->
 <footer>
  <jsp:include page="footer.jsp"></jsp:include>
 </footer>
</body>
</html>