<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- font awesome 아이콘 -->
<script src="https://kit.fontawesome.com/fdfee59c02.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- datepicker bootstrap -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
<!-- 이미지슬라이딩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<!-- 지도api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6013ab79a6af6749ee495db13ec37e86"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path }/resources/css/styles.css" rel="stylesheet" />
<link href="${path }/resources/css/datepicker.css" rel="stylesheet" />
<style type="text/css">
.mapcontainer{
padding: 10px;
}
.info-title {
    display: block;
    background: #50627F;
    color: #fff;
    text-align: center;
    height: 24px;
    line-height:22px;
    border-radius:4px;
    padding:0px 10px;
}
.top_bar_fix{
position:fixed;
top:0px;
left:0px;
}
.pd_top{
padding-top:0px;
}
#map{
position: fixed;
width: 100%;
height:100%;
}
.top_fix_zone{
height: 80px;
border-bottom: 1px solid gray;
z-index:10000;
padding:15px;
background: white;
width: 100%;
}
#optiontable td{
padding-right: 50px;
}
.checked {color: orange;}
#optionList{
font-size:18px; 
background:#ffca7d;
transition: 0.3s;
}
#optionList:hover{background: #FFA726;}

.middle {
  position: relative;
  width: 100%;
}
.slider {
  position: relative;
  z-index: 1;
  height: 10px;
}
.slider > .track {
  position: absolute;
  z-index: 1;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  border-radius: 5px;
  background-color: #ffca7d;
}
.slider > .range {
  position: absolute;
  z-index: 2;
  left: 10%;
  right: 10%;
  top: 0;
  bottom: 0;
  border-radius: 5px;
  background-color: #FFA726;
}
.slider > .thumb {
  position: absolute;
  z-index: 3;
  width: 20px;
  height: 20px;
  background-color: #FFA726;
  border-radius: 50%;
}
.slider > .thumb.left {
  left: 10%;
  transform: translate(0px, -5px); 
}
.slider > .thumb.right {
  right: 10%;
  transform: translate(0px, -5px);
}

input[type="range"] {
  position: absolute;
  /* opacity로 가린 것을 이벤트도 비활성화하기 위해 */
  pointer-events: none;
  -webkit-appearance: none;
  z-index: 2;
  height: 10px;
  width: 100%;
  opacity: 0;
}
input[type="range"]::-webkit-slider-thumb {
  /* 겹쳐진 두 thumb를 모두 활성화 */
  pointer-events: all;
  width: 20px;
  height: 20px;
  border-radius: 0;
  border: 0 none;
  background-color: red;
  cursor: pointer;
  /* appearance를 해야 위의 스타일들을 볼 수 있음 */
  -webkit-appearance: none;
}
#reviewstar input[type=radio]{
display: none;}
#reviewstar label{
font-size: 1.2em;
color: transparent;
text-shadow: 0 0 0 #f0f0f0;
}
#reviewstar label:hover{
text-shadow: 0 0 0 #FFA726;}
#reviewstar label:hover ~ label{
 text-shadow: 0 0 0 #FFA726;
}
#reviewstar input[type=radio]:checked ~ label{
text-shadow: 0 0 0 #FFA726;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	//옵션선택바 고정
	var topBar = $("#topBar").offset();
	$(window).scroll(function(){
		var docScrollY = $(document).scrollTop();
		var barThis = $("#topBar");
		var fixNext = $("#fixNextTag");
		if( docScrollY > topBar.top ) {
		 barThis.addClass("top_bar_fix");
		 fixNext.addClass("pd_top");
		}else{
			barThis.removeClass("top_bar_fix");
			fixNext.removeClass("pd_top");
		}
	});
	//가격범위
	const inputLeft = document.getElementById("input-left");
	const inputRight = document.getElementById("input-right");
	document.getElementById("lower_price").innerHTML=priceToString(inputLeft.value);
	document.getElementById("higher_price").innerHTML=priceToString(inputRight.value);
	const thumbLeft = document.querySelector(".slider > .thumb.left");
	const thumbRight = document.querySelector(".slider > .thumb.right");
	const range = document.querySelector(".slider > .range");
	const setLeftValue = () => {
	  const _this = inputLeft;
	  const [min, max] = [parseInt(_this.min), parseInt(_this.max)];
	  // 교차되지 않게, 1을 빼준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
	  _this.value = Math.min(parseInt(_this.value), parseInt(inputRight.value) - 1);
	  // input, thumb 같이 움직이도록
	  const percent = ((_this.value - min) / (max - min)) * 100;
	  thumbLeft.style.left = percent + "%";
	  range.style.left = percent + "%";
	};

	const setRightValue = () => {
	  const _this = inputRight;
	  const [min, max] = [parseInt(_this.min), parseInt(_this.max)];
	  // 교차되지 않게, 1을 더해준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
	  _this.value = Math.max(parseInt(_this.value), parseInt(inputLeft.value) + 1);
	  // input, thumb 같이 움직이도록
	  const percent = ((_this.value - min) / (max - min)) * 100;
	  thumbRight.style.right = 100 - percent + "%";
	  range.style.right = 100 - percent + "%";
	};
	inputLeft.addEventListener("input", setLeftValue);
	inputRight.addEventListener("input", setRightValue);
	//값 변할때마다 적용시키기
	inputLeft.oninput = function() {
		document.getElementById("lower_price").innerHTML = priceToString(this.value);
    }
	inputRight.oninput = function() {
		document.getElementById("higher_price").innerHTML = priceToString(this.value);
    }
});
function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
$(function(){
	var star = "${map.reviewStar}";
	var bed = "${map.bed}";
	var bath = "${map.bath}";
	var lower = Number("${map.lower}");
	var higher = Number("${map.higher}");
if(star!=""){
	$("#rate"+star).prop("checked",true);
}
if(bed!=""){
	$("#bedoption").val(bed).prop("selected",true);
}
if(bath!=""){
	$("#bathoption").val(bath).prop("selected",true);
}
if(lower!="100000"||higher!="900000"){
	$("#rangebar").css("left",(lower/1000000)*100+"%");
	$("#rangebar").css("right",((1000000-higher)/1000000)*100+"%");
	$("#leftbar").css("left",(lower/1000000)*100+"%");
	$("#rightbar").css("right",((1000000-higher)/1000000)*100+"%");
}
//날짜 선택설정
$('.input-daterange').datepicker({
	format : 'yyyy-mm-dd',
	todayHighlight : true,
	startDate : '0d'
});
//지도출력
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(35.8773582, 128.6042956), //지도의 중심좌표.
	level: 8 //지도의 레벨(확대, 축소 정도)
};
var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴


//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
var mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);


