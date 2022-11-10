<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>
<script type="text/javascript">
$(function() {
	let selection = "${map.select}";
	$("#selectReview").val(selection).prop("selected", true);
});
//작성
$(function() {
	$("#btnWrite").click(function() {
		var flag=confirm("'이용완료'된 숙박내역을 확인해주세요.");
		if(flag) {
			location.href="${path}/reservations/list/guest"
		}else {
			return;
		}
	});
});
//페이지 이동
function list(page) {
	location.href = "${path}/reviews/list.do?curPage=" + page;
}

</script>
<style type="text/css">
.reBanner {
	background-size: 100% 100%;
	height: 288px;
}

.topNotice{
	background-color: rgba( 255, 255, 255, 0.5 );
	height: 190px;
	max-width: 600px;
	width: 100%;
	margin: 0px auto;
}
.text-center button {
	margin-top: 10px;
	font-weight: bold;
}
#reviewGuestImage {
	width: 3em;
	height: 3em;
}
.bestCard {
	display: inline-block;
}
.topNotice h1{
	color: rgb(18,31,102);
}
#starlist span{
	font-size: 22px;
}
</style>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
		<%@ include file="../include/navbar.jsp"%>

		<!-- 리뷰작성 안내 -->
		<header class="py-5 bg-image-full reBanner"
			style="background-image: url('${path}/resources/images/reviewHeadimg.jpg')">
			<div class="text-center py-5 topNotice">
				<!-- 호스트 로그인의 경우 리뷰작성 버튼 숨김-->
				<c:choose>
					<c:when test="${sessionScope.h_userid != null}">
						<h1 class="fs-3 fw-bolder">리뷰게시판에서 숙박후기를 확인하세요</h1>
					</c:when>
					<c:otherwise>
						<h1 class="fs-3 fw-bolder">리뷰를 작성하여 숙박경험을 공유하세요</h1>
						<button type="button" class="btn btn-warning" id="btnWrite">리뷰작성</button>
					</c:otherwise>
				</c:choose>
			</div>
		</header>

		<!-- 리뷰목록 화면 -->
		<section class="py-1" id="features">
			<div class="container px-5 my-5">
				<p>
					⭐&nbsp;숙소후기 <b>${map.view_count}</b>개
				</p>

				<!-- 리뷰목록 -->
				<div class="row gx-5 mainContents">
					<!-- 페이징처리예정 -->
					<c:forEach var="row" items="${map.list}" varStatus="vs">
						<c:choose>
							<c:when test="${row.show == 'y'}">
						<div class="col-lg-6 mb-4">
							<div class="card h-100 shadow border-0">
								<div class="card-body p-4">
									
									<div class="card-header">
										<!-- 리뷰제목 -->
										<a class="text-decoration-none link-dark stretched-link"
											href="${path}/reviews/detail.do?review_idx=${row.review_idx}">
											<h3 class="card-title">${row.room_name}</h3>
										</a>
										<!-- 별점 -->
										<div class="header-star">
											<span id="starlist">
												<c:if test="${row.review_star == 1}">⭐<span>☆☆☆☆</span></c:if> 
												<c:if test="${row.review_star == 2}">⭐⭐<span>☆☆☆</span></c:if> 
												<c:if test="${row.review_star == 3}">⭐⭐⭐<span>☆☆</span></c:if> 
												<c:if test="${row.review_star == 4}">⭐⭐⭐⭐<span>☆</span></c:if> 
												<c:if test="${row.review_star == 5}">⭐⭐⭐⭐⭐</c:if>
											</span>
										</div>
									</div>

									<div class="card-body p-4 reviewContent">
										<h4 class="card-title mb-3">${row.r_title}</h4>
										<p class="card-text mb-0">${row.review_content}</p>
									</div>

									<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
										<div class="d-flex align-items-end justify-content-between">
											<div class="d-flex align-items-center col-9">
												<div class="rounded-circle me-3" id="reviewGuestImage">
													<!-- 로그인 유저 프로필 이미지 -->
													<c:if test="${row.profile_img != null}">
														<div class="profile_img">
															<img class="profile img-fluid rounded-circle"
																src="${path}/imgUpload/${row.profile_img}">
														</div>
													</c:if>
													<!-- 로그인유저의 profile_img가없다면 디폴트 이미지 노출 -->
													<c:if test="${row.profile_img == null}">
														<div class="profile_imgDefault">
															<img class="profile img-fluid rounded-circle"
																src="${path}/resources/images/guest.png">
														</div>
													</c:if>
												</div>
												<div class="small">
													<div class="fw-bold">${row.name}</div>
													<div class="text-muted">
														<fmt:formatDate value="${row.write_date}"
															pattern="yyyy-MM-dd HH:mm" />
													</div>
												</div>
											</div>
											<div class="col-5 ms-auto"><p><p>
													<i class="bi bi-eye"> ${row.view_count}</i>&nbsp; &nbsp;
													<i class="bi bi-chat-right-dots"> ${row.comment_count}</i>
											</div>
										</div>
									</div>
								</div>
								<!-- 카드부분 -->
							</div>
						</div>
						</c:when>
						</c:choose>
					</c:forEach>
					<!-- 페이지 네비게이션 -->
					<div id="qnatable" class="mt-3" align="center">
						<ul class="pagination">
							<c:if	test="${map.pager.curBlock > 1}">
								<li class="page-item">
									<a class="page-link" href="#" aria-label="Previous" onclick="list('1')">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if> 
							<c:if test="${map.pager.curBlock > 1}">
								<a href="#" onclick="list('${map.pager.prevPage}')"> [이전]</a>
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
											<a class="page-link" href="#" onclick="list('${num}')">${num}</a>
										</li>
									</c:otherwise>
								</c:choose>
								</c:forEach> 
								<c:if test="${map.pager.curBlock < map.pager.totBlock}">
									<li class="page-item">
									<a class="page-link" href="#" aria-label="page" onclick="list('${map.pager.nextPage}')">[다음]</a>
									</li>
								</c:if> 
								<c:if test="${map.pager.curPage < map.pager.totPage}">
									<li>
										<a class="page-link" href="#" aria-label="Next" onclick="list('${map.pager.totPage}')">
											<span aria-hidden="true">&raquo;</span>
										</a>
									<li>
								</c:if>
						</ul>
					</div>
				</div>

			</div>

		</section>

		<!--footer  -->
		<%@ include file="../include/footer.jsp"%>
	</main>
</body>
</html>
