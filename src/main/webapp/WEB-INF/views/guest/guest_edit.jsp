<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>프로필 수정</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />

<style type="text/css">
.display-5 {margin-bottom: 20px;}
.btn {margin-top: 20px;}
.col-lg-6 {margin-bottom: 3%;}
a { text-decoration: none;}
/* .content {
  width : 296px;
  top: 50%;
  left: 50%;
  text-align: left;
} */
.btn{
	/*width: 296px;*/
	width:100%;
	height: 40px;
	background-color: #ffcd4a;
    border: solid 2px #ffcd4a; 
}
.box {
    width: 250px;
    height: 250px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
    background-color: gray;
    background-color: #c3c3c3;
}
.box2 {
    width: 250px;
    height: 250px; 
    border-radius: 70%;
    overflow: hidden;
}
label {
	font-size: 10px;
}
.lead{
	margin-top: 1%;
}
.bi {
	font-size: 30px;
}


hr {
width: 100%
}
</style>
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
    
    $(function(){
    	$("#btnSave").click(function(){
    		var passwd = $("#passwd").val();
    		var passwd2 = $("#passwd2").val();
    		var name = $("#name").val();

    		if(passwd == "") {
                alert('비밀번호를 입력하셔야 합니다.')
                $("#passwd").focus();
                return;
            }
            if(passwd2 == "") {
                alert('비밀번호확인을 하셔야합니다.')
                $("#passwd2").focus();
                return;
            }
            if(name == "") {
                alert('이름을 입력하셔야 합니다.')
                $("#name").focus();
                return;
            }
    	});
    });
	document.getElementById("btnSave").onclick = function() {
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
		alert("수정되었습니다.");
		document.form1.action="${path}/guest/edit.do";
		document.form1.submit(); 
		}
}	

/* $(function(){
	$("#btnSave").click(function(){
		confirm("프로필을 수정하시겠습니까?")
		if(confirm){
			document.form1.action="${path}/guest/edit/${sessionScope.userid}"; 
			//document.form1.userid.value=${dto.userid};
			document.form1.action="${path}/guest/edit.do";
			document.form1.submit();
		}
	});
}); 
*/

</script>

</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
 <!-- nav -->
 <%@ include file="../include/navbar.jsp" %>
 <!-- 본문영역-->
 <section class="py-5" id="features">
 	<div class="container px-5 my-5" align="center">
		<!-- Hi! -->
		<div class="row justify-content-center">
			<div class="col-lg-6">
				<h2 class="fw-bolder mb-0">M　Y　P　A　G　E</h2>
				<p class="lead" style="margin-top: 4%;">${sessionScope.name}님 반가워요</p>
				${dto.email} | <span><a href="${path}/guest/update/${sessionScope.userid}">프로필 수정</a></span>
			</div>
			<hr>
		</div>

		<!-- content -->

		<div class="row gx-5">
          <div class="col-lg-4 mb-5 mb-lg-0">
          <p><a>프로필</a></p>
      	  <p><a href="${path}/guest/update/${sessionScope.userid}">회원정보 수정</a></p>
      	  <p><a href="${path}/reservations/list/guest">예약정보</a></p>
      	  <p><a href="${path}/wishlist/list.do">관심스테이</a></p>
      	  <p><a href="${path}/guest/delete.do" class="confirmDelete">회원탈퇴</a></p>      	  
      	  </div>
      	  
      	  <!-- 프로필 -->
      	  
		<div class="col-lg-8">
        	<div class="row gx-5 row-cols-1 row-cols-md-2">
            	<div class="col mb-5 h-100" align="left">
                	<p class="lead"><b>회원정보 수정</b></p>
                    <form name="form1" method="post" enctype="multipart/form-data">
                    	<input type="hidden" value="${sessionScope.userid}">
                  		<div class="box">
                  	 		<c:if test="${dto.profile_img != null}">
                  	 	 		<img class="profile" src="${path}/imgUpload/${dto.profile_img}" >
                  	 	 	</c:if>
                  	 	 	<!-- 로그인유저의 profile_img가없다면 디폴트 이미지 노출 -->
                  	 	 	<c:if test="${dto.profile_img == null}">
                  	 	 		<img class="profile" src="${path}/resources/images/guest.png">
                  	 	 	</c:if>
                  	 	 </div>    
                  	 	<label class="lead" for="file" style="text-align: center;"><i class="bi bi-camera"></i>&nbsp;사진 수정하기</label> 
                  	 	<input type="file" id="file" name="file" style="display: none;">
						<input type="hidden" name="profile_img" value="${dto.profile_img}">                 	 

<script>
$("#file").change(function(){
	if(this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".box img").attr("src", data.target.result);
			}
		reader.readAsDataURL(this.files[0]);
		}
	});
 </script>
                  		<div>
                        	<input class="form-control me-2" type="hidden" id = "userid" value ="${dto.userid}"/>
                        	<label>아이디</label>
			      	    	<p class="lead" id="useridTemp">${dto.userid}</p>
                  			<div>
                        		<label>비밀번호</label>
			      	    		<input class="form-control me-2" type="password" name="passwd" id="passwd" value="${dto.passwd}">
			      	    		<div id="passwd_check"></div>	      	    
                  			</div>
                  			<div>
                        		<label>비밀번호확인</label>
			      	    		<input class="form-control me-2" type="password" name="passwd2" id="passwd2" value="${dto.passwd}">			      	  
			      	    		<div id="confirm_passwd_check"></div>			      	  
                  			</div>  
                  			<div>
                        		<label>이메일</label>
			      	    		<input class="form-control me-2"  name="email" id="email" value="${dto.email}">
			      	    		<div id="mail_chk"></div>			      	  
                  			</div>
                  			<div>
                        		<label>이름</label>
			      	    		<input  class="form-control me-2" name="name" id="name" value="${dto.name}">
                  			</div>
                  			<div>
                        		<label>휴대폰</label>
			      	    		<input class="form-control me-2" name="phone" id="phone" value="${dto.phone}">
                  			</div>
                  		</div>
                      	<button class="btn btn-block" type="submit" id="btnSave" name="btnSave">수정하기</button>
                    </form>
                  </div>
              </div>
		</div>
 	</div>
 </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>