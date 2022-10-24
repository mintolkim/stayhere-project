<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Join</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
.display-5 {margin-bottom: 20px;}
.btn {margin-top: 20px;}
.col-lg-6 {margin-bottom: 3%;}
a { text-decoration: none;}
.lead a { color: black; font-size: 16px;}
.lead a:hover { color: black; font-size: 16px; font-weight: 640;}
label {
	font-size: 11px;
}
.col .lead b { font-size: 25px;}
.box {
    width: 150px;
    height: 150px; 
    border-radius: 30%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
<!-- <script type="text/javascript">
$(function(){
	$("#edit").click(function(){
		confirm("프로필 수정하시겠습니까?")
		if(confirm){
			
		}
	});
});
</script> -->
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5" align="center">
		
		<!-- Hi! -->
		
		<div class="row justify-content-center">
		<div class="col-lg-6">
		<h2 class="fw-bolder mb-0">M　Y　P　A　G　E</h2>
		<p class="lead" style="margin-top: 4%;">${sessionScope.name}님 반가워요</p>
		${dto.email} | <span><a href="${path}/guest/update/${sessionScope.userid}">프로필 수정</a></span>
		</div>
		<hr>
		</div>

		<!-- content -->
		<section class="py-5" id="features">
          <div class="container px-5 my-5">
          <div class="row gx-5">
          <div class="col-lg-4 mb-5 mb-lg-0">
      	  <p class="lead" ><a href="${path}/guest/update/${sessionScope.userid}">회원정보 수정</a></p>
      	  <p class="lead" ><a>예약정보</a></p>
      	  <p class="lead" ><a>관심스테이</a></p>
      	  <p class="lead" ><a>결제내역</a></p>
      	  </div>
      	  
      	  <!-- 프로필 -->
      	  
          <div class="col-lg-8">
              <div class="row gx-5 row-cols-1 row-cols-md-2">
                  <div class="col mb-5 h-100" align="left">
                      <p class="lead"><b>프로필</b></p>
                      <label>이메일</label>
			      	  <p class="lead">${dto.email}</p>
                      <label>이름</label>
			      	  <p class="lead">${dto.name}</p>
                      <label>휴대폰</label>
			      	  <p class="lead">${dto.phone}</p>
                      <label>가입일자</label>
			      	  <p class="lead"><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${dto.join_date}"/></p>
                  </div>
                	  <div class="col mb-5 h-100">
                  		<form action="${path}/guest/guest_img.do" method="post" enctype="multipart/form-data">
                  	 	 <div class="box">
                  	 	 	<c:if test="${dto.profile_img != null}">
                  	 	 		<div class="idPhoto">
                  	 	 			<img class="profile" src="${path}/${dto.profile_img}" width="200" height="200">
                  	 	 		</div>
                  	 	 	</c:if>
                  	 	 	<!-- 로그인유저의 idPhoto가없다면 디폴트 이미지 노출 -->
                  	 	 	<c:if test="${dto.profile_img == null}">
                  	 	 		<div class="idPhotoDefault">
                  	 	 			<img src="${path}/resources/guest_profile/default_profile.png">
                  	 	 		</div>
                  	 	 	</c:if>
                  		 </div>
			      	  	<p class="lead" style="margin-top: 3%; font-size: 13px;"><input type="file" name="file"></p>
			      	  	<button type="submit">프로필사진 변경하기</button>
                	   </form>
                 	 </div>
              </div>
          </div>
          </div>
          </div>
         </section>
		

	
	</div>
 </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>