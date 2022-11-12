<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<title>Host Room Write</title>

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
<!-- flatpickr -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/rangePlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

<!-- 다음주소 -->
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 카카오 맵 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0403296c83daa74c4b2702e088a2418&libraries=services"></script>
<script type="text/javascript">
$(function(){
	var option = {
            locale: "ko", //한국어로 언어설정
            dateFormat: "Y-m-d",   //출력 설정
            allowInput : false, //사용자 정의 입력설정
            mode : "range",  //범위
            showMonths : 2, // 2개월 캘린더 표기 
            minDate : new Date().fp_incr(1), //최소 날짜, 현재시간으로 셋팅 "today"현재날짜
            plugins: [new rangePlugin({ input: "#check_out"})] //플러그인 설정 input-box 2개에 표기
        }

        $("#check_in").flatpickr(option);

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

	if(date1<today){
		alert("체크인 날짜를 확인해주십시오");
		return;
	}
	if(date2<today){
		alert("체크아웃 날짜를 확인해주십시오");
		return;
	} 
	if(date1<date2){
		console.log(date1);
		console.log(date2);
	}else{
		alert("체크인 날짜와 체크아웃 날짜를 확인해주십시오");
		return;
	}
	
	var result= confirm("등록 하시겠습니까? 승인은 평일 기준 2~3일 소요됩니다.");
	
	if(result){
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
 
function inputPrice(obj) {
    obj.value = comma(uncomma(obj.value));
    document.getElementById("room_price").value = uncomma(obj.value)
}

function input(obj) {
    obj.value = comma(uncomma(obj.value));
}

function inputAddPrice(obj) {
    obj.value = comma(uncomma(obj.value));
    document.getElementById("add_people").value = uncomma(obj.value)
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
					<!-- 호스트 메뉴 리스트 -->
					<div class="col-lg-4 mb-5 mb-lg-0">
						<%@ include file="../include/host_sidebar.jsp"%>
					</div>
      	  
      	  <!-- 숙소 작성 -->
         <div class="col-lg-8">
			
			<input type="hidden" value="${sessionScope.h_userid}">
			<form name="form1" method="post" enctype="multipart/form-data" >
			<div class="card mb-4">
            <div class="card-body">
            <br>
            <div class="small text-muted">${sessionScope.h_name}님 의</div>
            <h4 class="card-title">숙소 등록</h4>
            <div align="left" id="room_write">
            <label>숙소 이름</label>
            <input class="form-control me-2" type="text" placeholder="Room's name" name="room_name" id="room_name" maxlength="55">
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
			<input type="text" class="form-control" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="100000" />" style="text-align: center;" id="room_price_result" onkeyup="inputPrice(this)">
			<input type="hidden" name="room_price" id="room_price" value="100000">
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
			  <input type="text" class="form-control" style="text-align: center;" id="add_people_result" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="30000" />" onkeyup="inputAddPrice(this)">
			  <input type="hidden" id="add_people" name="add_people" value="30000">
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
			  <input type="text" class="form-control" style="text-align: center;" id="baths" name="baths" value="1" onkeyup="input(this)">
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
			  <input type="text" class="form-control" style="text-align: center;" id="beds" name="beds" value="1" onkeyup="input(this)">
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
			  <input type="text" class="form-control" style="text-align: center;" id="max_people" name="max_people" value="2" onkeyup="input(this)">
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
			<input type="date" class="form-control" name="check_in" id="check_in" required>
			</div>
			<label for="floatingInput">체크아웃</label>
			<div class="form-floating mb-3">
			<input type="date" class="form-control" name="check_out" id="check_out" required>
			</div>
			
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