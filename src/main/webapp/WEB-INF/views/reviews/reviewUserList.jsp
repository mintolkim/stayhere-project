<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Insert title here</title>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
  <%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
	<!-- list_guest.jsp에서 넘어온 이용완료(res_state == '이용완료')된 내용조건확인. reviewUserList 에 담아야함 -->
	<!-- list_guest.jsp에 후기작성 버튼있음. 바로 reviewWrite 페이지?, 리뷰리스트 페이지? -->
	<!-- 유저리뷰목록 -->
				<div class="row gx-5">
					<c:forEach var="row" items="${map.list}" begin="0" end="5">
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
	
	</div>
  </section>
 </main>
 <!--footer  -->
 <%@ include file="../include/footer.jsp" %>

</body>
</html>