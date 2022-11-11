<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STAYHERE</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
a {
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
  <!-- 본문영역-->
  <section class="mt-3 mb-5" id="features">
	<div class="container" align="center">
		<div class="row">
			
		<!-- 프로필 탭 -->
		<%@ include file="../include/profile_tab.jsp" %>			     
			
			<!--본문 영역  -->
			<div class="col-lg-9 mt-4 mb-5" align="center">
	            <p style="text-align: center; font-size: 20px; font-weight: bold; letter-spacing: 12px;">My Scraplist</p>
	            <p style="text-align: center; font-size: 14px; letter-spacing: 8px;">나의스크랩</p>
	             
	            <br><br>
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