<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE-REVIEW</title>
<script type="text/javascript">
	$(function() {
		$("#btnWrite").click(function() {
			location.href = "${path}/reviews/write.do";
		});
	});
	function list(page){
		location.href = "${path}/reviews/list.do?curPage="+page;
	}
	
</script>
<style type="text/css">
.reBanner {
	background-image:;
}

.text-center {
	width: 600px;
	height: 100px;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -300px;
	position: relative;
}

.text-center button {
	margin-top: 10px;
	font-weight: bold;
}
#reviewGuestImage{
	width: 3em;
	height: 3em;
}
</style>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
		<%@ include file="../include/navbar.jsp"%>

		<!-- 리뷰작성 안내 -->
		<header class="py-5 bg-image-full"
			style="background-image: url('../resources/images/reviewTopImage.jpg')">
			<div class="text-center my-5">
				<h1 class="text-white fs-3 fw-bolder">리뷰를 작성하여 숙박경험을 공유하세요</h1>
				<button type="button" class="btn btn-warning" id="btnWrite">리뷰작성</button>
			</div>
		</header>

		<!-- 베스트 리뷰 -->
		<section class="container reBest py-5">
			<div class="container px-5">
				<h2 class="fw-bolder fs-5 mb-4">Best Reviews</h2>
				<div class="row gx-5">
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<img class="card-img-top"
								src="../resources/images/bestReviewImage1.jpg" alt="호텔리뷰이미지" />
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
											<div class="text-muted">2022-10-20 18:20 &middot; 조회수
												60</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<img class="card-img-top"
								src="../resources/images/bestReviewImage2.jpg" alt="호텔리뷰이미지" />
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
											<div class="text-muted">2022-10-20 18:20 &middot; 조회수
												50</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<img class="card-img-top"
								src="../resources/images/bestReviewImage3.jpg" alt="호텔리뷰이미지" />
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
											<div class="text-muted">2022-10-20 18:20 &middot; 조회수
												48</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</section>

		<!-- 리뷰목록 화면 -->
		<section class="py-1" id="features">
			<div class="container px-5 my-5">
				<p> ⭐&nbsp;숙소후기 <b>${map.count}</b>개</p>
				
				<!--리뷰검색 -->
				<!--<input type="text" name="search" placeholder="Search.."> -->
				
				<!-- 포토리뷰와 일반리뷰 구분 -->
				<!-- <div class="btn-group justify-content-center" role="group" aria-label="Basic radio toggle button group">
				<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
					<label class="btn btn-outline-primary" for="btnradio1">포토리뷰</label>
				<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off"> 
					<label class="btn btn-outline-primary" for="btnradio2">일반리뷰</label> 
			</div> -->
			
				<!-- 정렬 -->
				<div class="dropdown" align="right">
					<button class="btn btn-secondary dropdown-toggle" type="button" 
						data-bs-toggle="dropdown" aria-expanded="false"></button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">최신순</a></li>
						<li><a class="dropdown-item" href="#">별점순</a></li>
						<li><a class="dropdown-item" href="#">조회순</a></li>
					</ul>
				</div>

				<!-- 리뷰목록 -->
				<div class="row gx-5">
					<!-- 페이징처리예정 -->
					<c:forEach var="row" items="${map.list}">
						<div class="col-lg-6 mb-4">
							<div class="card h-100 shadow border-0">
								<div class="card-body p-4">
									<div class="badge bg-primary bg-gradient rounded-pill mb-2">
										${row.room_name}
									</div>
									<a class="text-decoration-none link-dark stretched-link" href="${path}/rooms/detail/${row.room_idx}">
										<h5 class="card-title mb-3">${row.r_title}</h5>
									</a>
									<!-- 별점 이미지 확인. 숙소에 대한 별점입력 후 수정 -->
									<span>⭐${row.review_star}/5</span>
									<p class="card-text mb-0">${row.review_content}</p>
								</div>
								<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
									<div class="d-flex align-items-end justify-content-between">
										<div class="d-flex align-items-center">
											<img class="rounded-circle me-3" id="reviewGuestImage"
												src="../resources/images/guest.png" alt="프로필이미지" />
											<div class="small">
												<div class="fw-bold">${row.name}</div>
												<div class="text-muted">
													<fmt:formatDate value="${row.write_date}" 
														pattern="yyyy-MM-dd HH:mm" /> 
														&middot; 조회수 ${row.view_count}
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				
				<!-- 페이징처리--> 
					<div aria-label="Page navigation" align="center">
						<ul class="pagination">
							<c:if test="${map.pager.prevPage > 0}">
								<li class="page-item">
									<a class="page-link" href="#"	aria-label="Previous"> 
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach var="num" begin="${map.pager.blockBegin}" 
								end="${map.pager.blockEnd}">
								<c:choose>
									<c:when test="${num == map.pager.curPage}">
										<li class="page-item active" aria-current="page">
											<a class="page-link">${num}</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a class="page-link" href="#">${num}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${map.pager.nextPage < map.pager.totPage}">
							<li class="page-item">
								<a class="page-link" href="#"	aria-label="Next"> 
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
							</c:if>
						</ul>
					</div> 

			</div>
			
		</section>
		
		<!--footer  -->
		<%@ include file="../include/footer.jsp"%>
	</main>
</body>
</html>