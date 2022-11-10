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
a { 
 text-decoration: none;
}
#profile-tab a {
 color: black;
 text-decoration: none;
}
#profile-tab a:hover {
 color: #ffc107;
 text-decoration: none;
}
.profile {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
}
label {
 font-size: 12px;
}
#btnSave {
 width: 100%;
}
</style>
<script type="text/javascript">
window.onload = function() {
	//id와pw 적합여부 검사
	let val = /^[a-zA-Z0-9]{3,15}$/	
	
	//형식검사
	function check(val, target) {
		if(val.test(target)) {
			return true;
		}
	}
    //패스워드 유효성 검사
  	$("#passwd").blur(function() {
  		var passwd = $("#passwd").val();
  		var passwd2 = $("#passwd2").val();
  		var confirm_passwd_check = $("#confirm_passwd_check").val();
  		if(!check(val,passwd)) {
  			$("#passwd_check").text("패스워드가 형식에 맞지 않습니다.");
  			$("#passwd_check").css("font-size", "12px");
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
  					if(passwd == passwd2) {
  						$("#confirm_passwd_check").text("비밀번호가 같습니다.");
  			  			$("#confirm_passwd_check").css("font-size", "12px");
  						$("#confirm_passwd_check").css("color", "blue");
  						$("#submit").attr("disabled", false);
  					} else {
  						$("#confirm_passwd_check").text("비밀번호가 틀립니다.");
  						$("#confirm_passwd_check").css("font-size", "12px");
  						$("#confirm_passwd_check").css("color", "red");
  						$("#passwd2").val("");
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
  <section class="mt-3 mb-5" id="features">
	<div class="container">
		<div class="row">
			
			<div class="list-group col-lg-3 mt-4" id="profile-tab" align="center">
				<div style="width: 80%;">
					<c:if test="${dto.profile_img != null}">			 
						<img class="profile" src="${path}/imgUpload/${dto.profile_img}" style="border-radius: 50%; width: 230px; height: 230px;">
					</c:if>
					
					<c:if test="${dto.profile_img == null}">
						<img class="profile" src="${path}/resources/images/guest.png" style="border-radius: 50%; width: 230px; height: 230px;">
					</c:if>
				
					<br><br>
					<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">마이 페이지</a>
					<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약 정보</a>
					<a href="${path}/reviews/reviewUserList/${sessionScope.userid}" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
					<a href="${path}/chatlist" class="list-group-item list-group-item-action">채팅목록</a>
          <a href="${path}/qna/scraplist"class="list-group-item list-group-item-action">나의 스크랩</a>
					<a href="${path}/wishlist/list.do" class="list-group-item list-group-item-action">관심 스테이</a>
				</div>
			</div>

			<div class="col-lg-9 mt-4 mb-5">
				<div align="center">
		            <p style="text-align: center; font-size: 20px; font-weight: bold; letter-spacing: 12px;">MY PAGE</p>
					<p style="text-align: center; font-size: 14px; letter-spacing: 8px;">마이페이지</p>
	
					<p class="fs-4 mt-5">${sessionScope.name}님 반가워요!</p>
					<p class="fs-6">스테이히어와 함께 ${cntCheckout}번의 여행을 했어요.</p>
					
					<span>${dto.email} |</span>
					<span><a href="${path}/guest/update/${sessionScope.userid}">프로필 수정</a></span> 
				</div>		
				
				<br><br>
				
				<hr class="gray_line mx-auto" style="width: 100%;">
				
            	<div>
                    <form name="form1" method="post" enctype="multipart/form-data">
                    	<input type="hidden" value="${sessionScope.userid}">
                  		<div class="mx-auto" style="width: 50%;" align="center">
                  	 	 	<c:if test="${dto.profile_img != null}">
                  	 	 		<div class="profile_img">
                  	 	 			<img class="profile" src="${path}/imgUpload/${dto.profile_img}" style="border-radius: 50%; width: 250px; height: 250px;">
                  	 	 		</div>
                  	 	 	</c:if>
                  	 	 	<!-- 로그인유저의 profile_img가없다면 디폴트 이미지 노출 -->
                  	 	 	<c:if test="${dto.profile_img == null}">
                  	 	 		<div class="profile_imgDefault">
                  	 	 			<img class="profile" src="${path}/resources/images/guest.png" style="border-radius: 50%; width: 250px; height: 250px;">
                  	 	 		</div>
                  	 	 	</c:if>          
	                  	 	<label class="lead fs-6 mt-2" for="file"><i class="bi bi-camera fs-4"></i>&nbsp;사진 수정하기</label> 
	                  	 	<input type="file" id="file" name="file" style="display: none;">
							<input type="hidden" name="profile_img" value="${dto.profile_img}">                 	 
                  	 	 </div>    	 	 
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
                  		 <div class="mx-auto" style="width: 50%;">
                        	<input class="form-control me-2" type="hidden" id = "userid" value ="${dto.userid}"/>
                        	<label>아이디</label>
                        	<input class="form-control me-2" value="${dto.userid}" disabled>
                  			<div>
                        		<label>비밀번호</label>
			      	    		<input class="form-control me-2" type="password" name="passwd" id="passwd" value="${dto.passwd}">
			      	    		<div class="text-start" id="passwd_check"></div>	      	    
                  			</div>
                  			<div>
                        		<label>비밀번호확인</label>
			      	    		<input class="form-control me-2" type="password" name="passwd2" id="passwd2" value="${dto.passwd}">			      	  
			      	    		<div class="text-start" id="confirm_passwd_check"></div>			      	  
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
	                      	<button class="btn btn-warning mb-1 mt-3" type="submit" id="btnSave" name="btnSave">수정하기</button>
				            <span><a href="${path}/guest/delete.do" class="confirmDelete">탈퇴</a></span>
                  		</div>
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