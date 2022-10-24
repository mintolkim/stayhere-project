<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE-REVIEW</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<!-- <a href="${path}/reviews/list.do">REVIEW</a> -->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<script type="text/javascript">
$(function() {
	$("#btnWrite").click(function(){
		location.href="${path}/reviews/write.do";
	});
});

$(function() {
	$("#btnLogin").click(function(){
		location.href="${path}/guest/login.do";
	});
});
</script>
<style type="text/css">
.reBanner {
	background-image:;
}
</style>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
		<%@ include file="../include/navbar.jsp"%>
		
		<!-- 본문영역-->		
		<header class="py-5 bg-image-full"
			style="background-size : cover; background-image: url('../resources/images/reviewTestImage4.jpg');">
			<div class="text-center position-relative my-5" style="background-color : rgb(255,167,38);">
				<h1 class="text-white fs-3 fw-bolder">리뷰를 작성하여 숙박경험을 공유하세요</h1>
				<button type="button" id="btnLogin">로그인</button>
			</div>
		</header>

		<!-- BestReviews -->
		<section class="container reBest py-5">
			<div class="container px-5">
				<h2 class="fw-bolder fs-5 mb-4">Best Reviews</h2>
				<div class="row gx-5">
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<img class="card-img-top"
								src="../resources/images/reviewTestImage1.jpg" alt="호텔리뷰이미지" />
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">Best</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><div class="h5 card-title mb-3">호텔너무 조아용</div></a>
								<p class="card-text mb-0">(호텔서비스가 너무 좋았다는 내용)</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d"
											alt="사용자프로필이미지" />
										<div class="small">
											<div class="fw-bold">Kelly Rowan</div>
											<div class="text-muted">March 12, 2022 &middot; 6 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<img class="card-img-top"
								src="../resources/images/reviewTestImage2.jpg" alt="호텔리뷰이미지" />
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">Best</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><div class="h5 card-title mb-3">성공적인 여행</div></a>
								<p class="card-text mb-0">(대충 숙소가 좋아 여행이 성공적이라는 내용)</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d"
											alt="사용자프로필이미지" />
										<div class="small">
											<div class="fw-bold">Josiah Barclay</div>
											<div class="text-muted">March 23, 2022 &middot; 4 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<img class="card-img-top"
								src="../resources/images/reviewTestImage3.jpg" alt="호텔리뷰이미지" />
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><div class="h5 card-title mb-3">힐링하다 갑니다</div></a>
								<p class="card-text mb-0">(대충 힐링했다는 내용)</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d"
											alt="사용자프로필이미지" />
										<div class="small">
											<div class="fw-bold">Evelyn Martinez</div>
											<div class="text-muted">April 2, 2022 &middot; 10 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</section>
	</main>

	<div class="container reList px-5 my-5">
		<h2>리뷰게시판</h2>
		${map.count}개의 게시물이 있습니다.
		<table border="1">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>별점</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="row" items="${map.list}">
				<tr>
					<td>${row.review_idx}</td>
					<td>${row.r_title}</td>
					<td>${row.review_star}</td>
					<td>${row.review_content}</td>
					<td>${row.userid}</td>
					<td><fmt:formatDate value="${row.write_date}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${row.view_count}</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" id="btnWrite">글쓰기</button>
	</div>
	</section>
	</main>
	<!--footer  -->
	<%@ include file="../include/footer.jsp"%>

</body>
</html>