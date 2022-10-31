<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>

<!-- 구글 폰트  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Montserrat:wght@300&display=swap" rel="stylesheet">

<!-- 에어비앤비 데이트피커 -->
<link rel="stylesheet" type="text/css" href="https://unpkg.com/vue-airbnb-style-datepicker@latest/dist/vue-airbnb-style-datepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/date-fns/1.29.0/date_fns.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52817c98591dad1c8811f3daa6bca00b&libraries=services"></script>
<script type="text/javascript">
$(function(){
	$("#btnReserve").click(function(){
		dateCal();
	});
});
function dateCal() {
	var checkin_date=$("#checkin_date").val();
	var checkout_date=$("#checkout_date").val();
	
	var startDate=new Date(checkin_date);
	var endDate=new Date(checkout_date);
	
	var resultMs= endDate.getTime() - startDate.getTime();
	var night_price= resultMs / (1000*60*60*24);
	
	console.log("숙박 일 수 : "+night_price+" 타입 : "+typeof night_price);
	$("#night").attr("value", night_price);
	console.log(night.value+" 타입 : "+typeof night.value);
}

function dateChk(){ //숙박날짜 유효성 체크
	var today = new Date();
	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	if(month<10) month = '0'+month
	var date = today.getDate();  // 날짜
	if(date<10) date = '0'+date
	var day=year+''+month+''+date
	console.log(day)

	var checkin_date =$("#checkin_date").val();
	var checkout_date =$("#checkout_date").val();
	
	checkin_date = checkin_date.replace('-', '');
	checkout_date = checkout_date.replace('-', '');
	
	if(checkin_date != '' && checkout_date != ''){
		if(checkin_date >= checkout_date){
			alert('최소 1박 2일의 일정을 선택해주세요');
			$("#checkout_date").val(null);
		}
	}
}
</script>

