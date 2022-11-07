<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/admin_header.jsp"%>
<script type="text/javascript">
$(function(){
	$(".btn-close").click(function(){
		$(".modal").fadeOut();
	});
});
function goblack(user){
	if(confirm(user+"님을 블랙리스트로 설정하시겠습니까?")){
		location.href="${path}/admin/goblack?userid="+user;
	}else return;
}
function gonormal(user){
	if(confirm(user+"님을 일반회원으로 전환하시겠습니까?")){
		location.href="${path}/admin/gonormal?userid="+user;
	}else return;
}
function pagination(page){
		location.href = "${path}/admin/guest?page="+ page;	
}
//모달 열기
function reviewDetail(userid,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/reviewdetail",
		data:{"userid":userid},
		success: function(result){
			if(result!=null)
			$("#reviewbody"+index).html(result);
		},
		error: function(result){
			alert("오류");
		}
	});
	var y = index;
	$("#reviewmodal"+y).fadeIn();
}
//모달 열기
function accuseDetail(userid,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/accusedetail",
		data:{"userid":userid},
		success: function(result){
			if(result!=null)
			$("#accusebody"+index).html(result);
		},
		error: function(result){
			alert("오류");
		}
	});
	var y = index;
	$("#accusemodal"+y).fadeIn();
}
//모달 열기
function reservationDetail(userid,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/reservationdetail",
		data:{"userid":userid},
		success: function(result){
			if(result!=null)
			$("#reservationbody"+index).html(result);
		},
		error: function(result){
			alert("오류");
		}
	});
	var y = index;
	$("#reservationmodal"+y).fadeIn();
}		
</script>
<style type="text/css">
#usertable{
margin: 10px 30px;
border-radius: 20px;}
#guesttable{
text-align: center;}
</style>
</head>
<body>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content">
		<div class="card mb-3"  style="margin: 30px;">
          <div class="card-body fw-bolder" >
           	STAYHERE GUEST 총 회원목록</div>
           	</div>
           	<div style="margin-right:40px;"align="right">
           	<c:if test="${map.blackguest != null }">
           	<button type="button" class="btn btn-success" 
           	onclick="location.href='${path}/admin/guest'">일반회원</button>
           	</c:if>
           	<c:if test="${map.guestlist != null }">
           	<button type="button" class="btn btn-danger" 
           	onclick="location.href='${path}/admin/blackguest'">블랙리스트</button>
           	</c:if>
           	<button type="button" class="btn btn-secondary" 
           	onclick="location.href='${path}/admin/host'">호스트 회원전환</button></div>
			<div class="card mb-4" id="usertable">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> Guest DataTable
				</div>
				<div class="card-body">
					<c:if test="${map.guestlist != null }">
						<table id="guesttable" class="table table-striped table-hover"
							style="width: 100%;">
							<thead>
							<tr>
								<!-- 프로필 -->
								<th>USER ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>전화</th>
								<th>연간 구매액(원)</th>
								<th>작성리뷰</th>
								<th>신고여부</th>
								<th>가입일자</th>
								<th colspan="2">블랙리스트</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="guest" items="${map.guestlist }" varStatus="vs">
								<tr>
									<td><c:if test="${guest.profile_img == null}">
											<img class="rounded-circle me-3"
												src="${path }/resources/images/guest.png"
												style="width: 50px; height: 50px;" />
										</c:if> <c:if test="${guest.profile_img != null}">
											<img class="rounded-circle me-3"
												src="${path}/imgUpload/${guest.profile_img }"
												style="width: 50px; height: 50px;">
										</c:if>
									${guest.userid }</td>
									<td>${guest.name }</td>
									<td>${guest.email }</td>
									<td>${guest.phone }</td>
									<td>
									<c:if test="${guest.total_price > 0 }">
									<a href="#" onclick="reservationDetail('${guest.userid}','${vs.index }');">
									<fmt:formatNumber value="${guest.total_price }"
											pattern="##,###" /></a></c:if>
									<c:if test="${guest.total_price == 0 }">
									<fmt:formatNumber value="${guest.total_price }"
											pattern="##,###" />
									</c:if>
									<!--예약내역 모달창  -->
											<div id="reservationmodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${guest.userid } 구매내역</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reservationbody${vs.index }"></div>
													</div>
												</div>
											</div>		
									</td>
									<td>
									<c:if test="${guest.review_count > 0 }">
									<a href="#" onclick="reviewDetail('${guest.userid}','${vs.index }');">
									${guest.review_count }</a></c:if>
									<c:if test="${guest.review_count == 0 }">
									${guest.review_count }
									</c:if>
									<!--리뷰글 모달창  -->
											<div id="reviewmodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">게스트 리뷰글</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reviewbody${vs.index }"></div>
													</div>
												</div>
											</div>
									</td>
									<td>
									<c:if test="${guest.accuse_count > 0 }">
									<a href="#" onclick="accuseDetail('${guest.userid}','${vs.index }');">
									${guest.accuse_count }</a></c:if>
									<c:if test="${guest.accuse_count == 0 }">
									${guest.accuse_count }
									</c:if>
									<!--신고글 모달창  -->
											<div id="accusemodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${guest.userid } 신고글</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="accusebody${vs.index }"></div>
													</div>
												</div>
											</div>
									</td>
									<td><fmt:formatDate value="${guest.join_date }"
											pattern="yy년 MM월" /></td>
									<td><c:if test="${guest.blacklist == 'n' }">
											<button type="button" class="btn btn-success"
												onclick="goblack('${guest.userid}');">설정</button>
										</c:if> <c:if test="${guest.blacklist == 'y' }">
											<button type="button" class="btn btn-danger"
												onclick="gonormal('${guest.userid}');">블랙리스트</button>
										</c:if></td>
								</tr>
							</c:forEach>
								</tbody>
							</table>
							</c:if>
							<c:if test="${map.blackguest != null }">
							 <table id="guesttable" class="table table-striped table-hover"
							style="width: 100%;">
							<thead>
							<tr>
								<!-- 프로필 -->
								<th>USER ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>전화</th>
								<th>연간 구매액(원)</th>
								<th>리뷰 글수</th>
								<th>신고이력</th>
								<th>가입일자</th>
								<th colspan="2">블랙리스트</th>
							</tr>
							</thead>
							<tbody>
							
							<!--블랙리스트 버튼 클릭하면  -->
							
							<c:forEach var="guest" items="${map.blackguest }" varStatus="vs">
								<tr>
									<td><c:if test="${guest.profile_img == null}">
											<img class="rounded-circle me-3"
												src="${path }/resources/images/guest.png"
												style="width: 50px; height: 50px;" />
										</c:if> <c:if test="${guest.profile_img != null}">
											<img class="rounded-circle me-3"
												src="${path}/imgUpload/${guest.profile_img }"
												style="width: 50px; height: 50px;">
										</c:if>
									${guest.userid }</td>
									<td>${guest.name }</td>
									<td>${guest.email }</td>
									<td>${guest.phone }</td>
									<td>
									<c:if test="${guest.total_price > 0 }">
									<a href="#" onclick="reservationDetail('${guest.userid}','${vs.index }');">
									<fmt:formatNumber value="${guest.total_price }"
											pattern="##,###" /></a></c:if>
									<c:if test="${guest.total_price == 0 }">
									<fmt:formatNumber value="${guest.total_price }"
											pattern="##,###" />
									</c:if>
									<!--예약내역 모달창  -->
											<div id="reservationmodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${guest.userid } 구매내역</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reservationbody${vs.index }"></div>
													</div>
												</div>
											</div>		
									</td>
									<td>
									<c:if test="${guest.review_count > 0 }">
									<a href="#" onclick="reviewDetail('${guest.userid}','${vs.index }');">
									${guest.review_count }</a></c:if>
									<c:if test="${guest.review_count == 0 }">
									${guest.review_count }
									</c:if>
									<!--리뷰글 모달창  -->
											<div id="reviewmodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">게스트 리뷰글</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reviewbody${vs.index }"></div>
													</div>
												</div>
											</div>
									</td>
									<td>
									<c:if test="${guest.accuse_count > 0 }">
									<a href="#" onclick="accuseDetail('${guest.userid}','${vs.index }');">
									${guest.accuse_count }</a></c:if>
									<c:if test="${guest.accuse_count == 0 }">
									${guest.accuse_count }
									</c:if>
									<!--신고글모달창  -->
											<div id="accusemodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${guest.userid } 신고글</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="accusebody${vs.index }"></div>
													</div>
												</div>
											</div>
									</td>
									<td><fmt:formatDate value="${guest.join_date }"
											pattern="yy년 MM월" /></td>
									<td><c:if test="${guest.blacklist == 'n' }">
											<button type="button" class="btn btn-success"
												onclick="goblack('${guest.userid}');">설정</button>
										</c:if> <c:if test="${guest.blacklist == 'y' }">
											<button type="button" class="btn btn-danger"
												onclick="gonormal('${guest.userid}');">블랙리스트</button>
										</c:if></td>
								</tr>
							</c:forEach>
								</tbody>
							</table>
							</c:if>	
							<!-- 페이지네이션 -->
						<nav class="d-flex justify-content-center my-2"
							aria-label="Search results pages">
							<ul class="pagination">
								<c:choose>
									<c:when test="${map.pager.curPage > 1}">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Previous"
											onclick="pagination('${map.pager.prevPage}')"> <span
												aria-hidden="true">&laquo;</span>
										</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item disabled"><a class="page-link"
											href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a></li>
									</c:otherwise>
								</c:choose>
								<c:forEach var="num" begin="${map.pager.blockBegin}"
									end="${map.pager.blockEnd}">
									<c:choose>
										<c:when test="${num == map.pager.curPage}">
											<li class="page-item active" aria-current="page"><a
												class="page-link">${num}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="#"
												onclick="pagination('${num}')">${num}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${map.pager.curPage < map.pager.totPage}">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Next"
											onclick="pagination('${map.pager.nextPage}')"> <span
												aria-hidden="true">&raquo;</span>
										</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item disabled"><a class="page-link"
											href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
						<!-- 페이지 네이션 끝 -->	
								
						
					
					</div>
				  </div>
					<%@ include file="../include/footer.jsp"%>
				</div>
			</div></body>
</html>
