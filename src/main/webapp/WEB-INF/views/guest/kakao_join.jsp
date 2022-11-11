
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>카카오 회원가입</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
  <script type="text/javascript">
	window.onload = function() {
		//id와pw 적합여부 검사(3~12자리, 영어대소문자, 숫자만 가능)
		let val = /^[a-zA-Z0-9]{3,15}$/	
		
		//형식검사
		function check( val, target ) {
			if( val.test( target ) ) {
				return true;
			}
		}
		//add
		console.log("load****");
		console.log(document.form1.userid.value);
	      	//id 중복 검사
	      	$("#userid").blur(function() {
	      		var userid = $("#userid").val();
	      		if(userid != "") {
	      			if(check(val, userid)) {
	      				$.ajax({
	      					url: "${path}/guest/idCheck.do?userid="+userid,
	      					type: "GET",
	      					success: function( data ) {
	      						if( data == "0" ) {
	      							$("#userid_check" ).text("사용할 수 있는 ID입니다.");
	      							$("#userid_check" ).css("color", "blue");
	      							$("#submit" ).attr( "disabled", false);
	      						} else if( data == "1"  ) {
	      							$("#userid_check").text("사용중인 ID입니다.");
	      							$("#userid_check").css("color", "red");
	      							$("#submit").attr("disabled", true);
	      						}
	      					},
	      					error: function() {
	      						console.log("ajax 에러")
	      					}
	      				})
	      			} else {
	      				$("#userid_check").text("ID가 형식에 맞지않습니다.");
	      				$("#userid_check").css("color", "red");
	      				$("#userid").val("");
	      				$("#submit").attr("disabled", true);
	      			}	
	      		} else {
	      			$("#userid_check").text("");
	      		}
	      	});		  

	        //패스워드 유효성 검사
	      	$("#passwd").blur(function() {
	      		var passwd = $("#passwd").val();
	      		var passwd2 = $("#passwd2").val();	      		
	      		if(!check(val,passwd)) {
	      			$("#passwd_check").text("패스워드가 형식에 맞지 않습니다.");
	      			$("#passwd_check").css("color", "red");
	      			$("#passwd").val("");
	      			$("#submit").attr("disabled", true);
	      		} else{
	      			$("#passwd_check").text("");
	      			//패스워드 입력확인
	      			$("#passwd2").blur(function() {
	      				var passwd = $("#passwd").val();
	      				var passwd2 = $("#passwd2").val();
	      				var confirm_passwd_check = $("#confirm_passwd_check").val();
	      				
	      				if(passwd !='' && passwd2 !='') {
	      					if( passwd == passwd2 ) {
	      						$("#confirm_passwd_check").text("비밀번호가 같습니다.");
	      						$("#confirm_passwd_check").css("color", "blue");
	      						$("#submit").attr("disabled", false);
	      					} else {
	      						$("#confirm_passwd_check").text("비밀번호가 틀립니다.");
	      						$("#confirm_passwd_check").css("color", "red");
	      						$("#passwd2" ).val("");
	      						$("#submit").attr("disabled", true);
	      					}
	      				} else {
	      					$("#passwd_check").text("");
	      					$("#submit").attr("disabled", false);
	      				}
	      				
	      			});
	      		}
	      	});	      	

	     	//이메일 인증
            $("#btnMailCheck").click(function() {
        		var eamil = $("#email").val(); // 이메일 주소값 얻어오기!       		
        		var checkInput = $(".mail-check-input"); // 인증번호 입력하는곳 
        		$.ajax({
        			type : "GET",
        			url : "${path}/guest/mailCheck?email="+eamil, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
        			success : function (data) {
        				console.log("data : " +  data);
        				checkInput.attr("disabled",false);
        				code = data;
        				alert("인증번호가 전송되었습니다.");
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
        			$("#email").attr("readonly",true);
        			$("#email").attr("onFocus", "this.initialSelect = this.selectedIndex");
        	        $("#email").attr("onChange", "this.selectedIndex = this.initialSelect");
        	        document.getElementById("submit").disabled = false;
        		}else{
        			alert("인증번호가 다릅니다. 다시 확인해주세요.");
        			checkResult.attr("class","correct");
        		}
        	});
        	
        	//이메일중복검사
        	const email = document.form1.email.value;
        	$.ajax({
        		type:'POST',
        		url:'${path}/guest/emailCheck.do',
        		header:{"Content-Type":"application/json"},
        		dateType:'json',
        		data:{email:email},
        		success : function(result){
        			if(result == true){
        				alert('이미 가입된 이메일입니다.');
        				} 
        			}
        	});
        	
	        //회원가입 버튼 클릭시
	     	document.getElementById("submit").onclick = function() {
	            let userid = document.form1.userid.value.trim();
	            let passwd = document.form1.passwd.value.trim();
	            let passwd2 = document.form1.passwd2.value.trim();

	            if(userid == "") {
	                alert('ID를 입력하셔야 합니다.')
	                document.form1.userid.focus();
	                return false;
	            } 
	            if(passwd == "") {
	                alert('비밀번호를 입력하셔야 합니다.')
	                document.form1.passwd.focus();
	                return false;
	            }
	            if(passwd2 == "") {
	                alert('비밀번호확인을 하셔야합니다.')
	                document.form1.passwd2.focus();
	                return false;
	            }
	            if(document.form1.name.value.trim() == "") {
	                alert('이름을 입력하셔야 합니다.')
	                document.form1.name.focus();
	                return false;
	            }	  
	        		  
	      alert("회원가입되었습니다.");
          document.form1.submit(); 
			}
	}
</script>

<style type="text/css">

.signup-form{
	width: 600px;
	margin: 0 auto;
}

#submit {
	width: 150px;
	height: 50px;
	background-color: #ffcd4a;
	border-color: #ffcd4a;
}

#btnMailCheck{
	background-color: #ffcd4a;
}
</style>
</head>
<body>
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
		<div class="signup_form">
			<form name="form1" action="${path}/guest/insert.do" method="post">
        		<div class="col-8 signuptitle">
            		<h2>회원가입</h2>
            	</div>	

        		<div class="form-group">
        			<input type="hidden" id = "profile_img" value =""/>
        			<label class="col-form-label col-4">아이디</label>
        			<p><input type="text" class="form-control" id="userid" name="userid" value="${userid}"></p>
        			<div class="text-start" id="userid_check"></div>
        		</div>

        		<div class="form-group">
        			<label class="col-form-label col-4">비밀번호</label>
        			<p><input type="password" class="form-control" id="passwd" name="passwd" placeholder="3~12, 영어대소문자, 숫자가능" required="required"></p>
        			<div class="col-8" id="passwd_check"></div>
        		</div>
        		<div class="form-group">
        			<label class="col-form-label col-4">비밀번호 확인</label>
        			<p><input type="password" class="form-control" id="passwd2" name="confirm_passwd"></p>
        			<div class="text-start" id="confirm_passwd_check"></div>
        		</div>

        		<div class="form-group row">
        			<label class="col-form-label col-4">이름</label>
        			<p><input type="text" class="form-control" name="name" value="${name}" readonly="readonly"></p>
        		</div>

        		<div class="form-group">
        			<label class="col-form-label col-4">이메일</label>
        			<p><input type="email" class="form-control" id="email" name="email" value="${email}" readonly="readonly"></p>
        			<div class="input-group" id="mail_chk">
        				<input type="text" class="form-control mail-check-input" placeholder="인증번호를 입력하세요" disabled="disabled" maxlength="12" name="">
        				<button type="button" class="btn" id="btnMailCheck">본인인증</button>
        			</div>
        		<span id="mail-check-warn"></span>
        		</div>
          <br>
          
        		<div class="form-group">
        			<label class="col-form-label col-4">연락처</label>
        			<p><input type="tel" class="form-control" id="phone" name="phone" placeholder="010-1234-5678"></p>
        			<div class="col-8" id="phone_chk"></div>     	
        		</div>
        		<div class="col-8 offset-4">
        			<button type="submit" id="submit" class="btn btn-lg" disabled>회원가입</button>
        		</div>  
			</form>
		</div>
	</div>
  </section>
 </main>
  <%@ include file="../include/footer.jsp" %>
 	<c:if test="${message == 'first' }">
	 <% out.println("<script>"); 
	 out.println("alert('첫 소셜 로그인에 한해 회원가입을 진행합니다.');"); 
	 out.println("</script>");%>
	</c:if>
	<c:if test="${message == 'logout' }">
	 <% out.println("<script>"); 
	 out.println("alert('로그아웃 완료.');"); 
	 out.println("</script>");%>
	 </c:if>
</body>
</html>