//불러온 json배열을 저장
var adrList =JSON.parse('${map.adrlist}');

var adrArray = [];
for(var k in adrList){
    var $obj = adrList[k];
    adrArray.push({
    	content : '<div style="height:155px;padding:5px;">'+
    	'<img src="${path}/images/'+$obj.photo1+'"style="width:100%;height:100px;"><br>'+
    	'<span style="font-size:12px;"><b>'+$obj.room_name+'</b></span><br>'+
    	'<span style="font-size:12px;">'+$obj.room_price.toLocaleString()+'원</span></div>',
    	latlng: new kakao.maps.LatLng($obj.lat,$obj.lng),
    	price: $obj.room_price
    });
}
for (var i = 0; i < adrArray.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: adrArray[i].latlng // 마커의 위치
    });
    map.setCenter(adrArray[i].latlng);
    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: adrArray[i].content // 인포윈도우에 표시할 내용
    });
    var mLabel = new daum.maps.InfoWindow({
        position: adrArray[i].latlng,
        content: '<span class="info-title">'+adrArray[i].price.toLocaleString()+'원</span>' // 인포윈도우 내부에 들어갈 컨텐츠 
    });
    mLabel.open(map,marker);
    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}
// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}
// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
var infoTitle = document.querySelectorAll('.info-title');
infoTitle.forEach(function(e) {
    var w = e.offsetWidth + 10;
    var ml = w/2;
    e.parentElement.style.top = "82px";
    e.parentElement.style.left = "50%";
    e.parentElement.style.marginLeft = -ml+"px";
    e.parentElement.style.width = w+"px";
    e.parentElement.previousSibling.style.display = "none";
    e.parentElement.parentElement.style.border = "0px";
    e.parentElement.parentElement.style.background = "unset";
	});
});
//옵션변경
function changeoption(){
	var cityname = $("#cityname").val();
	if(cityname == ""){
		alert("지역명을 먼저 입력해주세요."); $("#cityname").focus(); return;
	}
	$("#optionform").submit();
}

</script>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
	<!-- 본문영역 -->
