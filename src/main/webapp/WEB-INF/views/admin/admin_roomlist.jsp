<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/admin_header.jsp"%>
<!-- font awesome 아이콘 -->
<script src="https://kit.fontawesome.com/fdfee59c02.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
//숙소정렬
function selectroom(){
	const select = $("#selectRoom").val();
	location.href = "${path}/admin/rooms?select="+select;	
}
//페이지
function pagination(page){
		location.href = "${path}/admin/rooms?page="+ page;	
}
//숙소상태변경
function changestate(room_idx, tmp){
	var state;
	var page = "${map.page}";
	if(tmp=="reject"){
		state="승인거절";
	}else if(tmp =="confirm"){
		state="승인";
	}else if(tmp=="delete"){
		state="삭제요청";
	}else{
		state="승인대기";
	}
	location.href="${path}/admin/changestate?room_idx="+room_idx+"&state="+state+"&page="+page;
}
//리뷰모달 열기
function reviewDetail(room_idx,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/roomreview",
		data:{"room_idx":room_idx},
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
//예약모달열기
function reservationDetail(room_idx,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/roomreservation",
		data:{"room_idx":room_idx},
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
$(function(){
	$(".btn-close").click(function(){
		$(".modal").fadeOut();
	});
	//프린트
	$("#btn-print").on('click',function(){
		let printHtml = $(".print-page-area").html();
	    let win=window.open('','전체 숙소 Print','height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
		win.document.write("<html><head>");
 		win.document.write("<link rel='stylesheet' type='text/css' href='${path}/resources/css/adminstyles.css'/>");
 		win.document.write('<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />');
 		win.document.write('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">');
 		win.document.write("</head><body>");
		win.document.write(printHtml);
		win.document.write("</body></html>");
		win.document.close();
		win.focus();
		setTimeout(function(){win.print();win.close();}, 1000);
	});
});
</script>
<style type="text/css">
@media print {
    .print-button { display:none;}
}
#roomlist{
margin: 10px 30px;
border-radius: 20px;}
#roomtable{
text-align: center;}
</style>
</head>
<body>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content">
		<div class="card mb-3"  style="margin: 30px;">
          <div class="card-body fw-bolder" >
           	STAYHERE 총 숙소목록</div>
           	</div>
           	<div style="margin-right:40px;"align="right">
           	<!--글 정렬 선택  -->
				<select class="form-select" id="selectRoom" onchange="selectroom()" 
				style="width:200px; display:inline;">
					<option value="q_idx">최신등록순</option>
					<option value="total_price">매출순</option>
					<option value="res_count">예약순</option>
					<option value="review_count">리뷰순</option>
				</select>
				<button type="button" id="btn-print" class="btn btn-secondary">
			<i class="fa-solid fa-print" ></i> 인쇄
			</button>
           	</div>
			<div class="card mb-4 print-page-area" id="roomlist">
				<div class="card-header">
					 Rooms DataTable
				</div>
				<div class="card-body">
				Total rooms : ${map.count } 
						<table id="roomtable" class="table table-striped table-hover"
							style="width: 100%;">
							<thead>
							<tr>
								<!-- 프로필 -->
								<th>숙소명</th>
								<th>호스트</th>
								<th>1박가격</th>
								<th>주소</th>
								<th>연매출(원)</th>
								<th>리뷰 수</th>
								<th>총 예약 수</th>
								<th>평균 별점</th>
								<th>승인상태</th>
								<th>변경</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="room" items="${map.roomlist }" varStatus="vs">
								<c:if test="${room.admin_confirm == '삭제요청'|| room.admin_confirm == '승인거절' }">
								<tr style="background-color: red;">
								</c:if>
								<c:if test="${room.admin_confirm == '승인'|| room.admin_confirm == '승인대기' }">
								<tr>
								</c:if>
									<td align="left" ><c:if test="${room.photo1 == null}">
											<img class="me-3 ms-2"
												src="${path }/resources/images/guest.png"
												style="width: 50px; height: 50px;" />
										</c:if> <c:if test="${room.photo1 != null}">
											<img class="me-3 ms-2"
												src="${path}/imgUpload/${room.photo1 }"
												style="width: 50px; height: 50px;">
										</c:if>
									${room.room_name }</td>
									<td>${room.h_userid }</td>
									<td><fmt:formatNumber value="${room.room_price }"
											pattern="##,###" /></td>
									<td>${room.address1 }${room.address2 }</td>
									<td><fmt:formatNumber value="${room.total_price }"
											pattern="##,###" /></td>
									<td>
									<c:if test="${room.review_count == null }">
									${room.review_count }
									</c:if>
									<c:if test="${room.review_count > 0 }">
									<a href="#" onclick="reviewDetail('${room.room_idx}','${vs.index }');">
									${room.review_count }</a> </c:if>
									
									<!--모달창  -->
											<div id="reviewmodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${room.room_name } 리뷰</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reviewbody${vs.index }"></div>
													</div>
												</div>
											</div>
											</td>
									<td>
									<c:if test="${room.res_count == null }">
									${room.res_count }
									</c:if>
									<c:if test="${room.res_count > 0 }">
									<a href="#" onclick="reservationDetail('${room.room_idx}','${vs.index }');">
									${room.res_count }</a> </c:if>
									
									<!--모달창  -->
											<div id="reservationmodal${vs.index }" class="modal" tabindex="-1">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${room.room_name } 예약내역</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reservationbody${vs.index }"></div>
													</div>
												</div>
											</div>
									</td>
									<td>
									<c:forEach begin="1" end="${room.review_star }" >
									<span style="color: #ffbf00; font-size:18px;">★</span>
									</c:forEach>
									<c:forEach begin="1" end="${5-room.review_star }" >
									<span style="color: #ffbf00; font-size:18px;">☆</span>
									</c:forEach>
									</td>
									<td class="fw-bolder">${room.admin_confirm }</td>
									<td><c:if test="${room.admin_confirm == '승인' }">
											<button type="button" class="btn btn-danger"
												onclick="changestate('${room.room_idx}','delete');">삭제요청</button>
										</c:if> 
										<c:if test="${room.admin_confirm == '승인대기' }">
											<button type="button" class="btn btn-success"
												onclick="changestate('${room.room_idx}','confirm');">승인</button>
												<button type="button" class="btn btn-danger"
												onclick="changestate('${room.room_idx}','reject');">승인거절</button>
										</c:if>
										<c:if test="${room.admin_confirm == '삭제요청' }">
											<button type="button" class="btn btn-success"
												onclick="changestate('${room.room_idx}','confirm');">승인</button>
											<button type="button" class="btn btn-warning"
											onclick="changestate('${room.room_idx}','delay');">승인대기</button>
										</c:if>
										<c:if test="${room.admin_confirm == '승인거절' }">
											<button type="button" class="btn btn-success"
												onclick="changestate('${room.room_idx}','confirm');">승인</button>
											<button type="button" class="btn btn-warning"
											onclick="changestate('${room.room_idx}','delay');">승인대기</button>
										</c:if>
										</td>
								</tr>
							</c:forEach>
								</tbody>
							</table>	
							
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
