<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/admin_header.jsp"%>
<script type="text/javascript">
function goblack(user){
	var page = "${map.page}";
	if(confirm(user+"님을 블랙리스트로 설정하시겠습니까?")){
		location.href="${path}/admin/goh_black?h_userid="+user+"&page="+page;
	}else return;
}
function gonormal(user){
	var page = "${map.page}";
	if(confirm(user+"님을 일반회원으로 전환하시겠습니까?")){
		location.href="${path}/admin/goh_normal?h_userid="+user+"&page="+page;
	}else return;
}
function pagination(page){
		location.href = "${path}/admin/host?page="+ page;	
}
//모달 열기
function roomDetail(h_userid,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/roomdetail",
		data:{"h_userid":h_userid},
		success: function(result){
			if(result!=null)
			$("#modal_body"+index).html(result);
		},
		error: function(result){
			alert("오류");
		}
	});
	var y = index;
	$("#modal"+y).fadeIn();
}
$(function(){
	$(".btn-close").click(function(){
		$(".modal").fadeOut();
	});
});
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
           	STAYHERE HOST 총 회원목록</div>
           	</div>
           	<div style="margin-right:40px;"align="right">
           	<c:if test="${map.blackhost != null }">
           	<button type="button" class="btn btn-success" 
           	onclick="location.href='${path}/admin/host'">일반호스트</button>
           	</c:if>
           	<c:if test="${map.hostlist != null }">
           	<button type="button" class="btn btn-danger" 
           	onclick="location.href='${path}/admin/blackhost'">블랙리스트</button>
           	</c:if>
           	<button type="button" class="btn btn-secondary" 
           	onclick="location.href='${path}/admin/guest'">게스트 회원전환</button></div>
			<div class="card mb-4" id="usertable">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> Host DataTable
				</div>
				<div class="card-body">
					<c:if test="${map.hostlist != null }">
						<table id="guesttable" class="table table-striped table-hover"
							style="width: 100%;">
							<thead>
							<tr>
								<!-- 프로필 -->
								<th>USER ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>전화</th>
								<th>연매출(원)</th>
								<th>숙소 개수</th>
								<th>가입일자</th>
								<th colspan="2">블랙리스트</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="host" items="${map.hostlist }" varStatus="vs">
								<tr>
									<td><c:if test="${host.h_profile_img == null}">
											<img class="rounded-circle me-3"
												src="${path }/resources/images/guest.png"
												style="width: 50px; height: 50px;" />
										</c:if> <c:if test="${host.h_profile_img != null}">
											<img class="rounded-circle me-3"
												src="${path}/imgUpload/${host.h_profile_img }"
												style="width: 50px; height: 50px;">
										</c:if>
									${host.h_userid }</td>
									<td>${host.h_name }</td>
									<td>${host.h_email }</td>
									<td>${host.h_phone }</td>
									<td><fmt:formatNumber value="${host.total_price }"
											pattern="##,###" /></td>
									<td>
									<c:if test="${host.room_count == null }">
									${host.room_count }
									</c:if>
									<c:if test="${host.room_count > 0 }">
									<a href="#" onclick="roomDetail('${host.h_userid}','${vs.index }');">
									${host.room_count }</a> </c:if>
									
									<!--모달창  -->
											<div id="modal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">호스트 룸정보</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="modal_body${vs.index }"></div>
													</div>
												</div>
											</div>
											
											</td>
									<td><fmt:formatDate value="${host.h_join_date }"
											pattern="yy년 MM월" /></td>
									<td><c:if test="${host.h_blacklist == 'n' }">
											<button type="button" class="btn btn-success"
												onclick="goblack('${host.h_userid}');">설정</button>
										</c:if> <c:if test="${host.h_blacklist == 'y' }">
											<button type="button" class="btn btn-danger"
												onclick="gonormal('${host.h_userid}');">블랙리스트</button>
										</c:if></td>
								</tr>
							</c:forEach>
								</tbody>
							</table>	
							</c:if>
							<c:if test="${map.blackhost != null }">
							 <table id="guesttable" class="table table-striped table-hover"
							style="width: 100%;">
							<thead>
							<tr>
								<!-- 프로필 -->
								<th>USER ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>전화</th>
								<th>연매출(원)</th>
								<th>숙소 개수</th>
								<th>가입일자</th>
								<th colspan="2">블랙리스트</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="host" items="${map.blackhost }" varStatus="vs">
								<tr>
									<td><c:if test="${host.h_profile_img == null}">
											<img class="rounded-circle me-3"
												src="${path }/resources/images/guest.png"
												style="width: 50px; height: 50px;" />
										</c:if> <c:if test="${host.h_profile_img != null}">
											<img class="rounded-circle me-3"
												src="${path}/imgUpload/${host.h_profile_img }"
												style="width: 50px; height: 50px;">
										</c:if>
									${host.h_userid }</td>
									<td>${host.h_name }</td>
									<td>${host.h_email }</td>
									<td>${host.h_phone }</td>
									<td><fmt:formatNumber value="${host.total_price }"
											pattern="##,###" /></td>
									<td>
									<c:if test="${host.room_count == null }">
									${host.room_count }
									</c:if>
									<c:if test="${host.room_count > 0 }">
									<a href="#" onclick="roomDetail('${host.h_userid}','${vs.index }');">
									${host.room_count }</a> </c:if>
									
									<!--모달창  -->
											<div id="modal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">호스트 룸정보</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="modal_body${vs.index }"></div>
													</div>
												</div>
											</div>
											
									</td>
									<td><fmt:formatDate value="${host.h_join_date }"
											pattern="yy년 MM월" /></td>
									<td><c:if test="${host.h_blacklist == 'n' }">
											<button type="button" class="btn btn-success"
												onclick="goblack('${host.h_userid}');">설정</button>
										</c:if> <c:if test="${host.h_blacklist == 'y' }">
											<button type="button" class="btn btn-danger"
												onclick="gonormal('${host.h_userid}');">블랙리스트</button>
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
