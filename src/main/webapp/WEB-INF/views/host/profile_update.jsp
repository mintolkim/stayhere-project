<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Update</title>
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
.content {
  width : 296px;
  top: 50%;
  left: 50%;
  text-align: left;
}
.btn{
	width: 296px;
	height: 40px;
	background-color: #ffcd4a;
}
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
label {
	font-size: 10px;
}
.lead{
	margin-top: 1%;
}
</style>
<script type="text/javascript">
$(function(){
	$("#update").click(function(){
		var h_passwd=$("#h_passwd").val();
		var h_passwd2=$("#h_passwd2").val();
		
/* 		var h_email=$("#h_email").val();
		var h_phone=$("#h_phone").val();
		var h_manager_num=$("#h_manager_num").val(); */
		
		
		if(h_passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#h_passwd").focus();
			return;
		}
		if(h_passwd2==""){
			alert("다시 한번 비밀번호 입력해주세요");
			$("#h_passwd2").focus();
			return;
		}
		if(h_passwd!=h_passwd2){
			alert("비밀번호가 맞지 않습니다.");
			$("#h_passwd").focus();
			return;
		}
		alert("프로필이 변경되었습니다.");
		document.form1.action="${path}/host/updateImg";
		document.form1.submit();

	}); 
});

function fileCheck(el) { 
    if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
    alert('이미지 파일만 업로드 가능합니다.'); 
    el.value = ''; 
    el.focus(); 
   }
 }
</script>
</head>
<body class="d-flex flex-column">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5" align="center">
		
		<form name="form1" method="post" autocomplete="off" enctype="multipart/form-data" >
		<input type="hidden" value="${sessionScope.h_userid}">
		<h2><b>Profile Edit</b></h2>
		<br>
		
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
		<!-- 파일첨부 -->
		<label class="lead" for="file" style="font-size: 16px;">프로필 사진 변경</label> 
		<input type="file" id="file" name="file" style="display: none;" onchange="fileCheck(this)">
		<input type="hidden" name="h_profile_img" value="${dto.h_profile_img}">

		<script> 
	    $("#file").change(function(){
	     if(this.files && this.files[0]) {
	      var reader = new FileReader;
	      reader.onload = function(data) {
	       $(".box img").attr("src", data.target.result);
	      }
	      reader.readAsDataURL(this.files[0]);
	     }
	    });
	    </script>
		
		<br>
		<br>
		<br>
		<div class="content">
		<label>비밀번호 8글자 이상 대소문자포함</label>
		<input class="form-control me-2" type="password" placeholder="Password" name="h_passwd" id="h_passwd" value="${dto.h_passwd}">
		<br>
		<br>
		<input class="form-control me-2" type="password" placeholder="Confirm Password" name="h_passwd2" id="h_passwd2" value="${dto.h_passwd}">
		<br>
		<label>이메일</label>
		<input class="form-control me-2" type="text" value="${dto.h_email}" name="h_email" id="h_email">
		<br>
		<label>휴대폰</label>
		<input class="form-control me-2" type="text" value="${dto.h_phone}" name="h_phone" id="h_phone">
		<br>
		<label>사업자등록번호</label>
		<input class="form-control me-2" type="text" value="${dto.h_manager_num}" name="h_manager_num" id="h_manager_num">
		<br>
		<br>
		<input type="button" class="btn btn-warning" id="update" value="변경하기">
		</div>

		</form>
		
		
		</div>
       </section>

	<%-- <%=request.getRealPath("/") %> --%>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>