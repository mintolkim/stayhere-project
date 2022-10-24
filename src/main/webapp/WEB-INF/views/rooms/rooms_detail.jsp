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
<!-- 구글 폰트  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Montserrat:wght@300&display=swap" rel="stylesheet">

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52817c98591dad1c8811f3daa6bca00b&libraries=services"></script>
<style type="text/css">
body, h1, h2, h3, h4, h5, h6, p, span {
 font-family: 'Dongle'!important;, sans-serif;
 font-family: 'Montserrat'!important;, sans-serif;
}

ul li {
 display: inline;
 list-style-type: none;
}
/* div, section {
 border: 1px dotted black;
} */
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
    <!-- 숙소 이름 -->
	<div class="container px-5">	
	 <h3>
	  <span>${dto.room_name}</span>
	 </h3>
	</div>
	
	<!-- 별점/후기/찜 하트 -->
	<div class="container px-5 my-3">
	 <div class="d-flex justify-content-start" style="width: 75%; position: relative; float: left;">
	  <span>⭐4.5/5&nbsp;&nbsp;</span>
	  <span>후기 00개&nbsp;&nbsp;</span>
	  <span><img src="${path}/resources/images/location_map_marler.png" style="width: 20px;"></span>
	  <span>${dto.city}&nbsp;&nbsp;</span>
	  <span>${dto.country}</span>	
	 </div>
	 
	 <!-- 찜 하트 -->
	 <div class="d-flex justify-content-end" style="width: 7%; position: relative; float: right; margin-left: 10%; margin-bottom: 5px;">
      <a href="#"><img alt="wishList" src="${path}/resources/images/heart.svg" width="30px" height="30px"></a>
	 </div>
	</div>
	
	<!-- 숙소 사진 목록 -->
	<div class="container px-5 my-3" >
	
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
		      <img src="${path}/resources/images/room_photo2.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/room_photo3.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/room_photo1.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/room_photo4.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="${path}/resources/images/room_photo5.jpg" class="d-block w-100" alt="...">
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
    <div class="container px-5 my-4">
      <div class="row">
        <div class="col-lg-8">	

         <!-- 숙소 소개 타이틀 -->
         <section>
          <div class="d-flex justify-content-start" style="width: 80%; position: relative; float: left;">
           <h4>${dto.h_userid}님이 호스팅하는 게스트용 별채 전체</h4>
          </div>
          <div class="d-flex justify-content-end" style="width: 8%; position: relative; float: right;">
           <img src="https://images.pexels.com/photos/63340/pexels-photo-63340.jpeg?cs=srgb&dl=pexels-sara-63340.jpg&fm=jpg" width="50px" height="50px" style="border-radius: 50%">
          </div>
		  <div style="clear: both;">
		   <span>최대 인원 ${dto.max_people}명 · </span>
		   <span>침대 ${dto.beds}개 · </span>
		   <span>욕실 ${dto.baths}개</span>
		  </div>          
         </section>
         
         <!-- 숙소 소개 문구 -->
         <div class="container" style="padding: 0; margin: 5% 0;">
          <p>${dto.contents}</p>
         </div>		
        
         <!-- 예약 달력 -->
         <div class="container" style="padding: 0; margin: 5% 0; height: 500px; background-color: #d9d9d9;">
                       예약 달력 구현 영역입니다..

         </div>
        </div>
        

        <!-- 예약 정보 -->
        <div class="col-lg-4">
         <div class="card mb-4">
          <div class="card-header">예약 정보</div>
           <!-- ${path}/reservations/reserve.do -->
           <form method="post" action="${path}/reservations/reserve.do">
           <div class="card-body">
            <div class="mb-2">
             <span style="font-size: 24px; font-weight: bold;">￦<fmt:formatNumber value="${dto.room_price}" pattern="#,###,###"/>  </span><span style="color: #737373;">/박</span>
            </div>
			<div class="form-floating mb-3">
			  <input type="date" class="form-control" min="2022-10-24" max="2022-11-20" name="checkin_date" required>
			  <label for="floatingInput">체크인</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="date" class="form-control" min="2022-10-25" max="2022-11-20" name="checkout_date" required>
			  <label for="floatingInput">체크아웃</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="number" class="form-control" name="res_person" min="2" value="2">
			  <label for="floatingInput">예약인원</label>
			</div>
