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
.email_ok { 
	font-size: 10px;
	color: blue;
	display: none;
	}
.email_already {
	font-size: 10px;
	color: red;
	display: none;
	}
#btnMailCheck {
	border-radius: 10%;
	background: #f7f7f7;
	font-weight: 800;
	border: none;
	font-size: 13px;
}	

</style>
<script type="text/javascript">
$(function(){
	$("#join").click(function(){
		var h_userid=$("#h_userid").val(); //태그의 value 속성값
		var h_passwd=$("#h_passwd").val();
		var h_passwd2=$("#h_passwd2").val();
		var h_name=$("#h_name").val();
 		var h_email=$("#h_email").val();
		var h_phone=$("#h_phone").val();
		var h_manager_num=$("#h_manager_num").val(); 
		
		
		if(h_userid==""){
			alert("아이디를 입력하세요.");
			$("#h_userid").focus(); //입력 포커스 이동
			return; //함수 종료
		}
		exp1 = /[~!@#\#$%<>^&*]/;
		exp2 = /^[가-힣]+$/;
		
		if(h_userid)
		
		if(exp1.test(h_userid)||exp2.test(h_userid)){
			alert("아이디는 영어와 숫자만 가능합니다.");
			h_userid.focus();
			return;
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
 		exp3 = /(?=.*[a-z])(?=.*[!@#$%^&*()_+=-])(?=.*\d){6,10}/;
		
		if(!exp3.test(h_passwd)){
			alert("비밀번호 대소문자,특수기호 포함 6~10자리로 해주세요.");
			h_passwd.focus();
			return;
		}
		 
		
		if(!exp2.test(h_name)){
			alert("이름은 한글만 가능합니다. 다시 입력해주세요.");
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
	
  	//이메일 인증
    $("#btnMailCheck").click(function() {
		h_eamil = $("#h_email").val();      		
		checkInput = $(".mail-check-input");
		$.ajax({
			type : "GET",
			url : "${path}/host/authokeyMail?h_email="+h_eamil, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr("disabled",false);
				code = data;
				alert("인증번호가 전송되었습니다.");
				$("#btnMailCheck").val("확인");
			},
			error: function() {
					console.log("이메일 인증 ajax 에러");	
			}
		}); // end ajax
	}); // end btnMailCheck 클릭이벤트
	// 인증번호 비교 
	$(".mail-check-input").blur(function () {
		var inputCode = $(".mail-check-input").val();
		var checkResult = $("#mail-check-warn");
		if(inputCode === code){
			alert("인증번호가 일치합니다.");
			checkResult.attr("class","correct");
			$("#btmMailCheck").attr("disabled", true);
			$("#h_email").attr("readonly",true);
			$("#h_email").attr("onFocus", "this.initialSelect = this.selectedIndex");
	        $("#h_email").attr("onChange", "this.selectedIndex = this.initialSelect");
			$("#join").attr("disabled", false);
		}else{
			alert("인증번호가 다릅니다. 다시 확인해주세요.");
			checkResult.attr("class","correct");
			$("#join").attr("disabled", true);
		}
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
   
function checkEmail(){
    var h_email = $('#h_email').val();
    $.ajax({
        url:"${path}/host/emailCheck.do", 
        type:'post', 
        data:{h_email:h_email},
        success:function(cnt){
            if(cnt == 0){
                $('.email_ok').css("display","inline-block"); 
                $('.email_already').css("display", "none");
            } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                $('.email_already').css("display","inline-block");
                $('.email_ok').css("display", "none");
                $('#h_email').val('');
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
		<label><span class="id_ok">사용 가능한 아이디입니다.</span><span class="id_already">이미 존재하는 아이디입니다.</span></label>
		<input class="form-control me-2" type="text" placeholder="ID" name="h_userid" id="h_userid" oninput = "checkId()">
		<br>
		<label>대소문자, 특수문자 포함 6-10글자</label>
		<input class="form-control me-2" type="password" placeholder="Password" name="h_passwd" id="h_passwd">
		<br>
		<br>
		<input class="form-control me-2" type="password" placeholder="Confirm Password" name="h_passwd2" id="h_passwd2">
		<br>
		<br>
		<input class="form-control me-2" type="text" placeholder="Name" name="h_name" id="h_name">
		<br>
		<label><span class="email_ok">사용 가능한 이메일입니다.</span><span class="email_already">이미 존재하는 이메일입니다.</span></label>
		<div class="input-group mb-3">
		<input class="form-control me-2" type="text" placeholder="Email" name="h_email" id="h_email" oninput="checkEmail()">
		<input class="btn-warning" id="btnMailCheck" type="button" value="인증">
		</div>
		<br>
        <div id="mail_chk">		
		<input type="text" class="form-control me-2 mail-check-input" placeholder="인증번호를 입력하세요" disabled="disabled" maxlength="12">
		<br>
		</div>
		<span id="mail-check-warn"></span>
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
