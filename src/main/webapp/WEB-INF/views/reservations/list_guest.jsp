<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>

<script type="text/javascript">

/* 예약 취소 */
function cancel(res_idx) {
	var flag=confirm("예약을 취소하시겠습니까?");
	if(flag) {
		location.href="${path}/reservations/cancel.do?res_idx="+res_idx;
	}else {
		return;
	}
}

/* 예약 정보 팝업 */
function reserveDetail(res_idx) {
	const url = "${path}/reservations/popupDeatil.do?res_idx="+res_idx;
	
	const op = "width=450, height=800, location=no, toolbar=no";
	
	open(url, "예약정보", op)
}

/* 해당 예약 리뷰 작성 페이지 */
function review(room_idx) {
	var flag=confirm("숙박 후기를 작성하시겠습니까?");
	if(flag) {
		location.href="${path}/reviews/write.do?room_idx="+room_idx;
	}else {
		return;
	}
}

</script>
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
.box {
    width: 200px;
    height: 200px; 
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

#profile-tab a:hover {
	color: #ffc107;
	text-decoration: none;
}

div #tab-bar li a:hover {
	color: #ffc107;
	text-decoration: none;
}

.box {
    width: 260px;
    height: 260px; 
    overflow: hidden;
}

.profile {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
}

div #tab-bar li a {
	color: black;
	text-decoration: none;
}

div #tab-bar li a:hover {
	color: #ffc107;
	text-decoration: none;
}

