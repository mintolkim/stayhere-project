<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<!-- flatpickr -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css"
	href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/rangePlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52817c98591dad1c8811f3daa6bca00b&libraries=services"></script>
<style type="text/css">
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
table tr td{
 width: 50%;
}
/*채팅 아이콘 css*/
.btn-chatting-icon {
	position: fixed;
	bottom: 3rem;
	right: 2rem;
	cursor: pointer;
	visibility: hidden;
	z-index: 999;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역 시작-->
  <section class="col-lg-10 mt-4 mb-5 px-5 mx-auto" id="features">
    <div class="container px-5">
	    <!-- 숙소 이름 -->
		<div class="container" style="padding: 0;">	
		 <h3>
		  <span>${room.room_name}</span>
		 </h3>
		</div>
		
		<!-- 별점/후기/찜 하트 -->
		<div class="d-flex container" style="padding: 0;">
		 <div class="d-flex container" style="padding: 0;">
			  <div class="d-flex justify-content-start" style="width: 50%; position: relative; float: left; vertical-align: middle; padding-top: 10px">
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
		 <c:if test="${sessionScope.h_userid == null && sessionScope.userid != null}">
			 <div class="d-flex justify-content-end" style="width: 50%; position: relative; float: right;">
		      <i id="wish-icon-${room.room_idx}" class="bi-heart text-danger fw-bold fs-2" onclick="wishListToggle(event, ${room.room_idx})"></i>
			 </div>
		 </c:if>
		 
		 </div>
		 
		</div>
	</div>
	<!-- 숙소 사진 목록 -->
	<div class="container px-5 mb-1">
	
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="${path}/imgUpload/${room.photo1}" class="d-block w-100" alt="..."  style="width: 1000px; height: 600px">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/imgUpload/${room.photo2}" class="d-block w-100" alt="..."  style="width: 1000px; height: 600px">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/imgUpload/${room.photo3}" class="d-block w-100" alt="..." style="width: 1000px; height: 600px">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/imgUpload/${room.photo4}" class="d-block w-100" alt="..." style="width: 1000px; height: 600px">
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
          
          <c:if test="${host.h_profile_img != null}">
	          <div class="d-flex justify-content-end" style="width: 8%; position: relative; float: right;">
	           <img src="${path}/imgUpload/${host.h_profile_img}" width="50px" height="50px" style="border-radius: 50%">
	          </div>
		  </c:if>

          <c:if test="${host.h_profile_img == null}">
	          <div class="d-flex justify-content-end" style="width: 8%; position: relative; float: right;">
	           <img src="${path}/resources/images/guest.png" width="50px" height="50px" style="border-radius: 50%">
	          </div>
		  </c:if>
		 
		  <div style="clear: both; font-size: 16px;">
		   <span>최대 인원 ${room.max_people}명 · </span>
		   <span>침대 ${room.beds}개 · </span>
		   <span>욕실 ${room.baths}개</span>
		  </div>          
         </section>
         
         <hr class="gray_line">
         
         <!-- 숙소 소개 문구 -->
         <div class="container" style="padding: 0;">
          <p>${room.contents}</p>
         </div>		
        
         <hr class="gray_line">
        
         <!-- 숙소 편의시설 및 숙소 이용규칙 표기 -->                      
         <div class="container" style="padding: 0;">
			<table class="table" style="border-color: white;">
			    <tr>
			      <td><i class="bi bi-wifi"></i>&nbsp;&nbsp;무선 인터넷</td>
			      <td><i class="bi bi-car-front"></i>&nbsp;&nbsp;건물 내 무료주차</td>
			    </tr>
			    <tr>
			      <td><i class="bi bi-snow"></i>&nbsp;&nbsp;에어컨</td>
			      <td><i class="bi bi-thermometer-sun"></i>&nbsp;&nbsp;난방</td>
			    </tr>
			    <tr>
			      <td><i class="bi bi-bag-check"></i>&nbsp;&nbsp;여행 가방 보관 가능</td>
			      <td><i class="bi bi-truck-front"></i>&nbsp;&nbsp;대중교통 인접</td>
			    </tr>
			    <tr>
			      <td><i class="bi bi-cup-hot"></i>&nbsp;&nbsp;커피머신</td>
			      <td><i class="bi bi-speaker"></i>&nbsp;&nbsp;블루투스 음향시스템 </td>
			    </tr>
			</table>
         </div>

		 <hr class="gray_line">

         <div class="container" style="padding: 0;">
			<table class="table" style="border-color: white;">
			    <tr>
			      <td><i class="bi bi-clock-fill"></i>&nbsp;&nbsp;체크인 : 오후 3:00 - 오후 8:00</td>
			      <td><i class="bi bi-stars"></i>&nbsp;&nbsp;코로나19 방역 수칙을 준수하셔야 합니다.</td>
			    </tr>
			    <tr>
			      <td><i class="bi bi-clock-fill"></i>&nbsp;&nbsp;체크아웃 : 오전 11:00</td>
			      <td><i class="bi bi-check-circle-fill"></i>&nbsp;&nbsp;화재경보기 있음</td>
			    </tr>
			</table>
         </div>
         
        </div>


					<!-- 예약 정보 -->
					<div class="col-lg-4">
						<div class="card mb-3">
							<div class="card-header">예약 정보</div>
							<form name="res_form" id="res_form" method="post"
								action="${path}/reservations/reserve/${room.room_idx}">
								<div class="card-body">
									<div class="mb-2">
										<span style="font-size: 24px; font-weight: bold;">￦<fmt:formatNumber
												value="${room.room_price}" pattern="#,###,###" />
										</span><span style="color: #737373;">/박</span>
									</div>
									<div class="form-floating mb-3">
										<input class="form-control" value="${checkin_date}"
											name="checkin_date" id="checkin_date" placeholder="체크인"
											required> <label for="floatingInput">체크인</label>
									</div>
									<div class="form-floating mb-3">
										<input class="form-control" value="${checkout_date}"
											name="checkout_date" id="checkout_date" placeholder="체크아웃"
											required> <label for="floatingInput">체크아웃</label>
									</div>

                  <div class="form-floating mb-3">
                    <input type="number" class="form-control" name="res_person" id="res_person" min="2" max="${room.max_people}" value="2" onKeyup="this.value=this.value.replace(/[^0-${room.max_people}]/g,'');"/>
                    <label for="floatingInput">예약인원</label>
                  </div>

                  <c:if test="${sessionScope.h_userid == null}">
                    <div class="d-grid gap-2">
                      <button class="btn btn-warning" id="btnReserve" type="button">예약하기</button>
                    </div>
                  </c:if>

                  <c:if test="${sessionScope.h_userid != null}">
                    <div class="d-grid gap-2">
                      <button class="btn btn-warning" id="btnReserveHost" type="button">예약하기</button>
                    </div>
                  </c:if>
			
           </div>
           <input type="hidden" name="room_idx" id="room_idx" value="${room.room_idx}">
           <input type="hidden" name="check_in" id="check_in" value="<fmt:formatDate value="${room.check_in}" pattern="yyyy-MM-dd" />">
           <input type="hidden" name="check_out" id="check_out" value="<fmt:formatDate value="${room.check_out}" pattern="yyyy-MM-dd" />">
           <input type="hidden" name="night" id="night">
          </form>
         </div>
        </div>
      </div>
    </div>

	<hr class="gray_line mx-auto" style="width: 82%;">

	<!-- 리뷰 목록 ${profile_img} 경로 설정 -->
	<div class="container px-5 my-3">
	 <section>
	  <div>
	   <c:choose>
	    <c:when test="${starAvg==0.0 && reviewCount==0}">
         <span class="fs-4">리뷰(아직)없음</span><br>
	     <span>⭐NEW</span>
	    </c:when>
	    <c:otherwise>
	     <span class="fs-4">리뷰</span><br>
	     <span>⭐${starAvg}/5 · 후기 ${reviewCount}개</span>
	    </c:otherwise>
	   </c:choose>
	  </div>
	  
	  <div class="container mx-auto">
		<div class="row row-cols-4 mx-auto my-3">
	  	  <c:forEach var="row"  items="${review}" begin="0" end="3">
			<div class="card" style="width: 18rem; margin: 3px;">
			  <div class="card-body">
			    <h5 class="card-title">
			    
				<c:if test="${row.profile_img != null}">			 
			    <img src="${path}/imgUpload/${row.profile_img}" width="30px" height="30px" style="border-radius: 50%">
			    </c:if>
			    
				<c:if test="${row.profile_img == null}">			 
			    <img src="${path}/resources/images/guest.png" width="30px" height="30px" style="border-radius: 50%">
			    </c:if>
			    
			    &nbsp;${row.userid}</h5>
			   
			    <h6 class="card-subtitle mb-2 text-muted"><fmt:formatDate value="${row.write_date}" pattern="yyyy.MM.dd hh:mm" /> </h6>
			    <p class="card-text">${row.r_title}</p>
			    <a href="#" class="card-link" id="btnReview" onclick="review(${row.review_idx})">더보기 > </a>
			  </div>
			</div>
	      </c:forEach>
	    </div>
	  </div>
	 </section>
	</div>
	
	<hr class="gray_line mx-auto" style="width: 82%;">
	
	<!-- 숙소 위치 -->
	<div class="container px-5 my-3">
	 <span class="fs-4">호스팅 지역</span>
	</div>
	<div class="container px-5">
	 <i class="bi bi-geo-alt-fill"></i>
	 <span>${room.city}&nbsp;${room.country}</span>
	</div>
	
	<!-- 지도 API ${dto.lat} ${dto.lng} ${dto.room_name} ${dto.country} ${dto.city}-->
	<div class="container px-5 my-3">
	  <div class="rounded" id="map" style="margin-top: 15px; height: 500px;"></div>
	</div>
	
	<hr class="gray_line mx-auto" style="width: 82%;">
	
	<!-- 호스트 정보, 이메일 문의  -->
	<div class="container px-5 my-3">
		<div class="card">
		  <div class="card-header">Host</div>
		  <div class="card-body">
		    <div class="d-flex">

		    <c:if test="${host.h_profile_img != null}">
		     <div class="d-flex">
		      <img src="${path}/imgUpload/${host.h_profile_img}" width="60px" height="60px" style="border-radius: 50%">
		     </div>
		    </c:if>

          	<c:if test="${host.h_profile_img == null}">
		     <div class="d-flex">
		      <img src="${path}/resources/images/guest.png" width="60px" height="60px" style="border-radius: 50%">
		     </div>
          	</c:if>
		     
		     <div style="margin-left: 20px;">
		      <span class="card-title fs-5">호스트 : ${host.h_userid}님</span>
		      <p class="card-text" style="font-size: 14px;">회원 가입일 : <fmt:formatDate value="${host.h_join_date}" pattern="yyyy.MM.dd" /> </p>
		      <a href="mailto:﻿${host.h_email}?subject=[${room.room_name}]문의"><button type="button" class="btn btn-warning" style="font-size: 14px;">호스트에게 메일보내기</button></a>
		 	 </div>
			</div>

		</section>
		<!-- 본문 영역 끝 -->
 
 <!-- 채팅 아이콘  -->
<c:if test="${sessionScope.h_userid == null && sessionScope.userid != null}">
 <div class="btn-chatting-icon">
 	<form method="post" id="chatForm">
 			<input type="hidden" name="room_idx" value="${room.room_idx}">
 			<input type="hidden" name="room_name" value="${room.room_name}">
 			<input type="hidden" name="h_userid" value="${host.h_userid}">
 			<input type="hidden" name="h_name" value="${host.h_name}">
 			<input type="hidden" name="photo1" value="${room.photo1}">
 			<button type="button" class="btn btn-custom rounded-circle py-1" onclick="chatFormSubmit(chatForm)">
 				<i class="bi bi-chat-dots-fill fs-1"></i>
 			</button>
 	</form>
</div>
</c:if>
 
<script type="text/javascript">
	$(function(){
		var checkin_date=$("#checkin_date").val();
		var checkout_date=$("#checkout_date").val();
		
		console.log("검색한 체크인 : "+checkin_date+" 검색한 체크 아웃 : "+checkout_date);
		
		wishListCheck();
		
		//채팅아이콘 스크립트
		var chatIcon = $(".btn-chatting-icon");
	    $(window).scroll(function () {
	        if ($(document).scrollTop() > 100) {
	            chatIcon.css('visibility', 'visible');
	        }
	        else if ($(document).scrollTop() < 100) {
	            chatIcon.css('visibility', 'hidden');
	        }
	    });
	});	
	

	//채팅하기 폼 팝업으로 띄우고 submit()하기
	function chatFormSubmit(f){	
		var left = $(document).width()-600; //문서 가로사이즈 - 600;
		var popup = window.open("","chatPopup","width=550, height=700, left=" + left + ", top=100, scrollbars=no, toollbars=no, location=no,")
		f.target = "chatPopup";
		f.action = "${path}/chat";
		f.submit();
	}
	

	//위시리스트에 들어가있는지 확인 후 아이콘 표시
	function wishListCheck(){
		var userid = '${sessionScope.userid}';
		
		if(userid != ""){
			$.ajax({
				type: "get",
				url : "${path}/wishlist/addCheck.do",
				data : { "userid" : userid },
				dataType : "json",
				contentType:"application/json",
				success : function(data){
					console.log(data);
						$(data).each(function(){
							$("#wish-icon-"+this.room_idx).addClass('bi-heart-fill');
							$("#wish-icon-"+this.room_idx).removeClass('bi-heart');
						});			
				}
			})
		}
	}
	
	//메인 위시리스트 버튼 클릭
	function wishListToggle(event, room_idx) {
	    event.stopPropagation(); //부모태그 이벤트 막기..적용안됨..
	    var userid = '${sessionScope.userid}';
	    var add = $("#wish-icon-"+room_idx).hasClass('bi-heart');
	    var del = $("#wish-icon-"+room_idx).hasClass('bi-heart-fill');
	    
	    console.log("꽉찬 하트 라면 : " + del);
	    console.log("빈 하트라면 : " + add);
	    
	    var date = {
	    		"room_idx" : room_idx,
					"userid" : userid
	    }
	    	    
	    if(userid != "" && add){
	    	if(confirm("위시리스트에 추가하시겠습니까?")){
	    		$.ajax({
	    			type: "get",
	    			url: "${path}/wishlist/insert.do",
	    			data : date,
	    			success : function(data){
	    				if(data == 'true'){
	    					if(confirm("위시리스트에 추가되었습니다! 위시리스트로 이동하시겠습니까?")){
	    						location.href="${path}/wishlist/list.do";
	    					}
	    					$("#wish-icon-"+room_idx).toggleClass('bi-heart bi-heart-fill');
	    				} else {
	    					alert("이미 추가된 방입니다!");
	    					return false;
	    				}
	    			}
	    		});
	    	}
	    } else if(userid != "" && del) {
	    	if(confirm("위시리스트에 삭제하시겠습니까?")){
	    		$.ajax({
	    			type: "get",
	    			url: "${path}/wishlist/delete.do",
	    			data : date,
	    			success : function(data){
	    				if(data == 'true'){
	    					alert("위시리스트에서 삭제되었습니다");
	    					$("#wish-icon-"+room_idx).toggleClass('bi-heart bi-heart-fill');
	    				} else {
	    					alert("서버에러");
	    					return false;
	    				}
	    			}
	    		});
	    	}
	    }
	    
	    
	    else {
	    	if(confirm("로그인 하셔야 위시리스트 기능이 가능합니다.\n 로그인 페이지로 이동하시겠습니까?")){
	    		location.href="${path}/guest/login.do";
	    	}
	    }
	   
	}
	
</script>

		<script type="text/javascript">
	 $(function(){
		$("#btnReserveHost").click(function(){
		   alert("호스트는 예약이 불가합니다. \n 게스트로 로그인 후 다시 시도하세요!"); 	
		   location.href="${path}/guest/login.do";
		});
		 
	    $("#btnReserve").click(function(){
	    	var checkin_date=$("#checkin_date").val();
	    	var checkout_date=$("#checkout_date").val();
	    	var res_person=$("#res_person").val();
	    	
	    	if(checkin_date=="") {
	    		alert("체크인 날짜를 선택하세요.");
				$("#checkin_date").focus();
				return;
	    	}
	    	if(checkout_date=="") {
	    		alert("체크인 날짜를 선택하세요.");
				$("#checkout_date").focus();
				return;
	    	}
	    	if(res_person=="") {
	    		alert("예약인원을 선택하세요.");
				$("#res_person").focus();
				return;
	    	}
	    	dateCal();
	    });
		console.log('${redateList}');
         
		var check_out=$("#check_out").val();
		console.log("호스팅 끝나는 날짜"+check_out);
		
		var option = {
             locale: "ko", //한국어로 언어설정
             dateFormat: "Y-m-d",   //출력 설정
             allowInput : false, //사용자 정의 입력설정
             mode : "range",  //범위
             disable: ${redateList},
             showMonths : 2, // 2개월 캘린더 표기 
             minDate : new Date().fp_incr(1), //최소 날짜, 현재시간으로 셋팅 "today"현재날짜
             maxDate : check_out,
             plugins: [new rangePlugin({ input: "#checkout_date"})] //플러그인 설정 input-box 2개에 표기
         }

         $("#checkin_date").flatpickr(option);

	 });
	 
	    function dateCal() {
	    	var checkin_date=$("#checkin_date").val();
	    	var checkout_date=$("#checkout_date").val();
	    	
 	    	var startDate=new Date(checkin_date);
	    	var endDate=new Date(checkout_date);
	    	
	    	var resultMs= endDate.getTime() - startDate.getTime();
	    	var night_price= resultMs / (1000*60*60*24); 

	    	//var night_price=checkout_date-checkin_date;
	    	
	    	console.log("숙박 일 수 : "+night_price+" 타입 : "+typeof night_price);
	    	$("#night").attr("value", night_price);
	    	console.log(night_price+" 타입 : "+typeof night.value);
	    	
	    	//resdate_check();//예약날짜 중복체크(구현하였지만 사용X, 데이트피커의 disable을 이용하여 중복날짜를 선택하지 못하게 구현함)
	    	dateChk();//1박이상 체크하였는지 확인
	    }
	    
	    function dateChk(){ // 날짜 유효성 체크
	    	
	    	var checkin_date=$("#checkin_date").val();
	    	var checkout_date=$("#checkout_date").val();
	    	
	    	checkin_date = checkin_date.replace('-',	'')
	    	checkin_date = checkin_date.replace('-',	'')
	    	checkout_date = checkout_date.replace('-', '')
	    	checkout_date = checkout_date.replace('-', '')
	    	
	    	if(checkin_date != '' && checkout_date != ''){
	    		if(checkin_date >= checkout_date){
	    			alert('최소 1박 2일의 일정을 선택해주세요')
	    			$("#checkin_date").val(null);
	    			$("#checkout_date").val(null);
	    			return false;
	    		}
	    	}
	    	$("#res_form").submit();
	    }

	    //사용x
	    function resdate_check() {
	    	var room_idx=$("#room_idx").val();
	    	var checkin_date=$("#checkin_date").val();
	    	var checkout_date=$("#checkout_date").val();
	    	var res_person=$("#res_person").val();
	    	
	    	checkin_date = checkin_date.replace('-', '');
	    	checkout_date = checkout_date.replace('-', '');
	    	checkin_date = checkin_date.replace('-', '');
	    	checkout_date = checkout_date.replace('-', '');
	    	
	    	$.ajax({
	    	url : "${path}/reservations/resdate_check",
	    	type : "post",
	    	data : {
	    	  'room_idx' : room_idx,
	    	  'checkin_date' : checkin_date,
	    	  'checkout_date' : checkout_date
	    	},
	    	success : function(result){
	    		console.log("ajax연결 성공");
	    		console.log(result);
	    		if(result!=0) {
	    			alert('이미 예약된 날짜입니다. \n 다른 날짜를 선택해주세요.');
	    			$("#checkin_date").val(null);
	    			$("#checkout_date").val(null);
	    			return false;
	    		}else {
	    			if(checkin_date == checkout_date){
	    				if(checkin_date >= checkout_date){
	    					alert('최소 1박 2일의 일정을 선택해주세요');
	    					$("#checkout_date").val(null);
	    					return false;
	    				}
	    			}
	    			alert('예약 가능한 날짜입니다.');
	    	        $("#res_form").submit();
	    		}
	    	},
	        error:function(){ 
	            alert("에러발생");
	        }
	     });
	    };
	    
	    /* 리뷰 상세 페이지 이동 */
	    function review(review_idx) {
	    	location.href="${path}/reviews/detail.do?review_idx="+review_idx;
	    }
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

		var imageSrc = 'https://cdn-icons-png.flaticon.com/512/1181/1181732.png', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng("${room.lat}", "${room.lng}"); // 마커가 표시될 위치입니다
		
		//마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng("${room.lat}", "${room.lng}"); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition,
		    image: markerImage // 마커이미지 설정  
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null); 
		
		// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var iwContent = '<div style="padding: 5px; font-size: 14px;"><a href="https://map.kakao.com/link/to/${room.address1},${room.lat},${room.lng}" style="color:blue;" target="_blank">🚗길찾기 click!🚗</a></div>',
		    iwPosition = new kakao.maps.LatLng("${room.lat}", "${room.lng}"); //인포윈도우 표시 위치입니다
		
		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker); 

</script>

	</main>
	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>