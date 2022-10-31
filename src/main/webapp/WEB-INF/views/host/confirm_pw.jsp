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
<script type="text/javascript">
$(function(){
	$("#login").click(function(){
		var h_passwd=$("#h_passwd").val();
		if(h_passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#h_passwd").focus();
			return;
		}
		
		document.form1.action="${path}/host/confirmPw.do";
		document.form1.submit();
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
	<form name="form1" id="form1">
    <input type="hidden" id="h_userid" name="h_userid" value="${sessionScope.h_userid}">
	<h2>Confirm Password</h2>	
	<br>
	<br>
	<input class="form-control me-2" type="password" placeholder="password" name="h_passwd" id="h_passwd">
	<br>
	<input type="button" class="btn btn-warning" id="login" onclick="confirm_pw()" value="확인">
	</form>
	<br>
	<a href="#">Forgot Password?</a>
	<br>
	<br>
		 <c:if test="${message == 'confirmPw' }">
		 <script type="text/javascript">
		 alert("비밀번호가 맞지 않습니다")
		 </script>
		 </c:if>
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>