<!-- 			<div class="form-floating mb-3">
			  <input type="number" class="form-control" name="res_kids" min="0" value="0">
			  <label for="floatingInput">어린이</label>
			</div> -->
			<div class="d-grid gap-2">
			  <button class="btn btn-warning" id="btnReserve" type="submit">예약하기</button>
			</div>
           </div>
           <input type="hidden" name="room_idx" value="${dto.room_idx}">
           <input type="hidden" name="room_name" value="${dto.room_name}">
           <input type="hidden" name="room_price" value="${dto.room_price}">
           <input type="hidden" name="contents" value="${dto.contents}">
           <input type="hidden" name="city" value="${dto.city}">
           <input type="hidden" name="country" value="${dto.country}">
           <input type="hidden" name="address1" value="${dto.address1}">
           <input type="hidden" name="address2" value="${dto.address2}">
           <input type="hidden" name="zipcode" value="${dto.zipcode}">
           <input type="hidden" name="beds" value="${dto.beds}">
           <input type="hidden" name="baths" value="${dto.baths}">
           <input type="hidden" name="room_type" value="${dto.room_type}">
           <input type="hidden" name="lat" value="${dto.lat}">
           <input type="hidden" name="lng" value="${dto.lng}">
           <input type="hidden" name="max_people" value="${dto.max_people}">
           <%-- <input type="hidden" name="h_userid" value="${dto.h_userid}"> --%>
           <%-- <input type="hidden" name="h_userid" value="${dto.userid}"> --%>
          </form>
         </div>
        </div>
        

      </div>
    </div>

	<!-- 리뷰 목록  ${userid} ${profile_img} ${r_title} ${review_content} ${write_date} -->
	<div class="container px-5 my-2">
	 <section>
	  <div>
	   <h4>리뷰</h4>
	   <span>⭐4.5/5 · 후기 00개</span>
	  </div>
	  
	  <div class="container mx-auto">
		<div class="row row-cols-4 mx-auto my-3">
			<div class="card" style="width: 18rem; margin: 3px;">
			  <div class="card-body">
			    <h5 class="card-title"><img src="https://images.pexels.com/photos/63340/pexels-photo-63340.jpeg?cs=srgb&dl=pexels-sara-63340.jpg&fm=jpg" width="30px" height="30px" style="border-radius: 50%">&nbsp;guest</h5>
			    <h6 class="card-subtitle mb-2 text-muted">2022.10.20 (리뷰작성일자)</h6>
			    <p class="card-text">숙소가 깨끗하고 호스트가 친절했어요. (리뷰 작성 내용)</p>
			    <a href="#" class="card-link">더보기 > </a>
			  </div>
			</div>
			<div class="card" style="width: 18rem; margin: 3px;">
			  <div class="card-body">
			    <h5 class="card-title"><img src="https://images.pexels.com/photos/63340/pexels-photo-63340.jpeg?cs=srgb&dl=pexels-sara-63340.jpg&fm=jpg" width="30px" height="30px" style="border-radius: 50%">&nbsp;guest</h5>
			    <h6 class="card-subtitle mb-2 text-muted">2022.10.20 (리뷰작성일자)</h6>
			    <p class="card-text">숙소가 깨끗하고 호스트가 친절했어요. (리뷰 작성 내용)</p>
			    <a href="#" class="card-link">더보기 > </a>
			  </div>
			</div>
			<div class="card" style="width: 18rem; margin: 3px;">
			  <div class="card-body">
			    <h5 class="card-title"><img src="https://images.pexels.com/photos/63340/pexels-photo-63340.jpeg?cs=srgb&dl=pexels-sara-63340.jpg&fm=jpg" width="30px" height="30px" style="border-radius: 50%">&nbsp;guest</h5>
			    <h6 class="card-subtitle mb-2 text-muted">2022.10.20 (리뷰작성일자)</h6>
			    <p class="card-text">숙소가 깨끗하고 호스트가 친절했어요. (리뷰 작성 내용)</p>
			    <a href="#" class="card-link">더보기 > </a>
			  </div>
			</div>
			<div class="card" style="width: 18rem; margin: 3px;">
			  <div class="card-body">
			    <h5 class="card-title"><img src="https://images.pexels.com/photos/63340/pexels-photo-63340.jpeg?cs=srgb&dl=pexels-sara-63340.jpg&fm=jpg" width="30px" height="30px" style="border-radius: 50%">&nbsp;guest</h5>
			    <h6 class="card-subtitle mb-2 text-muted">2022.10.20 (리뷰작성일자)</h6>
			    <p class="card-text">숙소가 깨끗하고 호스트가 친절했어요. (리뷰 작성 내용)</p>
			    <a href="#" class="card-link">더보기 > </a>
			  </div>
			</div>
		</div>

  
	  </div>
	 </section>
	</div>
	
	<!-- 숙소 위치 -->
	<div class="container px-5 my-3">
	 <h4>호스팅 지역</h4>
	</div>
	<div class="container px-5">
	 <img src="${path}/resources/images/location_map_marler.png" style="width: 20px;"> 
	 <span>${dto.city}&nbsp;${dto.country}</span>
	</div>
	
	<!-- 지도 API ${dto.lat} ${dto.lng} ${dto.room_name} ${dto.country} ${dto.city}-->
	<div class="container px-5 my-3">
	  <div class="rounded" id="map" style="margin-top: 15px; height: 600px;"></div>
	</div>
	
	<!-- 호스트 정보, 이메일 문의 ${h_email} ${h_join_date} -->
	<div class="container px-5 my-3">
