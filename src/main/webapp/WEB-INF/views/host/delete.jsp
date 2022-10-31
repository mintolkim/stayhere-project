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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
button { margin-top: 8%; }
</style>
<script type="text/javascript">
$(function(){ 
	$("#sub").click(function(){
		if($("#check").is(':checked')){
			
		document.form1.action="${path}/host/delete/${sessionScope.h_userid}"
		document.form1.submit();
		
		}else{
			
		alert("동의를 체크하셔야 탈퇴가 가능하십니다.");
		return;
		
		}
		
		
	});
});

</script>

</head>
<body class="d-flex flex-column">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
		
		<div class="row justify-content-center">
		<div class="col-lg-6">
		<h4 class="fw-bolder mb-0" style="color: gray;">[회원탈퇴 약관]</h4>
		<p class="lead" style="margin-top: 10%; font-size: 14px;">
		
		회원탈퇴 신청 전 안내 사항을 확인 해 주세요.<br>
		회원탈퇴를 신청하시면 현재 로그인 된 아이디는 사용하실 수 없습니다.<br>
		회원탈퇴를 하더라도, 서비스 약관 및 개인정보 취급방침 동의하에 따라  일정 기간동안 회원 개인정보를 보관합니다.<br><br>
		 
		 - 회원 정보<br>
		 - 상품 구입 및 대금 결제에 관한 기록<br>
		 - 상품 배송에 관한 기록<br>
		 - 소비자 불만 또는 처리 과정에 관한 기록<br>
		 - 게시판 작성 및 사용후기에 관한 기록<br><br>
		
		※ 상세한 내용은 사이트 내 개인정보 취급방침을 참고 해 주세요.<br><br>
		<b style="color: red;">*</b> 회원 탈퇴 안내 동의 합니다. <input type="checkbox" id="check" value="checked">
		</p>
		<form name="form1">
		<input type="hidden" value="${sessionScope.h_userid}">
		<button type="button" class="btn btn-outline-secondary" id="sub">탈퇴하기</button>
		</form>
		</div>
		</div>
		
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
