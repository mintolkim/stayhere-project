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
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
<script type="text/javascript">
$(function(){
	$("#btnSave").click(function(){
		confirm("프로필을 수정하시겠습니까?")
		if(confirm){
			/* document.form1.action="${path}/guest/edit/${sessionScope.userid}"; */
			//document.form1.userid.value=${dto.userid};
			document.form1.action="${path}/guest/edit.do";
			document.form1.submit();
		}
	});
});
</script>
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
                      <form name="form1" method="post">
                       <div>
                        <input type="hidden" id = "userid" value ="${dto.userid}"/>
                        <input type="hidden" id = "profile_img" value =" "/> 
                        <input type="hidden" class="form-control" id="passwd" name="passwd" value ="${dto.passwd}" placeholder="4~12, 영어대소문자, 숫자가능" required="required">                       
                        <label>아이디</label>
			      	    <p class="lead" id="useridTemp">${dto.userid}</p>
			      	   </div>		      	   
			      	   <div>
                        <label>이메일</label>
			      	    <p class="lead"><input name="email" id="email" value="${dto.email}"></p>
			      	   </div>
			      	   <div>
                        <label>이름</label>
			      	    <p class="lead"><input name="name" id="name" value="${dto.name}"></p>
			      	   </div>
			      	   <div>
                        <label>휴대폰</label>
			      	    <p class="lead"><input name="phone" id="phone" value="${dto.phone}"></p>
			      	   </div>
                       <div >
                        <input class="btn btn-primary mb-0" type="button" value="수정하기" id="btnSave">
                       </div>
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