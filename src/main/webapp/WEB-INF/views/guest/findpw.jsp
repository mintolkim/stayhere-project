<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역  start-->

<!-- 그외 페이지별 들어갈 script & css 추가 영역 end -->
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
.mybtn{
  width:150px;
  height:40px;
  padding:0;
  display:inline; 
  border-radius: 4px; 
  background-color: #ffcd4a;
  color: #fff;
  margin-top: 20px;
  border: solid 2px #ffcd4a; 
  transition: all 0.5s ease-in-out 0s;
}
.mybtn:hover .mybtn:focus {
  background: white;
  color: #212529;
  text-decoration: none;
}
</style>
</head>
<body class="d-flex flex-column">
	<!-- nav_search_bar 는 검색창 노출화면 -->
	<!-- 폴더를 만들어서 적용할시 ../ 으로 변경 -->
<%-- 	<%@ include file="./include/nav_search_bar.jsp"%> --%>
	<%@ include file="../include/navbar.jsp"%>
	
	<!-- 컨텐츠 수정 영역 start -->
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4 w3-auto" style="width: 382px;height: 456.3px;">
			<div class="w3-center w3-large w3-margin-top">
				<h3>비밀번호 찾기</h3>
			</div>
			<div>
				<p>
					<label>아이디</label>
					<input class="w3-input" type="text" id="userid" name="userid" placeholder="회원가입한 아이디를 입력하세요" required>
				</p>
				<p>
					<label>이메일</label>
					<input class="w3-input" type="text" id="email" name="email" placeholder="회원가입한 이메일주소를 입력하세요"
					 required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i">
				</p>
				<p class="w3-center">
					<button type="button" id="findBtn" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">찾기</button>
					<button type="button" onclick="history.go(-1);" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">로그인으로</button>
				</p>
			</div>
		</div>
	</div>	
	
	
	<!-- 컨텐츠 수정 영역 end -->
	
	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>