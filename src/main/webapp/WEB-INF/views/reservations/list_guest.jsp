<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>

<!-- 구글 폰트  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Montserrat:wght@300&display=swap" rel="stylesheet">
<script type="text/javascript">

/* 예약 취소 */
function cancel(res_idx) {
	var flag=confirm("예약을 취소하시겠습니까?");
	if(flag) {
		location.href="${path}/reservations/cancel?res_idx="+res_idx;
	}else {
		return;
	}
}

/* 예약 정보 팝업 */
function reserveDetail(res_idx) {
	const url = "${path}/reservations/popupDeatil?res_idx="+res_idx;
	
	const op = "width=450, height=800, location=no, toolbar=no";
	
	open(url, "예약정보", op)
}

/* 해당 예약 리뷰 작성 페이지 */

</script>
<style type="text/css">
a { 
 text-decoration: none;
}
* {
 font-family: 'Dongle' !important; sans-serif;
 font-family: 'Montserrat' !important; sans-serif;
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
.box {
    width: 160px;
    height: 160px; 
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
}
div #tab-bar li a{
 color: black;
 text-decoration: none;
}
div #tab-bar li a:hover {
 color: #ffc107;
 text-decoration: none;
}
#status_1 a, #status_2 a, #status_3 a {
	color: black;
	text-decoration: none;
}
#status_1 a:hover, #status_2 a:hover, #status_3 a:hover {
	color: #ffc107;
	text-decoration: none;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="col-lg-12 py-5 mb-3 mx-5 px-5" id="features">
	<div class="default_width container-fluid mx-5" align="center">
		<div class="row" align="center">
			
			<div class="list-group col-sm-2 mt-3 mx-2 px-2" id="profile-tab">
				<div class="container" id="box">
					<%-- ${path}/${guest.profile_img} --%>
					<img class="profile" src="${path}/resources/images/guest.png">
				</div>
				<br>
				<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">프로필</a>
				<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약내역</a>
				<a href="#" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
				<a href="#" class="list-group-item list-group-item-action">관심스테이</a>
			</div>
						     
			
			<div class="col-sm-8 mt-3 mx-2" align="center">
	            <p style="text-align: center; font-size: 26px; font-weight: bold; letter-spacing: 10px;">Reservation status</p>
				<br>
				<ul class="nav nav-tabs nav-justified" id="tab-bar">
					<li class="nav-item">
						<a class="nav-link active" data-bs-toggle="tab" href="#status_1">예약완료</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_2">예약취소</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_3">이용완료</a>
					</li>
				</ul>

				<div class="tab-content">
	
				<!-- 예약요청 -->
				<div class="tab-pane active" id="status_1">
				<c:forEach var="res" items="${resList}">
					<c:if test="${res.res_idx != null && res.res_state == '예약요청'}">
						<div class="row gx-4 gx-lg-5 align-items-center my-5 mx-1 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2"><a href="${path}/rooms/detail/${res.room_idx}"><img class="img-fluid rounded mb-4 mb-lg-0" src="${path}/resources/images/${res.photo1}" width="500px" height="400px" /></a></div>
				            <div class="col-lg-6 col-sm-6 py-2" style="text-align: center;">
				            <span class="fs-4"><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></span>
				            <hr class="gray_line">
				            <i class="bi bi-geo-alt-fill"></i>&nbsp;<span>${res.city} ${res.country}</span><br>
				            <span>${res.checkin_date} ~ ${res.checkout_date}</span><br>
				            <hr class="gray_line">
				            <span class="fs-5">￦<fmt:formatNumber value="${res.total_price}" pattern="#,###,###" /></span><br>
				            <span><fmt:formatDate value="${res.res_date}" pattern="yyyy.MM.dd hh:mm"/></span><br><br>
				            <button class="btn btn-warning btn-lg" onclick="reserveDetail(${res.res_idx})" style="color: white; font-size: 16px;">예약 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;
				            <button class="btn btn-danger btn-lg" onclick="cancel('${res.res_idx}')" style="font-size: 16px;">예약 취소</button>
				    	    </div>
					    </div>
					</c:if>  
				</c:forEach>	
				</div>
				<!-- 예약요청 끝 -->		
	
				<!-- 예약취소 -->
	 			<div class="tab-pane fade" id="status_2">
				<c:forEach var="res" items="${resList}">
					 <c:if test="${res.res_idx != null && res.res_state == '취소완료'}">
						<div class="row gx-4 gx-lg-5 align-items-center my-5 mx-1 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2"><a href="${path}/rooms/detail/${res.room_idx}"><img class="img-fluid rounded mb-4 mb-lg-0" src="${path}/resources/images/${res.photo1}" width="500px" height="400px" /></a></div>
				            <div class="col-lg-6 col-sm-6" style="text-align: center;">
				            <span class="fs-4"><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></span>
				            <hr class="gray_line">
				            <i class="bi bi-geo-alt-fill"></i>&nbsp;<span>${res.city} ${res.country}</span><br>
				            <span>${res.checkin_date} ~ ${res.checkout_date}</span><br>
				            <hr class="gray_line">
				            <span class="fs-4">￦<fmt:formatNumber value="${res.total_price}" pattern="#,###,###" /></span><br>
				            <span><fmt:formatDate value="${res.res_date}" pattern="yyyy.MM.dd hh:mm"/></span><br><br>
				            <button class="btn btn-warning btn-lg" onclick="reserveDetail(${res.res_idx})" style="color: white; font-size: 16px;">예약 정보</button>
				    	    </div>
				    	</div>
					 </c:if>
				</c:forEach>
				</div> 
				<!-- 예약취소 끝 -->
	
				<!-- 예약 완료 -->
				<div class="tab-pane fade" id="status_3">
				<c:forEach var="res" items="${resList}">
					 <c:if test="${res.res_idx != null && res.res_state == '예약완료' || res.res_state == '입실완료' || res.res_state == '이용완료'}">
						<div class="row gx-4 gx-lg-5 align-items-center my-5 mx-1 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2"><a href="${path}/rooms/detail/${res.room_idx}"><img class="img-fluid rounded mb-4 mb-lg-0" src="${path}/resources/images/${res.photo1}" width="500px" height="400px" /></a></div>
				            <div class="col-lg-6 col-sm-6" style="text-align: center;">
				            <span class="fs-4"><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></span>
				            <hr class="gray_line">
				            <i class="bi bi-geo-alt-fill"></i>&nbsp;<span>${res.city} ${res.country}</span><br>
				            <span>${res.checkin_date} ~ ${res.checkout_date}</span><br>
				            <hr class="gray_line">
				            <span class="fs-4">￦<fmt:formatNumber value="${res.total_price}" pattern="#,###,###" /></span><br>
				            <span><fmt:formatDate value="${res.res_date}" pattern="yyyy.MM.dd hh:mm"/></span><br><br>
				            <button class="btn btn-warning btn-lg" onclick="reserveDetail(${res.res_idx})" style="color: white; font-size: 16px;">예약 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;
				            <button class="btn btn-warning btn-lg" onclick="review('${res.room_idx}')" style="color: white; font-size: 16px;">후기작성</button>
				    	    </div>
					    </div>		 
					 </c:if>
				</c:forEach>
				</div>
				<!-- 예약완료 끝 -->
				<!-- (추가구현) 예약내역에 대한 후기는 하나만 작성할 수 있으며 작성이 완료되면 버튼을 비활성화 시킨다. -->
	<%-- 		<c:choose>
				<c:when test="${res.review_idx != 0}">
					<button type="button"
						class="reserveMember_room_btn default_btn medium_text rounded" disabled>후기 작성 완료
					</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="review('${res.room_idx}')" 
						class="reserveMember_room_btn default_btn medium_text rounded">후기 작성
					</button>
				</c:otherwise>
				</c:choose> --%>
				</div>
			</div>
		</div>
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>

</body>
</html>