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
#profile1 {
    width: 100%;
    height: 100%;
    object-fit: cover;
    background-color: gray;
    background-color: #c3c3c3;
}
#box2, #box3, #box4 {
	width: 300px;
    border-radius: 2%;
    overflow: hidden;
}
#photo_2, #photo_3, #photo_4  {
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

$("#update").click(function(){
	room_name=$("#room_name").val();
	contents=$("#contents").val();
	room_type=$("#room_type").val();
	address1=$("#address1").val();
	address2=$("#address2").val(); 
	room_price=$("#room_price_result").val();
	add_people=$("#add_people_result").val();
	baths=$("#baths").val();
	beds=$("#beds").val();
	max_people=$("#max_people").val();
	photo1=$("#photo1").val();
	photo2=$("#photo2").val();
	photo3=$("#photo3").val();
	photo4=$("#photo4").val();
	check_in=$("#check_in").val();
	check_out=$("#check_out").val();	
	
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
	if(check_in==""){
		alert("체크인 날짜를 등록해주세요 ");
		$("#check_in").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	if(check_out==""){
		alert("체크아웃 날짜를 등록해주세요");
		$("#check_out").focus(); //입력 포커스 이동
		return; //함수 종료
	}
	today = new Date();
	date1 = new Date(check_in);
	date2 = new Date(check_out);
	
	days = date1.getTime() - date2.getTime() ;
	btDays = days / (1000*60*60*24) ;
	
	checkin = date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();
	checkout = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
	
	rToday = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();

	if(date1<today){
		alert("체크인 날짜를 확인해주십시오");
		return;
	}
	if(date2<today){
		alert("체크아웃 날짜를 확인해주십시오");
		return;
	}

	if(rToday==checkin){
		 alret("당일은 체크인으로 설정할 수 없습니다. \n다시 선택해주십시오.");
	}
	if(rToday==checkout){
		 alret("당일은 체크아웃으로 설정할 수 없습니다. \n다시 선택해주십시오.");
	}
	if(date1<date2){
		console.log(checkin+"~"+checkout+"\n"+btDays+"일 입니다.");
	}else{
		alert("체크인 날짜와 체크아웃 날짜를 확인해주십시오");
		return;
	}
	
	var result= confirm("수정 하시겠습니까?");
	if(result){
	document.form1.action="${path}/rooms/update/${dto.room_idx}";
	document.form1.submit();
	}

	});
	
$("#deleteRoom").click(function(){
	var result= confirm("삭제요청하시겠습니까?")
	if(result){
		alert("삭제요청이 되었습니다.")
		document.form1.action="${path}/rooms/delete/${dto.room_idx}";
		document.form1.submit();
	}
})
	
});
function fileCheck(el) { 
    if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
    alert('이미지 파일만 업로드 가능합니다.'); 
    el.value = ''; 
    el.focus(); 
   }
 }
 

