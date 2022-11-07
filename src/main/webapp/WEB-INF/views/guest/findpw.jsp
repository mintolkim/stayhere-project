<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>

<title>STAYHERE</title>
<script>
	$(function(){
		$("#findBtn").click(function(){
			$.ajax({
				url : "${path}/guest/findpw",
				type : "POST",
				data : {
					userid : $("#userid").val(),
					email : $("#email").val()
				},
				success : function(result) {
					alert(result);
				},
			});
		});
	})
</script>
<style type="text/css">

.form-control{
	width: 296px;
	height: 40px;
}

.btn{
	width: 148px;
	height: 40px;
	background-color: #ffcd4a;
	border-color: ffcd4a;
	display: inline-block; 
}

</style>
</head>
<body class="d-flex flex-column">
	<%@ include file="../include/navbar.jsp"%>
	
	<!-- 컨텐츠 수정 영역 start -->
	<div class="d-flex justify-content-center mt-5">
		<div class="w3-container w3-card-4 w3-auto" style="width: 382px;height: 456.3px;">
		<br>
		<div>
		<h2>비밀번호 찾기</h2>
		</div>
		<br>
		<input class="form-control me-2" type="text" placeholder="회원가입한 아이디" name="userid" id="userid">
		<br>
		<input class="form-control me-2" type="password" placeholder="회원가입한 이메일" name="email" id="email"
		required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i">
		<br>
		<p class="w3-center">
		<button type="button" id="findBtn" class="btn mb-0">찾기</button>
		<button type="button" onclick="history.go(-1);" class="btn mb-0">로그인으로</button>
		</p>
		</div>
	</div>	
	
	<!-- 컨텐츠 수정 영역 end -->
	
	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>