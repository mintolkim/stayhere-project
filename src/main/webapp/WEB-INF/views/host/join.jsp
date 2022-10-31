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
.btn{
	width: 296px;
	height: 40px;
	background-color: #ffcd4a;
}

a {
	text-decoration: none;
}

.content {
  width : 296px;
  top: 50%;
  left: 50%;
  text-align: left;
}

label {
	font-size: 10px;
}
.id_ok { 
	font-size: 10px;
	color: blue;
	display: none;
	}
.id_already {
	font-size: 10px;
	color: red;
	display: none;
	}

</style>
<script type="text/javascript">
$(function(){
	$("#join").click(function(){
		var h_userid=$("#h_userid").val(); //태그의 value 속성값
		var h_passwd=$("#h_passwd").val();
		var h_passwd2=$("#h_passwd2").val();
		var h_name=$("#h_name").val();
		
/* 		var h_email=$("#h_email").val();
		var h_phone=$("#h_phone").val();
		var h_manager_num=$("#h_manager_num").val(); */
		
		
		if(h_userid==""){
			alert("아이디를 입력하세요.");
			$("#h_userid").focus(); //입력 포커스 이동
			return; //함수 종료
		}
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
		if(h_name==""){
			alert("이름을 입력하세요.");
			$("#h_name").focus(); //입력 포커스 이동
			return; //함수 종료
		} 
		
		//폼 데이터를 서버로 제출
		alert("가입을 환영합니다.");
		document.form1.action="${path}/host/insert.do";
		document.form1.submit();
	});
});

function checkId(){
    var h_userid = $('#h_userid').val();
    $.ajax({
        url:"${path}/host/idCheck.do", 
        type:'post', 
        data:{h_userid:h_userid},
        success:function(cnt){
            if(cnt == 0){
                $('.id_ok').css("display","inline-block"); 
                $('.id_already').css("display", "none");
            } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                $('.id_already').css("display","inline-block");
                $('.id_ok').css("display", "none");
                $('#h_userid').val('');
        		
            }
        },
        error:function(){ 
            alert("에러입니다");
        }
    });
   };
</script>
</head>
<body class="d-flex flex-column">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5" align="center">
		<div class="content">
		<h2><b>Create an Account</b></h2>
		<a href="${path}/host/login.do">Already have an account? Sign in here</a>
		<br>
		<br>
		<form name="form1">
		<label> <span class="id_ok">사용 가능한 아이디입니다.</span><span class="id_already">이미 존재하는 아이디입니다.</span></label>
		<input class="form-control me-2" type="text" placeholder="ID" name="h_userid" id="h_userid" oninput = "checkId()">
		<br>
		<label>비밀번호 8글자 이상 대소문자포함</label>
		<input class="form-control me-2" type="password" placeholder="Password" name="h_passwd" id="h_passwd">
		<br>
		<br>
		<input class="form-control me-2" type="password" placeholder="Confirm Password" name="h_passwd2" id="h_passwd2">
		<br>
		<br>
		<input class="form-control me-2" type="text" placeholder="Name" name="h_name" id="h_name">
		<br>
		<br>
		<input class="form-control me-2" type="text" placeholder="Email" name="h_email" id="h_email">
		<br>
		<br>
		<input class="form-control me-2" type="text" placeholder="Phone" name="h_phone" id="h_phone">
		<br>
		<br>
		<input class="form-control me-2" type="text" placeholder="Corporate Registration Mumber" name="h_manager_num" id="h_manager_num">
		<br>
		<br>
		<input type="button" class="btn btn-warning" id="join" value="Join">
		</form>
		</div>

	</div>
	
	
 </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
