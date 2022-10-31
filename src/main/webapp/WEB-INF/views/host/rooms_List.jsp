<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Host Room Write</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
.display-5 {margin-bottom: 20px;}
.btn { 
	margin-top: 20px;
}
.col-lg-6 {margin-bottom: 3%;}
a { text-decoration: none; color: black;}
.lead a { color: black; font-size: 16px;}
a:hover { color: black; font-size: 16px; font-weight: 640;}
label { 
	font-size: 13px;
}
.col .lead b { font-size: 25px;}
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
 		<p class="lead">${sessionScope.h_name} 님의 숙소</p>
		<div class="col-lg-6" style="margin-bottom: 5%;">
		<h2 class="fw-bolder mb-0">H　O　S　T　R　O　O　M</h2>
		</div>
		<hr>
		</div>

		<!-- content -->
		<section class="py-5" id="features">
        <div class="container px-5 my-5">
        <div class="row gx-5">
        <div class="col-lg-4 mb-5 mb-lg-0">
          <p class="lead" ><a href="${path}/host/profile/${sessionScope.h_userid}">프로필</a></p>
    	  <p class="lead" ><a href="${path}/host/edit.do">회원정보수정</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_List/${sessionScope.h_userid}"><b style="font-weight: 700;">숙소관리</b></a></p>
    	  <p class="lead" ><a href="${path}/rooms/write.do">숙소등록</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Confirm/${sessionScope.h_userid}">숙소승인현황</a></p>
    	  <p class="lead" ><a>예약현황</a></p>
    	  <p class="lead" ><a>매출현황</a></p>
 	      <p class="lead" ><a href="${path}/host/delete.do">회원 탈퇴</a></p>
   	     </div>
      	  <!-- 목록 -->
 		  <div class="col-lg-8">
          
          <c:forEach var="row" items="${map.list}">
          <c:if test="${row.admin_confirm == '승인'}">
          <div align="right">
          <a href="${path}/rooms/edit/${row.room_idx}" style="font-size: 13px; font-weight: 650; color: #767bc5;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
  		  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
		  </svg></a>
          </div>
          
          <div class="card">
		  <a href="${path}/rooms/detail/${row.room_idx}">
          <div class="row no-gutters">
          <div class="col-4">
          <img src="${path}/${row.photo1}" style="height: 190px; width: 200px;" class="card-img" />
          </div>
          <div class="col-8">
          <div class="card-body">
          <div style="margin-bottom: 1%;">
          <b class="card-title lead" style="font-size: 20px; font-weight: 650">${row.room_name}</b><br>
          </div>
          <b class="lead" style="font-size: 15px;">${row.address1} ${row.address2}</b><br>
          <b class="lead" style="font-size: 15px;">타입: ${row.room_type}</b><br>
		  <b class="lead" style="font-size: 15px;">가격 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${row.room_price}" /> 원</b>
          <b class="lead" style="font-size: 15px;">,1인당 추가 가격 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${row.add_people}" /> 원</b><br>
          <b class="lead" style="font-size: 15px;">침대 : ${row.beds}개,  화장실 : ${row.baths}개</b><br>
          </div>
          </div>
          </div>
          </div>
          </a>
	      <br>
          </c:if>
		  </c:forEach>
		 	
		 	
<%--        <c:if test="${row.admin_confirm}">
           	<div style="margin-top: 25%; margin-left: 25%; margin-right: 25%;">
           	<p class="lead">등록된 숙소가 없습니다.</p>
           	</div>
            </c:if> --%>
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