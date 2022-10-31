<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>
<script type="text/javascript">
$(function(){
	$("#passwordcheck").click(function(){
	var q_idx = $("#q_idx").val();
	var h_userid = $("#h_userid").val();
	if(h_userid == 'admin'){
		location.href="${path}/qna/qnadetail.do?q_idx="+q_idx;
	}else{
		var passwd = $("#passwd").val();
		if(passwd == ''){
			alert("비밀번호를 입력하세요"); return;
		}
		document.form1.submit();	
	}
	});
});
</script>
<style type="text/css">
#passwdform{
padding: 50px;
border: 1px solid #000;
border-radius: 15px;
}
#passwdch{
text-align: center;
width: 100%;
}
#passwdch td{
padding: 10px;}
</style>
</head>
<body class="d-flex flex-column">
<%@ include file="../include/navbar.jsp"%>
<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div class="justify-content-center flex-sm-column d-sm-flex align-items-center">
				<h2 class="fw-bold" style="font-size: 40px;">Q&A</h2>
				<h2 class="fw-light " style="font-size: 18px; margin-top: 20px;">
					Q&A > 비밀글</h2>
			</div>
			<div class="row mt-4 mb-5" style="border-bottom:2px solid #000;"></div>
			<!-- 본문영역 -->
			<div id="passwdform">
			<form name="form1" action="${path }/qna/passwdck.do" method="post">
				<table id="passwdch">
					<tr>
						<th>비밀번호 확인</th>
					</tr>
					<tr>
						<td>이 글은 비밀글입니다. 비밀번호를 입력하여 주세요.<br>관리자는 확인버튼만 누르시면
							됩니다.
						</td>
					</tr>
					<tr>
						<td>비밀번호 <input type="password" name="passwd" id="passwd">
							<input type="hidden" value="${q_idx}" id="q_idx" name="q_idx">
							<input type="hidden" value="${sessionScope.h_userid }" id="h_userid">
						</td>
					</tr>
					<tr>
						<td><input type="button" value="목록" id="return"
							onclick="location.href='${path }/qna/qnalist.do'"> <input
							type="button" value="확인" id="passwordcheck"></td>
					</tr>
					<c:if test="${message != null }">
					<tr>
					<td style="color: red; font-weight: bold;">${message }</td>
					</tr>
					</c:if>
				</table>
			</form>
			</div>
		</div>
	</section>
<%@ include file="../include/footer.jsp"%>
</body>
</html>