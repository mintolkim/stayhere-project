<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>
<script type="text/javascript">

/* 예약 승인 */
function approve(res_idx) {
	var flag=confirm("예약을 승인하시겠습니까?");
	if(flag) {
		location.href="${path}/reservations/approve.do?res_idx="+res_idx;
	}else {
		return;
	}
}

/* 예약 거절 */
function refuse(res_idx) {
	var flag=confirm("예약을 거절하시겠습니까?");
	if(flag) {
		location.href="${path}/reservations/refuse.do?res_idx="+res_idx;
	}else {
		return;
	}
}

/* 입실 완료 처리 */
function checkin(res_idx) {
	var flag=confirm("입실완료 처리하시겠습니까?");
	if(flag) {
		location.href="${path}/reservations/checkin.do?res_idx="+res_idx;
	}else {
		return;
	}
}

/* 퇴실 완료 처리 */
function checkout(res_idx) {
	var flag=confirm("퇴실완료 처리하시겠습니까?");
	if(flag) {
		location.href="${path}/reservations/checkout.do?res_idx="+res_idx;
	}else {
		return;
	}
}

/* 해당 예약 리뷰 확인 */

</script>
<style type="text/css">
a { 
 text-decoration: none;
}
div #tab-bar li a{
 color: black;
 text-decoration: none;
}
div #tab-bar li a:hover {
 color: #ffc107;
 text-decoration: none;
}
#status_1 a, #status_2 a, #status_3 a, #status_4 a, #status_5 a {
 color: black;
 text-decoration: none;
}
#status_1 a:hover, #status_2 a:hover, #status_3 a:hover, #status_4 a:hover, #status_5 a:hover {
 color: #ffc107;
 text-decoration: none;
}
table thead, table tbody {
 text-align: center;
 vertical-align: middle;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
 
	<div class="container" align="center">
		<div class="container">

			<div>					     
			 <span style="text-align: center; font-size: 26px; font-weight: bold; letter-spacing: 10px;">Reservation status</span>
			</div>
			
			<div class="col-lg-12 mt-5">
				<ul class="nav nav-tabs nav-justified" id="tab-bar">
					<li class="nav-item">
						<a class="nav-link active" data-bs-toggle="tab" href="#status_1">예약승인(${h_cntRequest}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_2">취소완료(${h_cntCancel}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_3">예약완료(${h_cntApprove}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_4">입실완료(${h_cntUse}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_5">이용완료(${h_cntCheckout}개)</a>
					</li>
				</ul>

				<div class="tab-content">

				<!-- 예약승인  -->
				<div class="tab-pane active" id="status_1">
					<table class="table table-hover mt-5 mb-5">
					  <thead>
					    <tr class="table-dark">
					      <td>스테이</td>
					      <td>체크인</td>
					      <td>체크아웃</td>
					      <td>예약자명</td>
					      <td>이용인원</td>
					      <td>연락처</td>
					      <td>결제금액</td>
					      <td>예약상태</td>
					      <td>&nbsp;</td>
					    </tr>
					  </thead>
					  <tbody>
					<c:if test="${h_cntRequest==0}">
						<tr><td colspan="9">이용내역이 없습니다.</td></tr>
					</c:if>
					<c:forEach var="res" items="${resList}">	
					  <c:if test="${res.res_idx != null && res.res_state == '예약요청'}">			
					    <tr>
					      <td><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></td>
					      <td>${res.checkin_date}</td>
					      <td>${res.checkout_date}</td>
					      <td>${res.name}</td>
					      <td>${res.res_person}</td>
					      <td>${res.phone}</td>
						  <td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/> </td>
					      <td>${res.res_state}</td>
					      <td><button class="btn btn-outline-warning btn-sm" onclick="approve('${res.res_idx}')" style="font-size: 14px;">승인</button>
							  <button class="btn btn-outline-danger btn-sm" onclick="refuse('${res.res_idx}')" style="font-size: 14px;">거절</button></td>
					    </tr>
					  </c:if>
					</c:forEach>			
					  </tbody>
					</table>
				</div>
				<!-- 예약승인 끝 -->	

				<!-- 예약취소 -->
				<div class="tab-pane fade" id="status_2">
					<table class="table table-hover mt-5 mb-5">
					  <thead>
					    <tr class="table-dark">
					      <td>스테이</td>
					      <td>체크인</td>
					      <td>체크아웃</td>
					      <td>예약자명</td>
					      <td>이용인원</td>
					      <td>연락처</td>
					      <td>결제금액</td>
					      <td>예약상태</td>
					    </tr>
					  </thead>
					  <tbody>
					<c:if test="${h_cntCancel==0}">
						<tr><td colspan="8">이용내역이 없습니다.</td></tr>
					</c:if>
					<c:forEach var="res" items="${resList}">
					  <c:if test="${res.res_idx != null && res.res_state == '취소완료'}">			
					    <tr>
					      <td><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></td>
					      <td>${res.checkin_date}</td>
					      <td>${res.checkout_date}</td>
					      <td>${res.name}</td>
					      <td>${res.res_person}</td>
					      <td>${res.phone}</td>
						  <td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/> </td>
					      <td>${res.res_state}</td>
					    </tr>
					  </c:if>
					</c:forEach>			
					  </tbody>
					</table>
				</div>
				<!-- 예약취소 끝 -->	

	
				<!-- 예약완료 -->
				<div class="tab-pane fade" id="status_3">
					<table class="table table-hover mt-5 mb-5">
					  <thead>
					    <tr class="table-dark">
					      <td>스테이</td>
					      <td>체크인</td>
					      <td>체크아웃</td>
					      <td>예약자명</td>
					      <td>이용인원</td>
					      <td>연락처</td>
					      <td>결제금액</td>
					      <td>예약상태</td>
					      <td>&nbsp;</td>
					    </tr>
					  </thead>
					  <tbody>
					<c:if test="${h_cntApprove==0}">
						<tr><td colspan="9">이용내역이 없습니다.</td></tr>
					</c:if>
					<c:forEach var="res" items="${resList}">
					  <c:if test="${res.res_idx != null && res.res_state == '예약완료'}">			
					    <tr>
					      <td><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></td>
					      <td>${res.checkin_date}</td>
					      <td>${res.checkout_date}</td>
					      <td>${res.name}</td>
					      <td>${res.res_person}</td>
					      <td>${res.phone}</td>
					      <td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/> </td>
					      <td>${res.res_state}</td>
					      <td><button class="btn btn-outline-warning btn-sm" onclick="checkin('${res.res_idx}')" style="font-size: 14px;">체크인</button></td>
					    </tr>
					  </c:if>
					</c:forEach>			
					  </tbody>
					</table>
				</div>
				<!-- 예약완료 끝 -->
				
				<!-- 입실 완료 -->
				<div class="tab-pane fade" id="status_4">
					<table class="table table-hover mt-5 mb-5">
					  <thead>
					    <tr class="table-dark">
					      <td>스테이</td>
					      <td>체크인</td>
					      <td>체크아웃</td>
					      <td>예약자명</td>
					      <td>이용 인원</td>
					      <td>연락처</td>
					      <td>결제금액</td>		
					      <td>예약상태</td>
					      <td>&nbsp;</td>
					    </tr>
					  </thead>
					  <tbody>
						<c:if test="${h_cntUse==0}">
							<tr><td colspan="9">이용내역이 없습니다.</td></tr>
						</c:if>	
					<c:forEach var="res" items="${resList}">
					  <c:if test="${res.res_idx != null && res.res_state == '입실완료'}">			
					    <tr>
					      <td><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></td>
					      <td>${res.checkin_date}</td>
					      <td>${res.checkout_date}</td>
					      <td>${res.name}</td>
					      <td>${res.res_person}</td>
					      <td>${res.phone}</td>
						  <td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/> </td>
					      <td>${res.res_state}</td>
					      <td><button class="btn btn-outline-warning btn-sm" onclick="checkout('${res.res_idx}')" style="font-size: 14px;">체크아웃</button></td>
					    </tr>
					  </c:if>
					</c:forEach>	
					  </tbody>
					</table>
				</div>
				<!-- 입실완료 끝 -->
				
				<!-- 이용 완료 -->
				<div class="tab-pane fade" id="status_5">
					<table class="table table-hover mt-5 mb-5">
					  <thead>
					    <tr class="table-dark">
					      <td>스테이</td>
					      <td>체크인</td>
					      <td>체크아웃</td>
					      <td>예약자명</td>
					      <td>이용 인원</td>
					      <td>연락처</td>
					      <td>결제금액</td>
					      <td>예약상태</td>
					      <td>&nbsp;</td>
					    </tr>
					  </thead>
					  <tbody>
						<c:if test="${h_cntCheckout==0}">
							<tr><td colspan="9">이용내역이 없습니다.</td></tr>
						</c:if>
					<c:forEach var="res" items="${resList}">
					  <c:if test="${res.res_idx != null && res.res_state == '이용완료'}">			
					    <tr>
					      <td><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></td>
					      <td>${res.checkin_date}</td>
					      <td>${res.checkout_date}</td>
					      <td>${res.name}</td>
					      <td>${res.res_person}</td>
					      <td>${res.phone}</td>
						  <td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/> </td>
					      <td>${res.res_state}</td>
					      <td><button class="btn btn-outline-warning btn-sm" onclick="reviewCheck('${res.res_idx}')" style="font-size: 14px;">후기</button></td>
					    </tr>
					  </c:if>
					</c:forEach>			
					  </tbody>
					</table>
				</div>
				<!-- 이용완료 끝 -->
	
				</div>
			</div>
		</div>
	</div>
 
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>

</body>
</body>
</html>