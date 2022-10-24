<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>회원가입</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />

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
	      							$("#userid_check" ).css("margin-left", "155px");
	      							$("#userid_check" ).css("color", "blue");
	      							$("#submit" ).attr( "disabled", false);
	      						} else if( data == "1"  ) {
	      							$("#userid_check").text("사용중인 ID입니다.");
	      							$("#userid_check").css("margin-left", "155px");
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
	      				$("#userid_check").css("margin-left", "155px");
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
	      			$("#passwd_check").css("margin-left", "155px");
	      			$("#passwd_check").css("color", "red");
	      			$("#passwd").val("");
	      			$("#submit").attr("disabled", true);
	      		} else{
	      			$("#passwd_check").text("");
	      			//패스워드 입력확인
	      			$("#confirm_passwd_check").blur(function() {
	      				var passwd = $("#passwd").val();
	      				var confirm_passwd_check = $("#confirm_passwd_check").val();
	      				
	      				if(passwd !='' && passwd2 !='') {
	      					if( passwd == passwd2 ) {
	      						$("#confirm_passwd_check").text("비밀번호가 같습니다.");
	      						$("#confirm_passwd_check").css("margin-left", "155px");
	      						$("#confirm_passwd_check").css("color", "blue");
	      						$("#submit").attr("disabled", false);
	      					} else {
	      						$("#confirm_passwd_check").text("비밀번호가 틀립니다.");
	      						$("#confirm_passwd_check").css("margin-left", "155px");
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
          //파일 검사
          if (document.form1.profile_img.value.trim() != "") {
              var fileValue = document.form1.profile_img.value.trim().split('\\');
              var filename = fileValue[fileValue.length-1];
              var fileEname = filename.substring(filename.length-4, filename.length);
              if (fileEname == '.jpg' || fileEname == '.png' || fileEname == '.gif' || fileEname == '.GIF' || fileEname == '.PNG' || fileEname == '.JPG') {
              } else {
                  alert('사진파일만 첨부해주세요.(jpg, png, gif)');
                  document.form1.profile_img.value ='';
                  return false;
              }
          } 
		  //document.form1.action="${path}/guest/insert.do";
          document.form1.submit(); 
	      alert("회원가입되었습니다.");
	}
	}
</script>

</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5">
		<div class="signup-form">
      <form method="post" name="form1" class="form-horizontal" action="${path}/guest/insert.do" enctype="multipart/form-data">
          <div class="row">
              <div class="col-8 signuptitle">
                  <h2>회원가입</h2>
              </div>	
          </div>			
          <div class="form-group row">
              <div class="col-8">
              <input type="hidden" id = "profile_img" value =""/>
              <label class="col-form-label col-4">아이디</label>
              <p><input type="text" class="form-control" id="userid" name="userid" placeholder="3~12, 영어대소문자, 숫자가능" required="required"></p>
              </div>            
              <div id="userid_check"></div>
          </div>

          <div class="form-group row">
              <div class="col-8">
              <label class="col-form-label col-4">비밀번호</label>
              <p><input type="password" class="form-control" id="passwd" name="passwd" placeholder="4~12, 영어대소문자, 숫자가능" required="required"></p>
              </div>   	
              <div id="passwd_check"></div>
          </div>
          <div class="form-group row">
              <div class="col-8">
              <label class="col-form-label col-4">비밀번호 확인</label>
              <p><input type="password" class="form-control" id="passwd2" name="confirm_passwd"></p>
              </div>        	
              <div id="confirm_passwd_check"></div>
          </div>

          <div class="form-group row">
              <div class="col-8">
              <label class="col-form-label col-4">이름</label>
              <p><input type="text" class="form-control" name="name"></p>
              </div>        	
          </div>

          <div class="form-group row">
              <div class="col-8">
              <label class="col-form-label col-4">이메일</label>
              <p><input type="email" class="form-control" id="email" name="email" placeholder="stayhere@stayhere.com" ></p>
              </div>        	 
              <div id="mail_chk"></div>
          </div>
          
          <div class="form-group row">
              <div class="col-8">
              <label class="col-form-label col-4">연락처</label>
              <p><input type="tel" class="form-control" id="phone" name="phone" placeholder="010-1234-5678"></p>
              </div>   
              <div id="phone_chk"></div>     	
          </div>

          <div class="form-group row">
              <label class="col-form-label col-4">프로필 사진</label>
              <p><input type="file" class="form-control" id="profile_img" name="profile_img" ></p>
          </div> 
			
		  <div class="col-8 offset-4">
                  <button type="submit" id="submit" class="btn btn-primary btn-lg">회원가입</button>
              </div>  
		      
      </form>
      <div class="text-center">이미 회원이십니까? <a href="${path}/guest/login.do">로그인 하러 가기</a></div>
  </div>
        <div>
         <p> -  또는  - </p>
         <a>카카오톡</a>
         <a>네이버</a>
        </div>
        

	 <!-- 요기 안에서 코드작성해주시면 됩니다..! -->
		
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>