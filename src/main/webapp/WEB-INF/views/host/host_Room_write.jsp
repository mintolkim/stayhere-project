<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Host Room Write</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
.display-5 {margin-bottom: 20px;}
.btn { 
	margin-top: 20px;
}
.col-lg-6 {margin-bottom: 3%;}
a { text-decoration: none;}
.lead a { color: black; font-size: 16px;}
.lead a:hover { color: black; font-size: 16px; font-weight: 640;}
label {
	font-size: 13px;
}
.col .lead b { font-size: 25px;}
#box1 { 
    width: 100%;
    height: 100%; 
    border-radius: 2%;
    overflow: hidden;
}
#box2, #box3, #box4 {
	width: 300px;
    border-radius: 2%;
    overflow: hidden;
}
#photo_2, #photo_3, #photo_4 {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
#room_write{
	margin-top: 6%;
	margin-bottom: 6%;
	width: 80%;
}
 
#minus1, #minus2, #minus3, #minus4, #minus5{
	width: 30px;
	border-radius: 10%;
	background: #f7f7f7;
	font-weight: 800;
	border: none;
}
#plus1, #plus2, #plus3, #plus4, #plus5{
	width: 30px;
	border-radius: 10%;
	background: #f7f7f7;
	font-weight: 800;
	border: none;
}
</style>
<!-- 다음주소 -->
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 카카오 맵 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0403296c83daa74c4b2702e088a2418&libraries=services"></script>
<script type="text/javascript">
$(function(){
var geocoder = new kakao.maps.services.Geocoder();

$("#address1").click(function(){
    new daum.Postcode({
        oncomplete: function(data) {
            $("#address1").val(data.address);
            $("#address1").prop("readonly",true);
            $("#zipcode").val(data.zonecode);
            var address1 =  $("#address1").val();
            words = address1.split(" ");
            $("#city").val(words[0]);
            $("#country").val(words[1]);
            
        	geocoder.addressSearch(address1, callback);  
        }
    }).open()
});
 
var callback = function(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		$("input[name=lng]").val(result[0].x);
		$("input[name=lat]").val(result[0].y);
	} 
};

$("#insert").click(function(){
	room_name=$("#room_name").val();
	contents=$("#contents").val();
	room_type=$("#room_type").val();
	address1=$("#address1").val();
	address2=$("#address2").val();
	room_price=$("#room_price").val();
	add_people=$("#add_people").val();
	baths=$("#baths").val();
	beds=$("#beds").val();
	max_people=$("#max_people").val();
	photo1=$("#photo1").val();
	photo2=$("#photo2").val();
	photo3=$("#photo3").val();
	photo4=$("#photo4").val();
	
	if(room_name==""){
		alert("숙소 이름을 입력하세요");
		$("#room_name").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(contents==""){
		alert("숙소 소개를 입력해주세요.");
		$("#contents").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(room_type=="-"){
		alert("숙소 타입을 선택해주세요.");
		$("#room_type").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(address1==""){
		alert("주소를 입력해주세요.");
		$("#address1").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(address2==""){
		alert("상세 주소를 입력해주세요.");
		$("#address2").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(room_price<1){
		alert("금액을 입력해주세요");
		$("#room_price").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(add_people<1){
		alert("추가 금액을 입력해주세요.");
		$("#add_people").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(baths<1){
		alert("화장실을 갯수를 입력해주세요.");
		$("#baths").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(beds<1){
		alert("침대 갯수를 입력해주세요.");
		$("#beds").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(max_people<1){
		alert("최대 인원수를 입력해주세요.");
		$("#max_people").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(photo1==""){
		alert("사진을 등록해주세요. ");
		$("#photo1").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(photo2==""){
		alert("사진을 등록해주세요. ");
		$("#photo2").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(photo3==""){
		alert("사진을 등록해주세요. ");
		$("#photo3").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(photo4==""){
		alert("사진을 등록해주세요. ");
		$("#photo4").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	
	confirm("등록 하시겠습니까? 승인은 평일 기준 2~3일 소요됩니다.");
	if(confirm){
	document.form1.action="${path}/rooms/insert";
	document.form1.submit();
	}

	});
});

function fileCheck(el) { 
    if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
    alert('이미지 파일만 업로드 가능합니다.'); 
    el.value = ''; 
    el.focus(); 
   }
 }
</script>
</head>
<body class="d-flex flex-column">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
	<div class="container px-5 my-5" align="center">
		
		<!-- Hi! -->
		
		<div class="row justify-content-center">
		<div class="col-lg-6" style="margin-bottom: 5%;">
		<h2 class="fw-bolder mb-0">H　O　S　T　R　O　O　M</h2>
		</div>
		<hr>
		</div>

		<!-- content -->
		<section class="py-5" id="features">
        <div class="container px-5 my-5">
        <div class="row gx-5">
        <div class="col-lg-4 mb-5 mb-lg-0">
          <p class="lead" ><a href="${path}/host/profile/${sessionScope.h_userid}">프로필</a></p>
    	  <p class="lead" ><a href="${path}/host/edit.do">회원정보수정</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_List/${sessionScope.h_userid}">숙소관리</a></p>
    	  <p class="lead" ><a href="${path}/rooms/write.do"><b style="font-weight: 700;">숙소등록</b></a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Confirm/${sessionScope.h_userid}">숙소승인현황</a></p>
    	  <p class="lead" ><a>예약현황</a></p>
    	  <p class="lead" ><a>매출현황</a></p>
 	      <p class="lead" ><a href="${path}/host/delete.do">회원 탈퇴</a></p>
   	     </div>
      	  
      	  <!-- 숙소 작성 -->
         <div class="col-lg-8">
			
			<input type="hidden" value="${sessionScope.h_userid}">
			<form name="form1" method="post" enctype="multipart/form-data" action="${path}/rooms/insert">
			<div class="card mb-4">
            <div class="card-body">
            <br>
            <div class="small text-muted">${sessionScope.h_name}님 의</div>
            <h4 class="card-title">숙소 등록</h4>
            <div align="left" id="room_write">
            <label>숙소 이름</label>
            <input class="form-control me-2" type="text" placeholder="Room's name" name="room_name" id="room_name">
            <br>
            <label>소개글</label>
            <textarea class="form-control" rows="3" style="height: 100px;" id="contents" name="contents"></textarea>
            <br>
            <label>타입</label>
			<select class="form-select" aria-label="Default select example" id="room_type" name="room_type">
			  <option selected>-</option>
			  <option value="주택">주택</option>
			  <option value="레지던스">레지던스</option>
			  <option value="아파트">아파트</option>
			  <option value="호텔">호텔</option>
			  <option value="펜션">펜션</option>
			</select>
            <br>
			
 			<label>주소</label>
			<input type="text" name="address1" id="address1" class="form-control me-2" placeholder="Room's address">
			<input type="hidden" name="lat">
			<input type="hidden" name="lng">
			<br>
 			<div class="input-group mb-2" align="center">
			<input type="text" name="zipcode" id="zipcode" class="form-control me-2" placeholder="우편번호" style="width: 20%;">
			<input type="text" name="address2" id="address2" class="form-control me-2" placeholder="상세주소" style="width: 75%;">
			</div>
			<br>			
			<input type="hidden" name="city" id="city" class="form-control me-2" placeholder="city" style="width: 75%;">
			<input type="hidden" name="country" id="country" class="form-control me-2" placeholder="country" style="width: 20%;">

	        <label>숙소 가격</label>
			<div class="input-group mb-3">
			<button class="btn-warning" id="minus1" type="button">-</button>
			<input type="text" class="form-control" value="10000" style="text-align: center;" id="room_price" name="room_price">
			<button class="btn-warning" id="plus1" type="button">+</button>
			</div>
			 <script>
			  $("#plus1").click(function(){
			   var num = $("#room_price").val();
			   var plusNum = Number(num) + 1000;
			   $("#room_price").val(plusNum);
			  });
			  
			  $("#minus1").click(function(){
			   var num = $("#room_price").val();
			   var minusNum = Number(num) - 1000;
			   $("#room_price").val(minusNum);  
			  });
			 </script>
 

			<br>
            <label>1인당 추가금액</label>
			<div class="input-group mb-3">
			  <button class="btn-warning" id="minus2" type="button">-</button>
			  <input type="text" class="form-control" value="10000" style="text-align: center;" id="add_people" name="add_people">
			  <button class="btn-warning" id="plus2" type="button">+</button>
			</div>
			 <script>
			  $("#plus2").click(function(){
			   var num = $("#add_people").val();
			   var plusNum = Number(num) + 1000;
			   $("#add_people").val(plusNum);
			  });
			  
			  $("#minus2").click(function(){
			   var num = $("#add_people").val();
			   var minusNum = Number(num) - 1000;
			   $("#add_people").val(minusNum);
			  });
			 </script>
			
			<br>
            <label>화장실 갯수</label>
			<div class="input-group mb-3">
			  <button class="btn-warning" id="minus3" type="button">-</button>
			  <input type="text" class="form-control" value="1" style="text-align: center;" id="baths" name="baths">
			  <button class="btn-warning" id="plus3" type="button">+</button>
			</div>
			
			 <script>
			  $("#plus3").click(function(){
			   var num = $("#baths").val();
			   var plusNum = Number(num) + 1;
			   $("#baths").val(plusNum);
			  });
			  
			  $("#minus3").click(function(){
			   var num = $("#baths").val();
			   var minusNum = Number(num) - 1;
			   $("#baths").val(minusNum);
			  });
			 </script>
			
			<br>
            <label>침대 갯수</label>
			<div class="input-group mb-3">
			  <button class="btn-warning" id="minus4" type="button">-</button>
			  <input type="text" class="form-control" value="1" style="text-align: center;" id="beds" name="beds">
			  <button class="btn-warning" id="plus4" type="button">+</button>
			</div>
			
			 <script>
			  $("#plus4").click(function(){
			   var num = $("#beds").val();
			   var plusNum = Number(num) + 1;
			   $("#beds").val(plusNum);
			  });
			  
			  $("#minus4").click(function(){
			   var num = $("#beds").val();
			   var minusNum = Number(num) - 1;
			   $("#beds").val(minusNum);
			   beds=$("#beds").val(plusNum);

			  });
			 </script>
			 
			<br>
            <label>최대 인원</label>
			<div class="input-group mb-3">
			  <button class="btn-warning" id="minus5" type="button"> - </button>
			  <input type="text" class="form-control" value="1" style="text-align: center;" id="max_people" name="max_people">
			  <button class="btn-warning" id="plus5" type="button"> + </button>
			</div>
			 <script>
			  $("#plus5").click(function(){
			   var num = $("#max_people").val();
			   var plusNum = Number(num) + 1;
			   $("#max_people").val(plusNum);
			  });
			  
			  $("#minus5").click(function(){
			   var num = $("#max_people").val();
			   var minusNum = Number(num) - 1;
			   $("#max_people").val(minusNum);
			  });
			 </script>
			<br>
			<br>
 			<div class="row gx-4">
            <div class="col-md-6" style="height: 100%; ">
            <p class="lead" style="text-align: center; font-size: 12px;">대표 이미지 설정</p>
            <div id="box1">
           <label for="photo1">
            <img class="card-img-top mb-5 mb-md-0" src="${path}/resources/images/img_insert.jpg" id="photo_1" style="height: 300px;">
            </label>
            <input type="file" id="photo1" name="photo" style="display: none;" onchange="fileCheck(this)">
       		<script>
		    $("#photo1").change(function(){
		     if(this.files && this.files[0]) {
		      var reader = new FileReader;
		      reader.onload = function(data) {
		       $("#box1 img").attr("src", data.target.result);
		      }
		      reader.readAsDataURL(this.files[0]);
		     }
		    });
		    </script>
			            
            </div>
            </div>
            <div class="col-md-6">
            <p class="lead" style="text-align: center; font-size: 12px;">상세 이미지 설정</p>
            <div class="small mb-1">
            <div id="box2">
            <label for="photo2">
            <img class="card-img-top mb-5 mb-md-0" src="${path}/resources/images/img_insert.jpg" id="photo_2" style="height: 100px; width: 300px;">
            </label>
            <input type="file" id="photo2" name="photo"  style="display: none;" onchange="fileCheck(this)">
       		<script>
		    $("#photo2").change(function(){
		     if(this.files && this.files[0]) {
		      var reader = new FileReader;
		      reader.onload = function(data) {
		       $("#box2 img").attr("src", data.target.result);
		      }
		      reader.readAsDataURL(this.files[0]);
		     }
		    });
		    </script>
            </div>
            </div>
            
            <div class="small mb-1">
            <div id="box3">
            <label for="photo3">
            <img class="card-img-top mb-5 mb-md-0" src="${path}/resources/images/img_insert.jpg" id="photo_3" style="height: 100px; width: 300px;">
            </label>
            <input type="file" id="photo3" name="photo"  style="display: none;" onchange="fileCheck(this)">
       		<script>
		    $("#photo3").change(function(){
		     if(this.files && this.files[0]) {
		      var reader = new FileReader;
		      reader.onload = function(data) {
		       $("#box3 img").attr("src", data.target.result);
		      }
		      reader.readAsDataURL(this.files[0]);
		     }
		    });
		    </script>
            </div>
            </div>
            
            
            <div class="small mb-1">
            <div id="box4">
            <label for="photo4">
            <img class="card-img-top mb-5 mb-md-0" src="${path}/resources/images/img_insert.jpg" id="photo_4" style="height: 100px; width: 300px;">
            </label>
            <input type="file" id="photo4" name="photo"  style="display: none;" onchange="fileCheck(this)">
       		<script>
		    $("#photo4").change(function(){
		     if(this.files && this.files[0]) {
		      var reader = new FileReader;
		      reader.onload = function(data) {
		       $("#box4 img").attr("src", data.target.result);
		      }
		      reader.readAsDataURL(this.files[0]);
		     }
		    });
		    </script> 
            </div>
            </div>  
            
         <c:if test="${message == 'confirm' }">
		 <script type="text/javascript">
		 alert("숙소 등록 신청이 되었습니다. 승인 결과는 승인내역에서 확인하실 수 있습니다.");
		 </script>
		 </c:if>
            
            </div>
            </div>
            <br>
            <div align="center">
            <input type="button" class="btn btn-warning" id="insert" value="숙소 등록하기">
            </div>
            </div>
            </div>
            </div> 
			</form>
  
           </div>
          </div>
         </div>
	  	 </section>
	     </div>
  		</section>


 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>