function inputPrice(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
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
    	  <p class="lead" ><a href="${path}/host/profile/${sessionScope.h_userid}"><b style="font-weight: 700;">프로필</b></a></p>
    	  <p class="lead" ><a href="${path}/host/edit.do">회원정보수정</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_List.do">숙소관리</a></p>
    	  <p class="lead" ><a href="${path}/rooms/write.do">숙소등록</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Confirm.do">숙소승인현황</a></p>
    	  <p class="lead" ><a>예약현황</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}">매출현황</a></p>
 	      <p class="lead" ><a href="${path}/host/delete.do">회원 탈퇴</a></p>
   	     </div>
      	  
      	  <!-- 숙소 작성 -->
         <div class="col-lg-8">
			
			<input type="hidden" value="${sessionScope.h_userid}">
			<form name="form1" method="post" enctype="multipart/form-data">
			<input type="hidden" name="room_idx" value="${dto.room_idx}" id="room_idx">
			<div align="right" style="color: red; font-size: 13px;">
			<button type="button" class="btn btn-outline-danger" style="border: none;" id="deleteRoom">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
 			<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"></path>
			</svg></button></div>
			<div class="card mb-4">
            <div class="card-body">
            <br>
            <div class="small text-muted">${sessionScope.h_name}님 의</div>
            <h4 class="card-title">숙소 수정</h4>
            <div align="left" id="room_write">
            <label>숙소 이름</label>
            <input class="form-control me-2" type="text" placeholder="Room's name" name="room_name" id="room_name" value="${dto.room_name}" maxlength="65">
            <br>
            <label>소개글</label>
            <%pageContext.setAttribute("n", "\n"); pageContext.setAttribute("br", "<br>");%> 
            <textarea class="form-control" rows="3" style="height: 100px;" id="contents" name="contents">${fn:replace(dto.contents,br,n)}</textarea>
            <br>
            <label>타입</label>
			<select class="form-select" aria-label="Default select example" id="room_type" name="room_type">
			  <option value="주택" <c:if test="${dto.room_type eq '주택'}">selected</c:if>>주택</option>
			  <option value="레지던스" <c:if test="${dto.room_type eq '레지던스'}">selected</c:if>>레지던스</option>
			  <option value="아파트" <c:if test="${dto.room_type eq '아파트'}">selected</c:if> >아파트</option>
			  <option value="호텔" <c:if test="${dto.room_type eq '호텔'}">selected</c:if> >호텔</option>
			  <option value="펜션" <c:if test="${dto.room_type eq '펜션'}">selected</c:if> >펜션</option>
			</select>
            <br>
			
 			<label>주소</label>
			<input type="text" name="address1" id="address1" class="form-control me-2" placeholder="Room's address" value="${dto.address1}">
			<input type="hidden" name="lat" value="${dto.lat}">
			<input type="hidden" name="lng" value="${dto.lng}">
			<br>
 			<div class="input-group mb-2" align="center">
			<input type="text" name="zipcode" id="zipcode" class="form-control me-2" placeholder="우편번호" style="width: 20%;" value="${dto.zipcode}">
			<input type="text" name="address2" id="address2" class="form-control me-2" placeholder="상세주소" style="width: 75%;" value="${dto.address2}"> 
			</div>
			<br>			
			<input type="hidden" name="city" id="city" class="form-control me-2" placeholder="city" style="width: 75%;" value="${dto.city}">
			<input type="hidden" name="country" id="country" class="form-control me-2" placeholder="country" style="width: 20%;" value="${dto.country}">

	        <label>숙소 가격</label>
			<div class="input-group mb-3">
			<button class="btn-warning" id="minus1" type="button">-</button>
			<input type="text" class="form-control" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.room_price}" />" style="text-align: center;" id="room_price_result" onkeyup="inputPrice(this)">
			<input type="hidden" name="room_price" id="room_price" value="${dto.room_price}">
			<button class="btn-warning" id="plus1" type="button">+</button>
			</div>
			 <script>
			  $("#plus1").click(function(){
			   var price = $("#room_price_result").val();
			   num = price.replace(/[^\d]+/g, '');
			   var plusNum = Number(num) + 1000;
		       str = String(plusNum);
 			   result = str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			   $("#room_price_result").val(result);
			   $("#room_price").val(plusNum);
			  });
			  
			  $("#minus1").click(function(){
			   var price = $("#room_price_result").val();
			   num = price.replace(/[^\d]+/g, '');
			   var minusNum = Number(num) - 1000;
		       str = String(minusNum);
 			   result = str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');		   
			   $("#room_price_result").val(result);  
			   $("#room_price").val(minusNum);
			  });
			 </script>
 

			<br>
            <label>1인당 추가금액</label>
			<div class="input-group mb-3">
			  <button class="btn-warning" id="minus2" type="button">-</button>
			  <input type="text" class="form-control" style="text-align: center;" id="add_people_result" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.add_people}" />" onkeyup="inputPrice(this)">
			  <input type="hidden" id="add_people" name="add_people" value="${dto.add_people}">
			  <button class="btn-warning" id="plus2" type="button">+</button>
			</div>
			 <script>
			  $("#plus2").click(function(){
			   var price = $("#add_people_result").val();
			   num = price.replace(/[^\d]+/g, '');
			   var plusNum = Number(num) + 1000;
		       str = String(plusNum);
 			   result = str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			   $("#add_people_result").val(result);
			   $("#add_people").val(plusNum);			   
			  });
			  
			  $("#minus2").click(function(){
			   var price = $("#add_people_result").val();
			   num = price.replace(/[^\d]+/g, '');
			   var minusNum = Number(num) - 1000;
		       str = String(minusNum);
 			   result = str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');		   
			   $("#add_people_result").val(result);  
			   $("#add_people").val(minusNum);			   
			  });
			 </script>
			
			<br>
            <label>화장실 갯수</label>
			<div class="input-group mb-3">
			  <button class="btn-warning" id="minus3" type="button">-</button>
			  <input type="text" class="form-control" style="text-align: center;" id="baths" name="baths" value="${dto.baths}" onkeyup="inputPrice(this)">
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
			  <input type="text" class="form-control" style="text-align: center;" id="beds" name="beds" value="${dto.beds}" onkeyup="inputPrice(this)">
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
			  <input type="text" class="form-control" style="text-align: center;" id="max_people" name="max_people" value="${dto.max_people}" onkeyup="inputPrice(this)">
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
			<label for="floatingInput">체크인</label>
			<div class="form-floating mb-3">
			<input type="date" class="form-control"  value="${dto.check_in}" name="check_in" id="check_in" required>
			</div>
			<label for="floatingInput">체크아웃</label>
			<div class="form-floating mb-3">
			<input type="date" class="form-control"  value="${dto.check_out}" name="check_out" id="check_out" required>
			</div>
			<br>
			<br>
 			<div class="row gx-4">
            <div class="col-md-6" style="height: 100%; ">
            <p class="lead" style="text-align: center; font-size: 12px;">대표 이미지 설정</p>
            <div id="box1">
           <label for="photo1">
            <img class="card-img-top mb-5 mb-md-0" src="${path}/imgUpload/${dto.photo1}" id="photo_1" style="height: 300px;">
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
            <img class="card-img-top mb-5 mb-md-0" src="${path}/imgUpload/${dto.photo2}" id="photo_2" style="height: 100px; width: 300px;">
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
            <img class="card-img-top mb-5 mb-md-0" src="${path}/imgUpload/${dto.photo3}" id="photo_3" style="height: 100px; width: 300px;">
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
            <img class="card-img-top mb-5 mb-md-0" src="${path}/imgUpload/${dto.photo4}" id="photo_4" style="height: 100px; width: 300px;">
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
			<c:if test="${dto.admin_confirm =='승인대기'}">
			<input type="hidden" value="승인대기" name="admin_confirm" id="admin_confirm">
			</c:if>
			<c:if test="${dto.admin_confirm =='승인'}">
			<input type="hidden" value="승인" name="admin_confirm" id="admin_confirm">
			</c:if>
            
            <input type="hidden" value="${dto.photo1}" name="photo1">
            <input type="hidden" value="${dto.photo2}" name="photo2">
            <input type="hidden" value="${dto.photo3}" name="photo3">
            <input type="hidden" value="${dto.photo4}" name="photo4">
            
            </div>
            </div>
            <br>
            <div align="center">
            <input type="button" class="btn btn-warning" id="update" value="숙소 수정하기">
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