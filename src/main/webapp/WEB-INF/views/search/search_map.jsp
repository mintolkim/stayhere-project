
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>
<!-- flatpickr  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/rangePlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<!-- 이미지슬라이딩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<!-- 지도api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6013ab79a6af6749ee495db13ec37e86"></script>
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
.map_fix{
position:fixed;
top: 80px;}
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
  left: 12%;
  right: 12%;
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
/* 검색 자동완성 */
.autocomplete {
  /*the container must be positioned relative:*/
  position: relative;
  display: inline-block;
}
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  /*position the autocomplete items to be the same width as the container:*/
  top: 100%;
  left: 0;
  right: 0;
}
.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff;
  border-bottom: 1px solid #d4d4d4;
}
.autocomplete-items div:hover {
  /*when hovering an item:*/
  background-color: #e9e9e9;
}
.autocomplete-active {
  /*when navigating through the items using the arrow keys:*/
  background-color: DodgerBlue !important;
  color: #ffffff;
}


</style>
<script type="text/javascript">
$(document).ready(function(){
	//검색바
	 var option = {
             locale: "ko", //한국어로 언어설정
             dateFormat: "Y-m-d",   //출력 술정
             allowInput : false, //사용자 정의 입력설정
             mode : "range",  //범위
             showMonths : 2, // 2개월 캘린더 표기 
             minDate : new Date().fp_incr(1), //최소 날짜, 현재시간으로 셋팅 "today"현재날짜
             plugins: [new rangePlugin({ input: "#checkout_date"})] //플러그인 설정 input-box 2개에 표기
         }
     $("#checkin_date").flatpickr(option);
	
	//옵션선택바 고정
	var topBar = $("#topBar").offset();
	$(window).scroll(function(){
		var docScrollY = $(document).scrollTop();
		var barThis = $("#topBar");
		var fixNext = $("#fixNextTag");
		var map = $("#map");
		if( docScrollY > topBar.top ) {
		 barThis.addClass("top_bar_fix");
		 fixNext.addClass("pd_top");
		 map.addClass("map_fix");
		}else{
			barThis.removeClass("top_bar_fix");
			fixNext.removeClass("pd_top");
			 map.removeClass("map_fix");
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
//검색 옵션
	var star = Math.floor("${map.reviewStar}");
	var people = "${map.max_people}"
	var bed = "${map.bed}";
	var bath = "${map.bath}";
	var lower = Number("${map.lower}");
	var higher = Number("${map.higher}");
	var align = "${map.align}";
if(star!=""){
	$("#rate"+star).prop("checked",true);
}
if(people!=""){
	$("#peopleoption").val(people).prop("selected",true);
}
if(bed!=""){
	$("#bedoption").val(bed).prop("selected",true);
}
if(bath!=""){
	$("#bathoption").val(bath).prop("selected",true);
}
if(align!=""){
	$("#alignoption").val(align).prop("selected",true);
}
if(lower!="100000"||higher!="900000"){
	$("#rangebar").css("left",(lower/1000000)*100+"%");
	$("#rangebar").css("right",((1000000-higher)/1000000)*100+"%");
	$("#leftbar").css("left",(lower/1000000)*100+"%");
	$("#rightbar").css("right",((1000000-higher)/1000000)*100+"%");
}
//지도출력
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(35.8773582, 128.6042956), //지도의 중심좌표.
	level: 8 //지도의 레벨(확대, 축소 정도)
};
var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
$("#hiddenmap").val(map);

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
    	'<img src="${path}/imgUpload/'+$obj.photo1+'"style="width:100%;height:100px;"><br>'+
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
    $("#marker"+i).val(marker);
    map.setCenter(adrArray[i].latlng);
    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: adrArray[i].content // 인포윈도우에 표시할 내용
    });
    $("#infowindow"+i).val(infowindow);
    var mLabel = new daum.maps.InfoWindow({
        position: adrArray[i].latlng,
        content: '<span class="info-title">'+adrArray[i].price.toLocaleString()+'원</span>' // 인포윈도우 내부에 들어갈 컨텐츠 
    });
    mLabel.open(map,marker);
    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
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
//모달창 닫기
$(".btn-close").click(function(){
	$(".modal").fadeOut();
});
});
//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
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
//옵션변경
function changeoption(){
	var cityname = $("#cityname").val();
	var checkin_date = $("#checkin_date").val();
	var checkout_date = $("#checkout_date").val();
	if(cityname == ""){
		alert("지역명을 먼저 입력해주세요."); $("#cityname").focus(); return;
	}
	if(checkin_date == ""){
		alert("출발일을 먼저 설정해주세요."); $("#checkin_date").focus(); return;
	}
	if(checkout_date == ""){
		alert("도착일을 먼저 설정해주세요."); $("#checkout_date").focus(); return;
	}
	$("#optionform").attr("action","${path}/search/map/"+cityname+"/"+checkin_date+"/"+checkout_date);
	$("#optionform").submit();
}
function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
//리스트 페이지로 이동하기
function goTolist(){
	const param = location.search; //현재 주소URL에 있는 파라미터 값 가져오기 
	location.href = "${path}/search/${map.cityname}/${map.checkin_date}/${map.checkout_date}" + param;
}
//리뷰모달 열기
function reviewDetail(room_idx,index){
	$.ajax({
		type: 'POST',
		url: "${path }/admin/roomreview",
		data:{"room_idx":room_idx},
		success: function(result){
			if(result!=null)
			$("#reviewbody"+index).html(result);
		},
		error: function(result){
			alert("오류");
		}
	});
	var y = index;
	$("#reviewmodal"+y).fadeIn();
}
$(function(){
/* 검색 자동완성 */
 function autocomplete(inp, arr) {
	  var currentFocus;
	  inp.addEventListener("input", function(e) {
	      var a, b, i, val = this.value;
	      closeAllLists();
	      if (!val) { return false;}
	      currentFocus = -1;
	      a = document.createElement("DIV");
	      a.setAttribute("id", this.id + "autocomplete-list");
	      a.setAttribute("class", "autocomplete-items");
	      this.parentNode.appendChild(a);
	      for (i = 0; i < arr.length; i++) {
	        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
	          b = document.createElement("DIV");
	          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
	          b.innerHTML += arr[i].substr(val.length);
	          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
	              b.addEventListener("click", function(e) {
	              inp.value = this.getElementsByTagName("input")[0].value;
	              closeAllLists();
	          });
	          a.appendChild(b);
	        }
	      }
	  });
	  inp.addEventListener("keydown", function(e) {
	      var x = document.getElementById(this.id + "autocomplete-list");
	      if (x) x = x.getElementsByTagName("div");
	      if (e.keyCode == 40) {
	        currentFocus++;
	        addActive(x);
	      } else if (e.keyCode == 38) { //up
	        currentFocus--;
	        addActive(x);
	      } else if (e.keyCode == 13) {
	        e.preventDefault();
	        if (currentFocus > -1) {
	          if (x) x[currentFocus].click();
	        }
	      }
	  });
	  function addActive(x) {
	    if (!x) return false;
	    removeActive(x);
	    if (currentFocus >= x.length) currentFocus = 0;
	    if (currentFocus < 0) currentFocus = (x.length - 1);
	    x[currentFocus].classList.add("autocomplete-active");
	  }
	  function removeActive(x) {
	    for (var i = 0; i < x.length; i++) {
	      x[i].classList.remove("autocomplete-active");
	    }
	  }
	  function closeAllLists(elmnt) {
	    var x = document.getElementsByClassName("autocomplete-items");
	    for (var i = 0; i < x.length; i++) {
	      if (elmnt != x[i] && elmnt != inp) {
	      x[i].parentNode.removeChild(x[i]);
	    }
	  }
	}
	document.addEventListener("click", function (e) {
	    closeAllLists(e.target);
	});
	}
 var searchList =JSON.parse('${map.searchlist}');
 
 autocomplete(document.getElementById("cityname"), searchList);

});
function wishList(index,room_idx){
	var userid = '${sessionScope.userid}';
	 if(userid != ""){
	    	if(confirm("위시리스트에 추가하시겠습니까?")){
	    		$.ajax({
	    			type: "get",
	    			url: "${path}/wishlist/wishplus",
	    			data : {
	    				"room_idx" : room_idx,
	    				"userid" : userid
	    			},
	    			success : function(res){
	    				if(res=1){
	    				$("#wishlist"+index).html("");
	    				$("#wishlist"+index).html("<i class='bi-heart-fill text-danger fw-bold fs-5'></i>");
	    				}
	    			}
	    		});
	    	}
	    } else {
	    	if(confirm("로그인 하셔야 위시리스트 기능이 가능합니다.\n 로그인 페이지로 이동하시겠습니까?")){
	    		location.href="${path}/guest/login.do";
	    	}
	    }
}
function deleteWish(index,room_idx){
	var userid = '${sessionScope.userid}';
	 if(userid != ""){
	    	if(confirm("위시리스트에서 삭제하시겠습니까?")){
	    		$.ajax({
	    			type: "get",
	    			url: "${path}/wishlist/deleteWish",
	    			data : {
	    				"room_idx" : room_idx,
	    				"userid" : userid
	    			},
	    			success : function(res){
	    				if(res=1){
	    				$("#deleteWish"+index).html("");
	    				$("#deleteWish"+index).html("<i class='bi-heart text-danger fw-bold fs-5'></i>");
	    				}
	    			}
	    		});
	    	}
	    } 
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
    <!-- search-bar -->
	<div class="search-wrap search-fixed">
		<div class="search-bar border px-4">
				<div class="row">
					<div class="col-lg-5 col-sm-5 col-12 d-flex align-items-center rounded-pill">
						<form autocomplete="off" >
						<div class="form-floating form-group w-100 autocomplete">
							<input class="form-control border-0 shadow-none " id="cityname"
								name="cityname" placeholder="여행지를 입력해주세요" value="${map.cityname}"> 
								<label for="cityname">여행지 입력</label>
						</div>
						</form>
					</div>
					<div class="col-lg-3 col-sm-3 col-5 d-flex align-items-center">
						<div class="form-floating form-group w-100">
							<input class="form-control border-0 shadow-none" id="checkin_date"
								name="checkin_date" placeholder="체크인" value="${map.checkin_date}"> 
								<label for="checkin_date">체크인</label>
						</div>
					</div>
					<div class="col-lg-3 col-sm-3 col-5 d-flex align-items-center">
						<div class="form-floating form-group w-100">
							<input class="form-control border-0 shadow-none" id="checkout_date"
								name="checkout_date" placeholder="체크아웃" value="${map.checkout_date}">
							<label for="checkout_date">체크아웃</label>
						</div>
					</div>
					<div class="col-lg-1 col-sm-1 col-2 d-flex align-items-center">
						<button class="btn btn-custom rounded-pill" type="button"
							onclick="changeoption()">
							<i class="bi-search"></i>
						</button>
					</div>
				</div>
		</div>
		</div>
  <div class="top_fix_zone" id="topBar">
  <form autocomplete="off" id="optionform" name="form1" method="get">
  <table id="optiontable">
   <tr>
    <td rowspan="2">
 	 <button type="button" id="optionList" onclick="goTolist()" class="btn btn-lg" >리스트로 이동</button>
    </td>
    <td>후기 평점</td>
    <td>가격 검색(원) </td>
    <td>인원 수 </td>
    <td>침대 수</td>
    <td>욕실 수</td>
    <td>정렬선택</td>
   </tr>
   <tr>
   <td>
    <div id="reviewstar">
    <input type="radio" name="reviewStar" value="5" id="rate5" onclick="changeoption()"><label	for="rate5" class="bi bi-star-fill"></label>
	 <input type="radio" name="reviewStar" value="4" id="rate4" onclick="changeoption()"><label for="rate4" class="bi bi-star-fill"></label>
	 <input type="radio" name="reviewStar" value="3" id="rate3" onclick="changeoption()"><label for="rate3" class="bi bi-star-fill"></label>
	 <input type="radio" name="reviewStar" value="2" id="rate2" onclick="changeoption()"><label for="rate2" class="bi bi-star-fill"></label>
	 <input type="radio" name="reviewStar" value="1" id="rate1" onclick="changeoption()"><label for="rate1" class="bi bi-star-fill"></label>
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
    <select id="peopleoption" name="max_people" class="form-select form-select-sm" aria-label=".form-select-sm" onchange="changeoption()">
    <option selected value="0" disabled>선택</option>
    <option value="2">2명</option>
    <option value="3">3명</option>
    <option value="4">4명이상</option>
   </select>
   </td>
   <td>
   <select id="bedoption" name="bed" class="form-select form-select-sm" aria-label=".form-select-sm" onchange="changeoption()">
    <option selected value="0"disabled>선택</option>
    <option value="1">1개</option>
    <option value="2">2개</option>
    <option value="3">3개</option>
    <option value="4">4개이상</option>
   </select>
   </td>
   <td>
    <select id="bathoption" name="bath" class="form-select form-select-sm" aria-label=".form-select-sm" onchange="changeoption()">
    <option selected value="0" disabled>선택</option>
    <option value="1">1개</option>
    <option value="2">2개</option>
    <option value="3">3개</option>
    <option value="4">4개이상</option>
   </select>
   </td>
	<td>
	<select class="form-select form-select-sm" id="alignoption" name="align" onchange="changeoption()">
	 <option value="room_idx">최신순</option>
	 <option value="review_count">리뷰순</option>
	 <option value="res_count">예약순</option>
	 <option value="room_price">가격순</option>
	</select>
	</td>
	</tr>
  </table>
 </form>
  </div>
  <!--리스트 영역  -->
	<div class="row" id="fixNextTag">
		<div class="col-3" style="background: #f9fafb;">
		  총 <b style="color:#FFA726;">${map.count }개</b>의 숙소가 검색되었습니다.
		   <c:forEach var="room" items="${map.list }" varStatus="vs"> 
		     <div class="col mt-2 mb-2" style="background: #f9fafb;">
                        <div class="card h-100" >
                            <!-- Product image-->
								<a href="${path}/rooms/detail/${room.room_idx}">
								<div class="bxslider">
									<div><img class="card-img-top" src="${path }/imgUpload/${room.photo1}" 
									title="${room.address1 }" style="height: 280px;"></div>
									<div><img class="card-img-top" src="${path }/imgUpload/${room.photo2}" 
									title="${room.address1 }" style="height: 280px;"></div>
									<div><img class="card-img-top" src="${path }/imgUpload/${room.photo3}" 
									title="${room.address1 }" style="height: 280px;"></div>
									<div><img class="card-img-top" src="${path }/imgUpload/${room.photo4}" 
									title="${room.address1 }" style="height: 280px;"></div>
								</div></a>
								<script type="text/javascript">
									$('.bxslider').bxSlider({
										mode : 'horizontal',
										captions : true,
										slideWidth : 600,
										caption:true
									});
								</script>
								<c:if test="${room.wishcheck == 0 }">
								 <div class="btn boder-0 shadow-none card-img-overlay-top text-end"
								onclick="wishList(${vs.index }, ${room.room_idx})" id="wishlist${vs.index }">
									<i class="bi-heart text-danger fw-bold fs-5" ></i>
								   </div>
								</c:if>
								<c:if test="${room.wishcheck > 0 }">
								  <div class="btn boder-0 shadow-none card-img-overlay-top text-end"
								  onclick="deleteWish(${vs.index }, ${room.room_idx})" id="deleteWish${vs.index }">
									<i class="bi-heart-fill text-danger fw-bold fs-5" ></i>
								   </div>
								</c:if>
								
								<!-- Product details-->
                            <div class="card-body p-1">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${room.room_name }</h5>
                                    <div class="d-flex justify-content-center small mb-2" style="color:#848484;">
                                    <i class="bi bi-check-square-fill pe-1"> 침대	${room.beds} · 욕실 ${room.baths} · 최대인원 ${room.max_people}</i></div>
                                     <div class="d-flex justify-content-center small mb-2" style="color:#848484;">
                                    <i class="bi bi-calendar-check pe-1"> 
                                     <fmt:formatDate pattern="MM월 dd일" value="${room.check_in}" /> <span>~</span>
									 <fmt:formatDate pattern="MM월 dd일" value="${room.check_out}" /></i></div>
											
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                     <c:forEach var="i" begin="1" end="${room.review_star }">
                                        <div class="bi-star-fill"></div>
                                     </c:forEach>
                                     <c:forEach var="i" begin="${room.review_star +1}" end="5">
                                        <div class="bi-star"></div>
                                     </c:forEach> 
                                    <c:if test="${room.review_count == 0 }">
									 <span style="color:black;">(후기: ${room.review_count }개 </span>
									  <span style="color:black;"> / 예약: ${room.res_count }개)</span>
									</c:if>
									<c:if test="${room.review_count > 0 }">
									<a href="#" onclick="reviewDetail('${room.room_idx}','${vs.index }');">
									 <span style="color:black;">(후기: ${room.review_count }개</span></a>
									 <span style="color:black;"> / 예약: ${room.res_count }개)</span>
									  </c:if>
									<!--모달창  -->
											<div id="reviewmodal${vs.index }" class="modal" tabindex="-1" style="color:black;">
												<div class="modal-dialog modal-dialog-scrollable">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">${room.room_name } 리뷰</h5>
															<button type="button" class="btn-close"
																aria-label="Close"></button>
														</div>
														<div class="modal-body" style="width:100%;"id="reviewbody${vs.index }"></div>
													</div>
												</div>
											</div>
                                    
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
</body>
</html>