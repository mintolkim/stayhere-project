<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
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
.profile {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
}
#mypage a {
 color: white;
}
#mypage a:hover {
 opacity: 0.5;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="mt-3 mb-5" id="features">
	<div class="container" align="center">
		<div class="row">
			
			<div class="list-group col-lg-3 mt-4" id="profile-tab">
				<div style="width: 80%;">
					<c:if test="${dto.profile_img != null}">			 
						<img class="profile" src="${path}/imgUpload/${dto.profile_img}" style="border-radius: 50%; width: 230px; height: 230px;">
					</c:if>
					
					<c:if test="${dto.profile_img == null}">
						<img class="profile" src="${path}/resources/images/guest.png" style="border-radius: 50%; width: 230px; height: 230px;">
					</c:if>
				
					<br><br>
					<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">마이 페이지</a>
					<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약 정보</a>
					<a href="${path}/reviews/reviewUserList/${sessionScope.userid}" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
					<a href="${path}/chatlist" class="list-group-item list-group-item-action">채팅목록</a>
          <a href="${path}/qna/scraplist"  class="list-group-item list-group-item-action">나의 스크랩</a>
					<a href="${path}/wishlist/list.do" class="list-group-item list-group-item-action">관심 스테이</a>
				</div>
			</div>
						     
			
			<div class="col-lg-9 mt-4 mb-5" align="center">
				
	            <p style="text-align: center; font-size: 20px; font-weight: bold; letter-spacing: 12px;">MY PAGE</p>
				<p style="text-align: center; font-size: 14px; letter-spacing: 8px;">마이페이지</p>

				<p class="fs-4 mt-5">${sessionScope.name}님 반가워요!</p>
				<p class="fs-6">스테이히어와 함께 ${cntCheckout}번의 여행을 했어요.</p>
				
				<span>${dto.email} |</span>
				<span><a href="${path}/guest/update/${sessionScope.userid}">프로필 수정</a></span> 
				<br><br>
				
				<hr class="gray_line mx-auto" style="width: 100%;">
						
				
 				<div class="card text-white">
				  <img src="${path}/resources/images/mypage_bg.jpg" class="card-img" style="opacity: 0.8;">
				  <div class="card-img-overlay">
					<p class="fs-2 fw-bold">
					  Let's Enjoy Your Trip In STAYHERE!
					</p>
					
					<div class="container px-5" id="mypage">
					  <div class="row my-5" style="height: 200px;">
					    <div class="col border border-light mx-5 py-5">
					      <a href="${path}/reservations/list/guest"><i class="bi bi-airplane-engines fs-1"></i>      
						  <p class="fs-5">예약 ${res_count}건</a></p>
					    </div>
					    <div class="col border border-light mx-5 py-5">
					      <a href="${path}/wishlist/list.do"><i class="bi bi-heart fs-1"></i>  
					      <p class="fs-5">관심 ${wish_count}건</a></p>
					    </div>
					  </div>
					  <div class="row my-5" style="height: 200px;">
					    <div class="col border border-light mx-5 py-5">
					      <a href="${path}/reviews/reviewUserList/${sessionScope.userid}"><i class="bi bi-pencil-square fs-1"></i>
					      <p class="fs-5">리뷰 ${wish_count}건</a></p>
					    </div>
					    <div class="col border border-light mx-5 py-5">
					      <a href="${path}/chatlist"><i class="bi bi-chat-dots fs-1"></i>
					      <p class="fs-5">채팅  ${chat_count}건</a></p>
					    </div>
					  </div>
					</div>
				  </div>
				</div>
				
		   </div> 
		</div>
	</div>
	<script type="text/javascript">
		$('.confirmDelete').on('click', function() {
			return confirm('회원 탈퇴는 취소할 수 없습니다. 정말 탈퇴하시겠습니까?');
		});
	</script>
 </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>