<style type="text/css">
* {
 font-family: 'Dongle' !important; sans-serif;
 font-family: 'Montserrat' !important; sans-serif;
}
a { 
 text-decoration: none;
}
ul li {
 display: inline;
 list-style-type: none;
}
#btnReview {
color: #8c8c8c;
text-decoration: none;
}
#btnReview:hover {
color: #ffc107;
text-decoration: none;
}
</style>
<style>
		.align-right {
		  text-align: right;
		}
		.datepicker-container {
		  margin-bottom: 30px;
		}
		
		#datepicker-button-trigger {
		  background: #008489;
		  border: 1px solid #008489;
		  color: white;
		  padding: 6px 10px;
		  border-radius: 4px;
		  font-size: 15px;
		  font-weight: bold;
		  text-align: center;
		  min-width: 200px;
		}
		input {
		  padding: 6px 10px;
		  border: 1px solid rgba(0, 0, 0, 0.2);
		}
		.inline-with-input {
		  width: 300px;
		}
		.inline-with-input input {
		  width: 100%;
		}
		</style>
		<style>
    .book .book-summary .book-search,
    .book .book-summary ul.summary {
        position: relative;
        top: auto;
        left: auto;
        right: auto;
        bottom: auto;
    }
    .book-summary {
        display: -webkit-box;
        display: -moz-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        flex-direction: column;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        overflow-y: auto;
    }
    .book-summary > nav {
        flex: 1 1 auto;
        overflow-y: auto;
        overflow-y: overlay;
    }
    .gl-wrapper {
        margin: 0;
        display: block;
        padding: 0;
        position: relative;
        line-height: 15px;
        background: #fafafa;
    }
    .gl-wrapper:before {
        background: -webkit-linear-gradient(to bottom, rgba(250,250,250,0) 0%, #fafafa 100%);
        background: -moz-linear-gradient(to bottom, rgba(250,250,250,0) 0%, #fafafa 100%);
        top: -24px;
        width: 100%;
        height: 24px;
        content: "";
        display: block;
        position: absolute;
        background: linear-gradient(to bottom, rgba(250,250,250,0) 0%, #fafafa 100%);
    }
    .book.color-theme-1 .gl-wrapper {
        background: #121212;
    }
    .book.color-theme-1 .gl-wrapper:before {
        background: -webkit-linear-gradient(to bottom, rgba(18,18,18,0) 0%, #121212 100%);
        background: -moz-linear-gradient(to bottom, rgba(18,18,18,0) 0%, #121212 100%);
        background: linear-gradient(to bottom, rgba(18,18,18,0) 0%, #121212 100%);
    }
    .book.color-theme-2 .gl-wrapper {
        background: #2e3243;
    }
    .book.color-theme-2 .gl-wrapper:before {
        background: -webkit-linear-gradient(to bottom, rgba(46,50,67,0) 0%, #2e3243 100%);
        background: -moz-linear-gradient(to bottom, rgba(46,50,67,0) 0%, #2e3243 100%);
        background: linear-gradient(to bottom, rgba(46,50,67,0) 0%, #2e3243 100%);
    }
    .gl-wrapper .gitbook-link {
        display: -webkit-box;
        display: -moz-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        color: #9DAAB6;
        margin: 16px;
        display: flex;
        padding: 0;
        align-items: center;
        margin-left: 32px;
        padding-top: 8px;
        padding-left: 16px;
        border-radius: 3px;
        padding-right: 16px;
        padding-bottom: 8px;
        text-decoration: none;
        background-color: #E6ECF1;
        -webkit-box-align: center;
    }
    .gl-wrapper .tm-logo {
        margin: 0;
        display: block;
        padding: 0;
        font-size: 40px;
    }
    .gl-wrapper .tm-content {
        flex: 1;
        margin: 0;
        display: block;
        padding: 0;
        padding-left: 16px;
    }
    .gl-wrapper .tm-content .container {
        margin: 0;
        display: block;
        padding: 0;
    }
    .gl-wrapper .tm-content .tm-container .tm-text {
        font-size: 12px;
        font-family: "Roboto", sans-serif;
        font-weight: 400;
        line-height: 1.625;
    }
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5 px-5" id="features">
    <!-- 숙소 이름 -->
	<div class="container px-5">	
	 <h3>
	  <span>${room.room_name}</span>
	 </h3>
	</div>
	
	<!-- 별점/후기/찜 하트 -->
	<div class="container px-5 my-3">
	 <div class="d-flex justify-content-start" style="width: 75%; position: relative; float: left;">
	  <c:choose>
	   <c:when test="${starAvg==0.0 && reviewCount==0}">
	    <span>⭐NEW</span>
	   </c:when>
	  <c:otherwise>
	   <span>⭐${starAvg}/5</span>
	   <span>&nbsp;&nbsp;</span>
	   <span>후기 ${reviewCount}개</span>
	  </c:otherwise>
	  </c:choose>
	  <span>&nbsp;&nbsp;&nbsp;</span>
	  <i class="bi bi-geo-alt-fill"></i>
	  <span>${room.city}&nbsp;&nbsp;</span>
	  <span>${room.country}</span>	
	 </div>
	 
	 <!-- 찜 하트 -->
	 <div class="d-flex justify-content-end" style="width: 7%; position: relative; float: right; margin-left: 10%; margin-bottom: 5px;">
      <i class="bi-heart text-danger fw-bold fs-5" onclick="wishListToggle()"></i>
	 </div>
	</div>
	
	<!-- 숙소 사진 목록 -->
	<div class="container px-5 my-4" >
	
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="${path}/resources/images/${room.photo1}" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/${room.photo2}" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/${room.photo3}" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/${room.photo4}" class="d-block w-100" alt="...">
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
	 
	</div>
	
    <!-- 사진 아래 부터 시작, 리뷰 목록 전까지의  div -->	
    <div class="container px-5 my-3">
      <div class="row">
        <div class="col-lg-8">	

         <!-- 숙소 소개 타이틀 -->
         <section>
          <div class="d-flex justify-content-start" style="width: 80%; position: relative; float: left;">
           <span class="fs-4">${host.h_userid}님이 호스팅하는 게스트용 별채 전체</span>
          </div>
          <div class="d-flex justify-content-end" style="width: 8%; position: relative; float: right;">
           <img src="${path}/${host.h_profile_img}" width="50px" height="50px" style="border-radius: 50%">
          </div>
		  <div style="clear: both; font-size: 16px;">
		   <span>최대 인원 ${room.max_people}명 · </span>
		   <span>침대 ${room.beds}개 · </span>
		   <span>욕실 ${room.baths}개</span>
		  </div>          
         </section>
         
         <hr class="gray_line">
         
         <!-- 숙소 소개 문구 -->
         <div class="container" style="padding: 0; margin: 5% 0;">
          <p>${room.contents}</p>
         </div>		
        
         <hr class="gray_line">
        
         <!-- 예약 달력 -->
         <div class="container" style="padding: 0; margin: 5% 0; height: 500px; background-color: #d9d9d9;">
     <div id="app" class="app" :class="{&apos;align-right&apos;: alignRight}">
      <div class="datepicker-container with-button">
        <h3>Range datepicker with button</h3>
        <div class="datepicker-trigger">
          <button id="datepicker-button-trigger">
            {{ formatDates(buttonDateOne, buttonDateTwo) || &apos;Select dates&apos; }}
          </button>

          <airbnb-style-datepicker :trigger-element-id="&apos;datepicker-button-trigger&apos;" :mode="&apos;range&apos;" :date-one="buttonDateOne" :date-two="buttonDateTwo" :min-date="&apos;2022-10-25&apos;" :fullscreen-mobile="true" :months-to-show="2" :offset-y="10" :trigger="trigger" v-on:date-one-selected="function(val) { buttonDateOne = val }" v-on:date-two-selected="function(val) { buttonDateTwo = val }" v-on:closed="onClosed" v-on:previous-month="onMonthChange" v-on:next-month="onMonthChange"></airbnb-style-datepicker>
        </div>
      </div>

     </div>

         </div>
        </div>


        <!-- 예약 정보 -->
        <div class="col-lg-4">
         <div class="card mb-3">
          <div class="card-header">예약 정보</div>
           <!-- ${path}/reservations/reserve.do -->
           <form name="res_form" method="post" action="${path}/reservations/reserve/${room.room_idx}">
           <div class="card-body">
            <div class="mb-2">
             <span style="font-size: 24px; font-weight: bold;">￦<fmt:formatNumber value="${room.room_price}" pattern="#,###,###"/>  </span><span style="color: #737373;">/박</span>
            </div>
			<div class="form-floating mb-3">
			  <input type="date" class="form-control" value="${checkin_date}" min="${today}" name="checkin_date" id="checkin_date" onchange="dateChk()" required>
			  <label for="floatingInput">체크인</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="date" class="form-control" value="${checkout_date}" min="${tomorrow}" name="checkout_date" id="checkout_date" onchange="dateChk()" required>
			  <label for="floatingInput">체크아웃</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="number" class="form-control" name="res_person" id="res_person" min="2" max="${room.max_people}" value="2">
			  <label for="floatingInput">예약인원</label>
			</div>
			<div class="d-grid gap-2">
			  <button class="btn btn-warning" id="btnReserve" type="submit">예약하기</button>
			</div>
           </div>
           <input type="hidden" name="room_idx" value="${room.room_idx}">
           <input type="hidden" name="night" id="night">
          </form>
         </div>
        </div>
        

      </div>
    </div>

	<hr class="gray_line" style="width: 68%; margin: auto;">

	<!-- 리뷰 목록 ${profile_img} 경로 설정 -->
	<div class="container px-5 my-3">
	 <section>
	  <div>
	   <c:choose>
	    <c:when test="${starAvg==0.0 && reviewCount==0}">
         <h4>리뷰(아직)없음</h4>
	     <span>⭐NEW</span>
	    </c:when>
	    <c:otherwise>
	     <h4>리뷰</h4>
	     <span>⭐${starAvg}/5 · 후기 ${reviewCount}개</span>
	    </c:otherwise>
	   </c:choose>
	  </div>
	  
	  <div class="container mx-auto">
		<div class="row row-cols-4 mx-auto my-3">
	  	  <c:forEach var="row"  items="${review}" begin="0" end="3">
			<div class="card" style="width: 18rem; margin: 3px;">
			  <div class="card-body">
			    <h5 class="card-title"><img src="${path}/resources/images/${row.profile_img}" width="30px" height="30px" style="border-radius: 50%">&nbsp;${row.userid}</h5>
			    <h6 class="card-subtitle mb-2 text-muted"><fmt:formatDate value="${row.write_date}" pattern="yyyy.MM.dd hh:mm" /> </h6>
			    <p class="card-text">${row.r_title}</p>
			    <a href="#" class="card-link" id="btnReview">더보기 > </a>
			  </div>
			</div>
	      </c:forEach>
	    </div>
	  </div>
	 </section>
	</div>
	
	<hr class="gray_line" style="width: 68%; margin: auto;"> 
	
	<!-- 숙소 위치 -->
	<div class="container px-5 my-3">
	 <h4>호스팅 지역</h4>
	</div>
	<div class="container px-5">
	 <i class="bi bi-geo-alt-fill"></i>
	 <span>${room.city}&nbsp;${room.country}</span>
	</div>
	
	<!-- 지도 API ${dto.lat} ${dto.lng} ${dto.room_name} ${dto.country} ${dto.city}-->
	<div class="container px-5 my-3">
	  <div class="rounded" id="map" style="margin-top: 15px; height: 600px;"></div>
	</div>
	
	<hr class="gray_line" style="width: 68%; margin: auto;">
	
	<!-- 호스트 정보, 이메일 문의  -->
	<div class="container px-5 my-3">
		<div class="card">
		  <div class="card-header">Host</div>
		  <div class="card-body">
		    <div class="d-flex">
		     <div class="d-flex">
		      <img src="${path}/${host.h_profile_img}" width="60px" height="60px" style="border-radius: 50%">
		     </div>
		     <div style="margin-left: 20px;">
		      <span class="card-title" style="font-size: 20px; font-weight: bold;">호스트 : ${host.h_userid}님</span>
		      <p class="card-text" style="font-size: 14px;">회원 가입일 : <fmt:formatDate value="${host.h_join_date}" pattern="yyyy.MM.dd" /> </p>
		      <a href="mailto:﻿${host.h_email}?subject=[${room.room_name}]문의"><button type="button" class="btn btn-warning" style="font-size: 14px;">호스트에게 메일보내기</button></a>
		 	 </div>
			</div>
		  </div>
		</div>
	</div>
	
  </section>
 </main>
 <!-- footer -->
 <%@ include file="../include/footer.jsp" %>
    <script src="https://unpkg.com/vue-airbnb-style-datepicker@latest/dist/vue-airbnb-style-datepicker.min.js"></script>
    <script>
      var datepickerOptions = {}
      Vue.use(window.AirbnbStyleDatepicker, datepickerOptions)

      var app = new Vue({
        el: '#app',
        data: {
          dateFormat: 'YYYY년 MM월 D일',
          inputDateOne: '',
          inputDateTwo: '',
          buttonDateOne: '',
          buttonDateTwo: '',
          inlineDateOne: '',
          sundayDateOne: '',
          sundayFirst: false,
          alignRight: false,
          trigger: false,
        },
        methods: {
          formatDates: function(dateOne, dateTwo) {
            var formattedDates = ''
            if (dateOne) {
              formattedDates = dateFns.format(dateOne, this.dateFormat)
            }
            if (dateTwo) {
              formattedDates += ' - ' + dateFns.format(dateTwo, this.dateFormat)
            }
            return formattedDates
          },
          onClosed: function() {
	          var datesStr = this.formatDates(this.inputDateOne, this.inputDateTwo)
	          console.log('Dates Selected: ' + datesStr)
	          this.trigger = false
	          $('#dateOne').val(this.buttonDateOne);
	          $('#dateTwo').val(this.buttonDateTwo);
	          if(this.buttonDateOne=="" || this.buttonDateTwo ==""){
	            	alert("날짜를 선택해 주세요.");
	          }else{
	          alert("선택하신 날짜는 "+this.buttonDateOne+"~"+this.buttonDateTwo+"입니다.");
	          }
	        },
          toggleAlign: function() {
            this.alignRight = !this.alignRight
          },
          triggerDatepicker: function() {
            this.trigger = !this.trigger
          },
          onMonthChange: function(dates) {
            console.log('months changed', dates)
          },
        },
      })
    </script>
<script type="text/javascript">
//지도 스크립트
//상세조건의 값을 가져옵니다
//지도를 생성합니다    
const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
 mapOption = {
     center: new kakao.maps.LatLng("${room.lat}", "${room.lng}"), // 지도의 중심좌표
     level: 4 // 지도의 확대 레벨
 };  
//지도를 생성합니다    
const map = new kakao.maps.Map(mapContainer, mapOption); 

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng("${room.lat}", "${room.lng}"); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null); 

// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
var iwContent = '<div style="height: 100px; width:200px; padding: 5px; text-align: center; font-size: 13px; border-radius: 8px; box-shadow: 3px 3px 15px #808080;"> ${room.room_name}<p><a href="https://map.kakao.com/link/to/${room.country},38.1808,128.6121" style="color:blue" target="_blank">길찾기</p></div>',
    iwPosition = new kakao.maps.LatLng("${room.lat}", "${room.lng}"); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 

</script>

</body>
</html>