<section class="py-4" id="features"> 
<div class="mapcontainer">
	<!--검색바  -->
	<form autocomplete="off" id="optionform" name="form1" method="get"	action="${path}/search/listMap.do">
    <div class="flex-sm-row flex-column d-flex">
      <div class="form-floating">
      <input type="text" class="form-control" name="cityname" id="cityname" value="${map.cityname }" placeholder="지역명을 입력하세요" size="60"
      style="text-align: center;">
      <label for="cityname">지역명을 입력하세요</label>
     </div>
     <div class="input-group input-daterange">
        <div class="form-floating">
          <input type="text" class="form-control" id="checkin_date"name="checkin_date" value="${map.checkin_date }"placeholder="체크인" readonly style="text-align: right;">
          <label for="floatingInput">체크인</label>
          </div>
          <div class="form-floating">
          <input type="text" class="form-control" id="checkout_date" name="checkout_date" value="${map.checkout_date }"placeholder="체크아웃" readonly style="text-align: right;">
          <label for="floatingInput">체크아웃</label>
          </div>
        <button type="submit" class="btn" style="background:#FFA726; width:60px;"><i class="fa-solid fa-magnifying-glass"></i></button>
        </div>
    </div>
  <div class="top_fix_zone" id="topBar">
  <table id="optiontable">
   <tr>
    <td rowspan="2">
 	 <button type="button" id="optionList" class="btn btn-lg" >리스트로 이동</button>
    </td>
    <td>후기 평점</td>
    <td>가격 검색(원) </td>
    <td>침대 수</td>
    <td>욕실 수</td>
   </tr>
   <tr>
   <td>
    <div id="reviewstar">
     <input type="radio" name="reviewStar" value="5" id="rate5" onclick="changeoption()"><label	for="rate5" class="fa fa-star"></label>
	 <input type="radio" name="reviewStar" value="4" id="rate4" onclick="changeoption()"><label for="rate4" class="fa fa-star"></label>
	 <input type="radio" name="reviewStar" value="3" id="rate3" onclick="changeoption()"><label for="rate3" class="fa fa-star"></label>
	 <input type="radio" name="reviewStar" value="2" id="rate2" onclick="changeoption()"><label for="rate2" class="fa fa-star"></label>
	 <input type="radio" name="reviewStar" value="1" id="rate1" onclick="changeoption()"><label for="rate1" class="fa fa-star"></label>
    </div>
   </td>
   <td style="width: 300px;">
	 <div class="middle">
  <div class="multi-range-slider">
    <input type="range" name="lower" id="input-left" min="0" max="1000000" value="${map.lower }" onchange="changeoption()"/>
    <input type="range" name="higher"id="input-right" min="0" max="1000000" value="${map.higher }" onchange="changeoption()"/>
    <div class="slider">
      <div class="track"></div>
      <div class="range" id="rangebar"></div>
      <div class="thumb left" id="leftbar" ></div>
      <div class="thumb right" id="rightbar"></div>
    </div>
    <span style="float:left;font-size: 11px;" id="lower_price"></span>
    <span style="float:right;font-size:11px;" id="higher_price" ></span>
  </div>
</div>
   </td>
   <td>
   <select id="bedoption" name="bed" class="form-select form-select-sm" aria-label=".form-select-sm" onchange="changeoption()">
    <option selected value="0"disabled>선택</option>
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4개이상</option>
   </select>
   </td>
   <td>
    <select id="bathoption" name="bath" class="form-select form-select-sm" aria-label=".form-select-sm" onchange="changeoption()">
    <option selected value="0" disabled>선택</option>
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4개이상</option>
   </select>
   </td>
   </tr>
  </table>
  </div>
 </form>
  <!--리스트 영역  -->
	<div class="row" id="fixNextTag">
		<div class="col-3" style="background: #f9fafb;">
		  총 <b style="color:#FFA726;">${map.count }개</b>의 숙소가 검색되었습니다.
		   <c:forEach var="room" items="${map.list }"> 
		     <div class="col mt-2 mb-2" style="background: #f9fafb;">
                        <div class="card h-100">
                            <!-- Product image-->
								<div class="bxslider">
									<div><img class="card-img-top"src="${path }/images/${room.photo1}" title="${room.address1 }"></div>
									<div><img class="card-img-top"src="${path }/images/${room.photo2}" title="${room.address1 }"></div>
									<div><img class="card-img-top"src="${path }/images/${room.photo3}" title="${room.address1 }"></div>
									<div><img class="card-img-top"src="${path }/images/${room.photo4}" title="${room.address1 }"></div>
								</div>
								<script>
									$('.bxslider').bxSlider({
										mode : 'horizontal',
										captions : true,
										slideWidth : 600,
										caption:true
									});
								</script>
								<!-- Product details-->
                            <div class="card-body p-1">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${room.room_name }</h5>
                                    <div class="d-flex justify-content-center small fw-bolder mb-2" style="color:#848484;">
                                    (최소인원: ${room.max_people}명 / 침대수: ${room.beds }개 / 욕실수: ${room.baths }개)</div>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                     <c:forEach var="i" begin="1" end="${room.review_star }">
                                        <div class="bi-star-fill"></div>
                                     </c:forEach>
                                     <c:forEach var="i" begin="${room.review_star +1}" end="5">
                                        <div class="bi-star"></div>
                                     </c:forEach> 
                                     <span style="color:black;">(후기: ${room.review_count }개)</span>
                                    </div>
                                    <!-- Product price-->
                                    <span class="text-muted" style="font-weight:bold;">
                                    <fmt:formatNumber value="${room.room_price}" pattern="#,###" />원</span>
                                </div>
                            </div>
                        </div>
                    </div>
		        </c:forEach> 
		</div>
		<div class="col-9" style="background: #f9fafb;">
		<div id="map"></div>
		</div>
	</div>
  </div>
 </section> 
</main>
<!--footer -->
 <!-- Bootstrap core JS-->
	 <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="${path }/resources/js/scripts.js"></script>
	<!-- Footer-->
</body>
</html>