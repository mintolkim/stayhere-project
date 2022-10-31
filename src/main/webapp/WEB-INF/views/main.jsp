<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="./include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역 -->

<!-- 그외 페이지별 들어갈 script & css 추가 영역 -->
<title>STAYHERE</title>
</head>
<body class="d-flex flex-column">
<!-- nav_search_bar 는 검색창 노출화면 -->
<%@ include file="./include/nav_search_bar.jsp" %>

<!-- 컨텐츠 수정 영역 start -->
<!-- room-list-->
<div class="room-list-wrap">
	<div class="container-fluid p-4">
		<div id="room-list"
			class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
			<c:forEach var="row" items="${map.list}">
				<section class="list-item col-xl-2 col-lg-3 col-md-4 col-sm-6">
					<a href="${path}/rooms/detail/${row.room_idx}"
						class="text-black text-decoration-none">
						<div class="card border-0" style="width: 100%;">
							<div class="card-img">
								<!-- 이미지가 여러장 일경우 인디케이터 사용 -->
								<div id="indicators-${row.room_idx}" class="carousel slide"
									data-interval="false">
									<div class="carousel-indicators">
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="0" class="active" aria-current="true"
											aria-label="Slide 1"></button>
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="1" aria-label="Slide 2"></button>
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="2" aria-label="Slide 3"></button>
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="3" aria-label="Slide 4"></button>
									</div>
									<div class="img-list carousel-inner rounded-img">
										<div class="carousel-item active">
											<img src="resources/images/${row.photo1}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
										<div class="carousel-item card-img">
											<img src="resources/images/${row.photo2}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
										<div class="carousel-item card-img">
											<img src="resources/images/${row.photo3}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
										<div class="carousel-item card-img">
											<img src="resources/images/${row.photo4}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
									</div>
									<button class="carousel-control-prev" type="button"
										data-bs-target="#indicators-${row.room_idx}" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</button>
									<button class="carousel-control-next" type="button"
										data-bs-target="#indicators-${row.room_idx}"
										data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</button>
								</div>
								<div
									class="btn boder-0 shadow-none card-img-overlay-top text-end">
									<i class="bi-heart text-danger fw-bold fs-5"
										onclick="wishListToggle()"></i>
								</div>
							</div>
							<div class=" card-body">
								<div
									class="d-flex justify-content-between align-items-center py-1 pb-2">
									<p class="room-title fw-bold mb-0 text-truncate">${row.country},
										${row.city}</p>
									<p class="icon mb-0">
										<c:if test="${row.review_count > 0}">
											<i class="bi-star-fill"></i>
											<span> <fmt:formatNumber pattern="#.00"
													value="${row.review_star}" />
											</span>
										</c:if>
									</p>
								</div>
								<p class="card-text text-secondary mb-0 small">침대
									${row.beds} · 화장실 ${row.baths}</p>
								<p class="card-text text-secondary mb-0 small">
									<fmt:formatDate pattern="MM월 dd일" value="${row.check_in}" />
									<span>~</span>
									<fmt:formatDate pattern="MM월 dd일" value="${row.check_out}" />
								<p class="card-text mb-0 pt-2">
									<span class="fw-bold">\ <fmt:formatNumber
											pattern="#,###" value="${row.room_price}" />
									</span> <span>/박</span> <span>·</span> <span> <a href="#2"
										class="text-secondary">총액 \ <fmt:formatNumber
												pattern="#,###" value="${row.room_price * 2}" />
									</a>
									</span>
								</p>
							</div>
						</div>
					</a>
				</section>
			</c:forEach>
		</div>
	</div>
</div>

<script type="text/javascript">
	var curPage = 1;
	var isLoading = false;

	$(window).on("scroll", function() {
		var scrollTop = $(window).scrollTop(); // 위로 스크롤된 길이
		var windowsHeight = $(window).height(); //웹브라우저의 창의 높이
		var documentHeight = $(document).height(); // 문서 전체의 높이
		var isBottom = scrollTop + windowsHeight + 10 >= documentHeight;

		if (isBottom) {
			//만일 현재 마지막 페이지라면
			if (curPage >= '${map.pager.totPage - 1}') {
				return false; //함수종료
			} else {
				isLoading = true; //위에서 종료되지 않으면 로딩상태를 true로 변경
				$("#load").show(); //로딩바 표시
				curPage++; //현재페이지 1증가
				getRoomsList(curPage); //추가로 받을 리스트 ajax처리
			}
		}
	});

	function getRoomsList(curPage) {
		$.ajax({
			type : "get",
			url : "${path}/rooms/addRoomsList",
			data : {
				"curPage" : curPage
			},

			success : function(data) {
// 				console.log(data);
				$("#room-list").append(data);
				$("#load").hide(); //로딩바 숨기기
				isLoading = false;
			}
		});
	}
</script>
<!-- 컨텐츠 수정 영역 end -->

<!-- footer -->
<%@ include file="./include/footer.jsp" %>

</body>
</html>