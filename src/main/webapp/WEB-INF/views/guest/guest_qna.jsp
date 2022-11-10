<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
a {
	text-decoration: none;
}

#profile-tab a {
color: black;
text-decoration: none;
}
#profile-tab a:hover {
color: #ffc107;
text-decoration: none;
}
div #tab-bar li a:hover {
color: #ffc107;
text-decoration: none;
}
.profile {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
}
#profile-tab a:hover {
	color: #ffc107;
	text-decoration: none;
}
</style>
<script type="text/javascript">
//페이지이동
function list(page){
	location.href="${path}/qna/scraplist?curPage="+page;
} 
</script>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0 ">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <section class="col-lg-12 mt-3 mb-5 mb-3 mx-5 px-5" id="features">
	<div class="default_width container-fluid mx-5 px-5" align="center">
		<div class="row" align="center">
			<!-- 왼쪽 프로필영역 -->
			<div class="list-group col-sm-2 mt-4 mx-2 px-2" id="profile-tab">
				<div class="container" id="box">
					<img class="profile" src="${path}/imgUpload/${map.guest.profile_img}" style="border-radius: 50%; width: 230px; height: 230px;">
				</div>
				<br>
				<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">프로필</a>
				<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약내역</a>
				<a href="#" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
				<a href="${path}/wishlist/list.do" class="list-group-item list-group-item-action">관심스테이</a>
				<a href="${path}/qna/scraplist" class="list-group-item list-group-item-action">나의 스크랩</a>
			</div>
			<!--본문 영역  -->
			<div class="col-sm-8 mt-4 mx-2 mb-5" align="center">
	            <p class="mb-5" style="text-align: center; font-size: 26px; font-weight: bold; letter-spacing: 10px;">My Scraplist</p>
	             
	             <!-- 카드 -->
				<div class="row gx-5">
					<c:forEach var="qna" items="${map.list }" varStatus="vs">
						<div class="col-lg-6 mb-4">
							<div class="card h-100 shadow border-0">
								<a class="text-decoration-none link-dark "
									href="${path }/qna/qnaview.do?q_idx=${qna.q_idx}">
									<div class="card-body p-4" align="left">
										<div class="row">
											<div class="col-9" >
												<div class="badge mb-2"
													style="background: #ffeed0; color: black;">${qna.category }</div>
													<c:if test="${qna.passwd != null }">
													 &nbsp;<i class="bi bi-lock-fill"></i>
													</c:if>
											</div>
											<div class="col-3">
												<c:if test="${qna.choose > 0 }">
													<span
														style="font-size: 18px; font-weight: bold; color: #ffca2c;">채택완료</span>
												</c:if>
												<c:if test="${qna.choose == 0 }">
													<span
														style="font-size: 18px; font-weight: bold; color: #8d8d8d;">답변대기</span>
												</c:if>
											</div>
										</div>
										<h5 class="card-title">${qna.subject }</h5>
									</div>
								</a>
								<div class="row">
									<div class="col-7">
										<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
											<div class="d-flex align-items-end justify-content-between">
												<div class="d-flex align-items-center">
												<c:if test="${qna.profile_img == null}">
												 <img class="rounded-circle me-3" 
														src="${path }/resources/images/guest.png"
														style="width: 50px; height: 50px;" />
												</c:if>
												<c:if test="${qna.profile_img != null}">
													<img class="rounded-circle me-3" 
														src="${path }/imgUpload/${qna.profile_img}"
														style="width: 50px; height: 50px;" /></c:if>
													<div class="small" align="left">
														<div class="fw-bold">${qna.userid }</div>
														<div class="text-muted">
															<fmt:formatDate value="${qna.write_date }"
																pattern="yyyy.MM.dd HH:mm:ss" />
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-5 ms-auto">
										<p></p>
										<i class="bi bi-eye"></i> ${qna.view_count } &nbsp; 
										<i class="bi bi-bookmark"></i> ${qna.scrap } &nbsp; 
										<i class="bi bi-hand-thumbs-up"></i> ${qna.likey } &nbsp; 
										<i class="bi bi-chat"></i> ${qna.comment_count }
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<!-- 페이지 네비게이션 -->
					<table id="qnatable" class="mt-3">
						<tr>
							<td colspan="6" align="center"><c:if
									test="${map.pager.curBlock > 1}">
									<a href="#" onclick="list('1')">[처음]</a>
								</c:if> <c:if test="${map.pager.curBlock > 1}">
									<a href="#" onclick="list('${map.pager.prevPage}')"> [이전]</a>
								</c:if> <c:forEach var="num" begin="${map.pager.blockBegin}"
									end="${map.pager.blockEnd}">
									<c:choose>
										<c:when test="${num == map.pager.curPage}">
											<span style="color: #ffcae2; font-weight:bold;">${num}</span>
										</c:when>
										<c:otherwise>
											<a href="#" onclick="list('${num}')">${num}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach> <c:if test="${map.pager.curBlock < map.pager.totBlock}">
									<a href="#" onclick="list('${map.pager.nextPage}')">[다음]</a>
								</c:if> <c:if test="${map.pager.curPage < map.pager.totPage}">
									<a href="#" onclick="list('${map.pager.totPage}')">[끝]</a>
								</c:if></td>
						</tr>
					</table>
				</div>
	        
	        
	        </div>
		</div>
	</div>
	</section>
</main>
</body>
</html>