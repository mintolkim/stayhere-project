<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NAVBAR</title>
</head>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container px-5">
			<a class="navbar-brand" href="main.jsp">STAYHERE</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="index.html">FIND STAY</a></li>
					<li class="nav-item"><a class="nav-link" href="about.html">PROMOTION</a></li>
					<li class="nav-item"><a class="nav-link" href="contact.html">REVIEW</a></li>
					<li class="nav-item"><a class="nav-link" href="pricing.html">QNA</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">GUEST</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="navbarDropdownBlog">
							<c:choose>
							  <c:when test="${sessionScope.userid == null }">
							   <li><a class="dropdown-item" href="${path}/guest/login.do">로그인</a></li>
							   <li><a class="dropdown-item" href="${path}/guest/join.do">회원가입</a></li>
							  </c:when>
							 <c:otherwise>
							  <li><b class="dropdown-item">${sessionScope.name} 님</b></li>	
						      <li><a class="dropdown-item" href="${path}/guest/guest_view/${sessionScope.userid}">프로필</a></li>
							  <li><a class="dropdown-item" href="blog-home.html">예약정보</a></li>
							  <li><a class="dropdown-item" href="blog-home.html">관심스테이</a></li>
							  <li><a class="dropdown-item" href="${path}/guest/list.do">결제내역</a></li>
							  <li><hr class="dropdown-divider" /></li>
							  <li><a class="dropdown-item" href="${path}/guest/logout.do">로그아웃</a></li>
							 </c:otherwise>
							</c:choose>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdownPortfolio"
						href="#" role="button" data-bs-toggle="dropdown"
						aria-expanded="false">HOST</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="navbarDropdownPortfolio">
							<li><a class="dropdown-item" href="portfolio-overview.html">로그인</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">프로필</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">호스트가입</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">숙소관리</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">숙소등록</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">숙소승인현황</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">예약현황</a></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">매출현황</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="portfolio-overview.html">로그아웃</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
</html>