<div class="card">
  <div class="card-header">Host</div>
  <div class="card-body">
    <div class="d-flex">
     <div class="d-flex">
      <img src="https://images.pexels.com/photos/63340/pexels-photo-63340.jpeg?cs=srgb&dl=pexels-sara-63340.jpg&fm=jpg" width="60px" height="60px" style="border-radius: 50%">
     </div>
     <div style="margin-left: 20px;">
      <span class="card-title" style="font-size: 20px; font-weight: bold;">호스트 : ${dto.h_userid}님</span>
      <p class="card-text" style="font-size: 14px;">회원 가입일 : 2020.03.03</p>
      <a href="mailto:﻿testhost@test.com?subject=[${dto.room_name}]문의"><button type="button" class="btn btn-warning" style="font-size: 14px;">호스트에게 메일보내기</button></a>
 	 </div>
	</div>
  </div>
</div>
		
	</div>
	
  </section>
 </main>
 <!-- footer -->
 <%@ include file="../include/footer.jsp" %>



<script type="text/javascript">
//지도 스크립트
//상세조건의 값을 가져옵니다
//지도를 생성합니다    
const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
 mapOption = {
     center: new kakao.maps.LatLng("${dto.lat}", "${dto.lng}"), // 지도의 중심좌표
     level: 4 // 지도의 확대 레벨
 };  
//지도를 생성합니다    
const map = new kakao.maps.Map(mapContainer, mapOption); 

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng("${dto.lat}", "${dto.lng}"); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null); 

// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
var iwContent = '<div style="height: 100px; width:200px; padding: 5px; text-align: center; font-size: 13px; border-radius: 8px; box-shadow: 3px 3px 15px #808080;"> ${dto.room_name}<p><a href="https://map.kakao.com/link/to/${dto.country},38.1808,128.6121" style="color:blue" target="_blank"><button type="button" class="btn btn-outline-dark btn-sm">길찾기</button></a></p></div>',
    iwPosition = new kakao.maps.LatLng("${dto.lat}", "${dto.lng}"); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 


</script>

<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>