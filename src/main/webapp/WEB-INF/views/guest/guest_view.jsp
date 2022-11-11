<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>
<style type="text/css">
a {
 text-decoration: none;
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
			
		<!-- 프로필 탭 -->
		<%@ include file="../include/profile_tab.jsp" %>			     
			
			<div class="col-lg-9 mt-4 mb-5" align="center">
				
	            <p style="text-align: center; font-size: 20px; font-weight: bold; letter-spacing: 12px;">MY PAGE</p>
				<p style="text-align: center; font-size: 14px; letter-spacing: 8px;">마이페이지</p>

				<p class="fs-4 mt-5">${sessionScope.name}님 반가워요!</p>
				<p class="fs-6">스테이히어와 함께 ${cntCheckout}번의 여행을 했어요.</p>
				
				<span>${guest.email} |</span>
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