<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Host Login</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
.form-control{
	width: 296px;
	height: 40px;

}

.btn{
	width: 296px;
	height: 40px;
	background-color: #ffcd4a;
}

a {
	text-decoration: none;
}
</style>
<script>
	$(function(){
		$("#findBtn").click(function(){
			$.ajax({
				url : "${path}/host/findPw",
				type : "POST",
				data : {
					h_userid : $("#h_userid").val(),
					h_email : $("#h_email").val()
				},
				success : function(result) {
					alert(result);
				},
			});
		});
	})
</script>
</head>
<body class="d-flex flex-column">
	<!-- nav_search_bar 는 검색창 노출화면 -->
	<!-- 폴더를 만들어서 적용할시 ../ 으로 변경 -->
<%-- 	<%@ include file="./include/nav_search_bar.jsp"%> --%>
	<%@ include file="../include/navbar.jsp"%>
	
  	<!-- 본문영역-->
 	 <section class="py-5" id="features">
		<div class="container px-5 my-5" align="center">
				<h2>Find Password</h2>
				<br>
				<input class="form-control me-2" type="text" placeholder="id" name="h_userid" id="h_userid">
				<br>
				<input class="form-control me-2" type="text" id="h_email" name="h_email" placeholder="회원가입한 이메일주소를 입력하세요"
				required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i">
				<br>
				<p class="w3-center">
					<input type="button" class="btn btn-warning" id="findBtn" value="찾기" >
					<!-- <button type="button" id="findBtn" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">찾기</button>
						 <button type="button" onclick="history.go(-1);" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">로그인으로</button>
					 -->
		</div>
	</section>		
	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>