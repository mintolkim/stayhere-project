<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Profile</title>
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
    width: 250px;
    height: 250px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>

 
</head>
<body class="d-flex flex-column">
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
		<p class="lead" style="margin-top: 4%;">${sessionScope.h_name}님 반가워요</p>
		${dto.h_email} | <span><a href="${path}/host/edit.do">Profile Edit</a></span>
		</div>
		<hr>
		</div>
		
		<!-- content -->
		<section class="py-5" id="features">
        <div class="container px-5 my-5">
        <div class="row gx-5">
					<!-- 호스트 메뉴 리스트 -->
					<div class="col-lg-4 mb-5 mb-lg-0">
						<%@ include file="../include/host_sidebar.jsp"%>
					</div>
      	  
      	  <!-- 프로필 -->
      	  
        <div class="col-lg-8">
          
          <div class="row gx-5 row-cols-1 row-cols-md-2">
          <div class="col mb-5 h-100" align="left">
          <p class="lead"><b>Host Profile</b></p>
          <label>이메일</label>
    	  <p class="lead">${dto.h_email}</p>
          <label>이름</label>
    	  <p class="lead">${dto.h_name}</p>
          <label>휴대폰</label>
    	  <p class="lead">${dto.h_phone}</p>
          <label>사업자등록번호</label>
    	  <p class="lead">${dto.h_manager_num}</p>
          <label>가입일자</label>
    	  <p class="lead"><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${dto.h_join_date}"/></p>
          </div> 
          <div class="col mb-5 h-100">
	
		  <!-- 프로필  -->	
	      <c:if test="${dto.h_profile_img!=null}">
	      <div class="box" >
		  <img class="profile" src="${path}/imgUpload/${dto.h_profile_img}">
		  </div>
	      </c:if>
	      <c:if test="${dto.h_profile_img==null}">
	      <div class="box" >
		  <img class="profile" src="${path}/resources/images/guest.png">
		  </div>
	      </c:if>
                 
          </div>
          </div>
	      </div>
	      </div>
	      </div>
	  	  </section>
	  	  
			<c:if test="${message == 'noSales' }">
			<script type="text/javascript">
			alert("매출내역이 없습니다.")
			</script>
			</c:if>

	<%-- <%=request.getRealPath("/") %> --%>
	</div>
 </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
