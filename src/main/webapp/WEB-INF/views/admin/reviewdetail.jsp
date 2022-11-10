<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STAYHERE</title>
<%@ include file="../include/header.jsp"%>
</head>
<body>
	<!-- 리뷰목록 -->
	<div class="row gx-5">
		<c:forEach var="row" items="${list}">
			<div class="mb-4">
				<div class="card h-100 shadow border-0">
					<div class="card-body p-4">
						<div class="badge bg-primary bg-gradient rounded-pill mb-2">
							${row.room_name}</div>
						<a class="text-decoration-none link-dark stretched-link"
							href="${path}/rooms/detail/${row.room_idx}">
							<h5 class="card-title mb-3">${row.r_title}</h5>
						</a>
						<c:forEach begin="1" end="${row.review_star }">
							<span>⭐</span>
						</c:forEach>
						<p class="card-text mb-0">${row.review_content}</p>
					</div>
					<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
						<div class="d-flex align-items-end justify-content-between">
							<div class="d-flex align-items-center">
								<c:if test="${row.profile_img == null }">
									<img class="rounded-circle me-3"
										style="width: 50px; height: 50px;"
										src="${path }/resources/images/guest.png">
								</c:if>
								<c:if test="${row.profile_img != null }">
									<img class="rounded-circle me-3"
										style="width: 50px; height: 50px;"
										src="${path }/imgUpload/${row.profile_img }" alt="프로필이미지" />
								</c:if>
								<div class="small" align="left">
									<div class="fw-bold">${row.userid}</div>
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
</body>
</html>