#status_1 a, #status_2 a, #status_3 a, #status_4 a,#status_5 a {
	color: black;
	text-decoration: none;
}
#status_1 a:hover, #status_2 a:hover, #status_3 a:hover, #status_4 a:hover,#status_5 a:hover {
	color: #ffc107;
	text-decoration: none;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0 ">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="col-lg-12 mt-3 mb-5 mb-3 mx-5 px-5" id="features">
	<div class="default_width container-fluid mx-5 px-5" align="center">
		<div class="row" align="center">
			
			<div class="list-group col-sm-2 mt-4 mx-2 px-2" id="profile-tab">
				<div class="container" id="box">
					<img class="profile" src="${path}/imgUpload/${guest.profile_img}" style="border-radius: 50%; width: 230px; height: 230px;">
				</div>
				<br>
				<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">프로필</a>
				<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약내역</a>
				<a href="#" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
				<a href="${path}/wishlist/list.do" class="list-group-item list-group-item-action">관심스테이</a>
				<a href="${path}/qna/scraplist" class="list-group-item list-group-item-action">나의 스크랩</a>
			</div>
						     
			
			<div class="col-sm-8 mt-4 mx-2 mb-5" align="center">
	            <p style="text-align: center; font-size: 26px; font-weight: bold; letter-spacing: 10px;">Reservation status</p>
				<br><br>
				<ul class="nav nav-tabs nav-justified" id="tab-bar">
					<li class="nav-item">
						<a class="nav-link active" data-bs-toggle="tab" href="#status_1">예약요청(${cntRequest}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_2">예약완료(${cntApprove}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_3">취소완료(${cntCancel}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_4">이용중(${cntUse}개)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#status_5">이용완료(${cntCheckout}개)</a>
					</li>
				</ul>

				<div class="tab-content">
	
				<!-- 예약요청 -->
				<div class="tab-pane active" id="status_1">
				<c:if test="${cntRequest==0}">
					<br>
					<span class="fs-5">이용내역이 없습니다.</span>
				</c:if>
				<c:forEach var="res" items="${resList}">
					<c:if test="${res.res_idx != null && res.res_state == '예약요청'}">
						<div class="row my-5 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2">
				            	<a href="${path}/rooms/detail/${res.room_idx}">
				            		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
									  <div class="carousel-indicators">
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
									  </div>
									  <div class="carousel-inner rounded-img">
									    <div class="carousel-item active">
									      <img src="${path}/imgUpload/${res.photo1}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo2}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo3}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo4}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									  </div>
									  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Previous</span>
									  </button>
									  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									    <span class="carousel-control-next-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Next</span>
									  </button>
									</div>
								</a>
				            </div>
				            <div class="col-lg-6 py-4" style="text-align: center;">
				            <span class="fs-4"><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></span>
				            <hr class="gray_line">
				            <i class="bi bi-geo-alt-fill"></i>&nbsp;<span>${res.city} ${res.country}</span><br>
				            <span>${res.checkin_date} ~ ${res.checkout_date}</span><br>
				            <hr class="gray_line">
				            <span class="fs-4">￦<fmt:formatNumber value="${res.total_price}" pattern="#,###,###" /></span><br>
				            <span><fmt:formatDate value="${res.res_date}" pattern="yyyy.MM.dd hh:mm"/></span><br><br>
				            <button class="btn btn-warning btn-lg" onclick="reserveDetail(${res.res_idx})" style="color: white; font-size: 16px;">예약 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;
				            <button class="btn btn-danger btn-lg" onclick="cancel('${res.res_idx}')" style="font-size: 16px;">예약 취소</button>
				    	    </div>
					    </div>
					</c:if>
				</c:forEach>	
				</div>
				<!-- 예약요청 끝 -->		
	
				<!-- 예약 완료 -->
				<div class="tab-pane fade" id="status_2">
				<c:if test="${cntApprove==0}">
					<br>
					<span class="fs-5">이용내역이 없습니다.</span>
				</c:if>
				<c:forEach var="res" items="${resList}">
					<c:if test="${res.res_idx != null && res.res_state == '예약완료'}">
						<div class="row my-5 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2">
				            	<a href="${path}/rooms/detail/${res.room_idx}">
				            		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
									  <div class="carousel-indicators">
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
									  </div>
									  <div class="carousel-inner rounded-img">
									    <div class="carousel-item active">
									      <img src="${path}/imgUpload/${res.photo1}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo2}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo3}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo4}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									  </div>
									  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Previous</span>
									  </button>
									  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									    <span class="carousel-control-next-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Next</span>
									  </button>
									</div>
								</a>
				            </div>
				            
				            
				            <div class="col-lg-6 py-4" style="text-align: center;">
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
				<!-- 예약 완료 끝 -->
	
				<!-- 취소 완료 -->
	 			<div class="tab-pane fade" id="status_3">
				<c:if test="${cntCancel==0}">
					<br>
					<span class="fs-5">이용내역이 없습니다.</span>
				</c:if>
				<c:forEach var="res" items="${resList}">
					 <c:if test="${res.res_idx != null && res.res_state == '취소완료'}">
						<div class="row my-5 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2">
				            	<a href="${path}/rooms/detail/${res.room_idx}">
				            		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
									  <div class="carousel-indicators">
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
									  </div>
									  <div class="carousel-inner rounded-img">
									    <div class="carousel-item active">
									      <img src="${path}/imgUpload/${res.photo1}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo2}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo3}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo4}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									  </div>
									  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Previous</span>
									  </button>
									  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									    <span class="carousel-control-next-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Next</span>
									  </button>
									</div>
								</a>
				            </div>
				            
				            
				            <div class="col-lg-6 py-4" style="text-align: center;">
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
				<!-- 취소 완료 끝 -->
	
				<!-- 이용 중 -->
				<div class="tab-pane fade" id="status_4">
				<c:if test="${cntUse==0}">
					<br>
					<span class="fs-5">이용내역이 없습니다.</span>
				</c:if>
				<c:forEach var="res" items="${resList}">
					 <c:if test="${res.res_idx != null && res.res_state == '입실완료'}">
						<div class="row my-5 mx-1 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2">
				            	<a href="${path}/rooms/detail/${res.room_idx}">
				            		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
									  <div class="carousel-indicators">
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
									  </div>
									  <div class="carousel-inner rounded-img">
									    <div class="carousel-item active">
									      <img src="${path}/imgUpload/${res.photo1}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo2}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo3}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo4}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									  </div>
									  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Previous</span>
									  </button>
									  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									    <span class="carousel-control-next-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Next</span>
									  </button>
									</div>
								</a>
				            </div>
				          
				            <div class="col-lg-6 py-4" style="text-align: center;">
				            <span class="fs-4"><a href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></span>
				            <hr class="gray_line">
				            <i class="bi bi-geo-alt-fill"></i>&nbsp;<span>${res.city} ${res.country}</span><br>
				            <span>${res.checkin_date} ~ ${res.checkout_date}</span><br>
				            <hr class="gray_line">
				            <span class="fs-4">￦<fmt:formatNumber value="${res.total_price}" pattern="#,###,###" /></span><br>
				            <span><fmt:formatDate value="${res.res_date}" pattern="yyyy.MM.dd hh:mm"/></span><br><br>
				            <button class="btn btn-warning btn-lg" onclick="review('${res.room_idx}')" style="color: white; font-size: 16px;">후기작성</button>
				    	    </div>
					    </div>		 
					 </c:if>
				</c:forEach>
				</div>
				<!-- 이용 중 끝 -->
			
				<!-- 이용 완료 -->
				<div class="tab-pane fade" id="status_5">
				<c:if test="${cntCheckout==0}">
					<br>
					<span class="fs-5">이용내역이 없습니다.</span>
				</c:if>
				<c:forEach var="res" items="${resList}">
					 <c:if test="${cntCheckout != 0 && res.res_state == '이용완료'}">
						<div class="row my-5 border border-1" style="border-color: #f2f2f2;">
				            <div class="col-lg-6 col-sm-6 py-2">
				            	<a href="${path}/rooms/detail/${res.room_idx}">
				            		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
									  <div class="carousel-indicators">
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
									    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
									  </div>
									  <div class="carousel-inner rounded-img">
									    <div class="carousel-item active">
									      <img src="${path}/imgUpload/${res.photo1}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo2}" class="d-block w-100" alt="..."  style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo3}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									    <div class="carousel-item">
									      <img src="${path}/imgUpload/${res.photo4}" class="d-block w-100" alt="..." style="width: 500px; height: 350px">
									    </div>
									  </div>
									  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Previous</span>
									  </button>
									  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									    <span class="carousel-control-next-icon" aria-hidden="true"></span>
									    <span class="visually-hidden">Next</span>
									  </button>
									</div>
								</a>
				            </div>
				           
				            <div class="col-lg-6 py-4" style="text-align: center;">
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
				<!-- 이용 완료 끝 -->
				
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
		</section>
	</main>
	<!--footer -->
	<%@ include file="../include/footer.jsp"%>

</body>
</html>