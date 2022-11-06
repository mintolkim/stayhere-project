<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<c:forEach var="row" items="${map.list}">
	<section class="list-item col-xl-2 col-lg-3 col-md-4 col-sm-6">
		<a href="${path}/rooms/detail/${row.room_idx}" class="text-black text-decoration-none">
			<div class="card border-0" style="width: 100%;">
				<div class="card-img">
					<!-- 이미지가 여러장 일경우 인디케이터 사용 -->
					<div id="indicators-${row.room_idx}" class="carousel slide indicators">
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
								<img src="${path}/imgUpload/${row.photo1}"
									class="d-block w-100 card-img-size" alt="...">
							</div>
							<div class="carousel-item card-img">
								<img src="${path}/imgUpload/${row.photo2}"
									class="d-block w-100 card-img-size" alt="...">
							</div>
							<div class="carousel-item card-img">
								<img src="${path}/imgUpload/${row.photo3}"
									class="d-block w-100 card-img-size" alt="...">
							</div>
							<div class="carousel-item card-img">
								<img src="${path}/imgUpload/${row.photo4}"
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
								<span> <fmt:formatNumber pattern="#.00"	value="${row.review_star}" />
								</span>
							</c:if>
						</p>
					</div>
					<p class="card-text text-secondary mb-0 small">
						침대	${row.beds} · 화장실 ${row.baths}</p>
					<p class="card-text text-secondary mb-0 small">
						<fmt:formatDate pattern="MM월 dd일" value="${row.check_in}" />
						<span>~</span>
						<fmt:formatDate pattern="MM월 dd일" value="${row.check_out}" />
					</p>	
					<p class="card-text mb-0 pt-2">
						<span class="fw-bold">￦ <fmt:formatNumber
								pattern="#,###" value="${row.room_price}" />
						</span> <span>/박</span> <span>·</span> <span> 
						<a href="#2" class="text-secondary">총액 ￦ 
						<fmt:formatNumber	pattern="#,###" value="${row.room_price}" />
						</a>
						</span>
					</p>
				</div>
			</div>
		</a>
	</section>
</c:forEach>