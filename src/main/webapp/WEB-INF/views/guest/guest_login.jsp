<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>host login</title>
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
}

a {
	text-decoration: none;
}
</style>
<script type="text/javascript">
$(function(){
	$("#login").click(function(){
		var userid=$("#userid").val(); //태그의 value 속성값
		var passwd=$("#passwd").val();
		if(userid==""){
			alert("아이디를 입력하세요.");
			$("#userid").focus(); //입력 포커스 이동
			return; //함수 종료
		}
		if(passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		//폼 데이터를 서버로 제출
		document.form1.action="${path}/guest/loginCheck.do";
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
	
	<form name="form1">
	<h2>GUEST LOGIN</h2>	
	<br>
	<input class="form-control me-2" type="text" placeholder="id" name="userid" id="userid">
	<br>
	<input class="form-control me-2" type="password" placeholder="password" name="passwd" id="passwd">
	<br>
	<input type="button" class="btn btn-primary mb-0" id="login" value="login">
	</form>
	<br>
	<a href="#">Forgot Password?</a> <a href="${path}/guest/join.do">Signup</a>
	<br>
	<br>
	<!-- LoginInterceptor message -->
	<c:if test="${param.msg == 'nologin' }">
	 <script> 
	  alert("로그인이 필요합니다.");
	 </script>
	</c:if>
	
	<c:if test="${message == 'join' }"><div style="color:blue; font-size: 10px;">로그인 하신 후 사용하세요.</div></c:if>
<%-- 	<c:if test="${message == 'error' }"><div style="color:red; font-size: 10px;">아이디 또는 비밀번호가 일치하지 않습니다.</div></c:if>
 --%>	
	<c:if test="${message == 'error' }">
	 <% out.println("<script>"); 
	 out.println("alert('아이디 또는 비밀번호가 일치하지 않습니다.');"); 
	 out.println("</script>");%>
	 </c:if>
	<c:if test="${message == 'logout' }"><div style="color:blue; font-size: 10px;">로그아웃 처리되었습니다.</div></c:if>
		
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>