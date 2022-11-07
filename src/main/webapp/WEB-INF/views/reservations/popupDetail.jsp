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

<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52817c98591dad1c8811f3daa6bca00b&libraries=services"></script>
<style type="text/css">
* {
 font-family: 'Dongle' !important; sans-serif;
 font-family: 'Montserrat' !important; sans-serif;
}
</style>
</head>
<body style="width: 400px;">
	<div style="margin: 0 auto; margin-left: 40px; margin-top: 30px; text-align: center;">
		<c:choose>
			<c:when test="${res.res_state == '예약요청'}">
				<h3 class="badge bg-warning">예약요청</h3>
			</c:when>
			<c:when test="${res.res_state == '예약취소'}">
				<h3 class="badge bg-danger">취소완료</h3>
			</c:when>
			<c:otherwise>
				<h3 class="badge bg-secondary">이용완료</h3>
			</c:otherwise>
		</c:choose>
		<br>
		 <h5><span class="reserveMember_room_title">${room.room_name}</span></h5>
		
		<hr class="gray_line mt-4 mb-4">
	</div>

	<div style="margin: 0 auto; margin-left: 40px; text-align: left;">
		<div>
			<table class="table table-borderless reservationDetail_small_text">
				<tr>
					<td>
						<strong>체크인</strong>
					</td>
					<td>${res.checkin_date}</td>
				</tr>
				<tr>
					<td>
						<strong>체크아웃</strong>
					</td>
					<td>${res.checkout_date}</td>
				</tr>
				<tr>
					<td>
						<strong>예약번호</strong>
					</td>
					<td>${res.res_idx}</td>
				</tr>
				<tr>
					<td>
						<strong>예약자 이름</strong>
					</td>
					<td>${res.name}</td>
				</tr>
				<tr>
					<td>
						<strong>전화번호</strong>
					</td>
					<td>${res.phone}</td>
				</tr>
			</table>
			
			<hr class="gray_line mt-4 mb-2">
			
			<div>
				<i class="bi bi-geo-alt-fill"></i>
				<span>${room.city}</span>
				<span>${room.country}</span>
				<!-- 지도 API ${dto.lat} ${dto.lng} ${dto.room_name} ${dto.country} ${dto.city}-->
				<div>
				  <div class="rounded" id="map" style="margin-top: 15px; height: 200px;"></div>
				</div>
			</div>	
				
			<hr class="gray_line mt-2 ">

			<table class="table table-borderless reservationDetail_small_text">
				<tr>
					<td>
						<strong>결제 일자</strong>
					</td>
					<td><fmt:formatDate value="${res.res_date}" pattern="yyyy.MM.dd" /></td>
				</tr>
				<tr>
					<td>
						<strong>결제 수단</strong>
					</td>
					<td><%-- ${res_payment} --%>카카오페이</td>
				</tr>

				<c:choose>
					<c:when test="${res.res_state == '예약취소' }">
						<tr>
							<td>
								<strong>결제 금액</strong>
							</td>
							<td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/>원</td>
						</tr>
						<tr>
							<td>
								<strong>환불 금액</strong>
							</td>
							<td style="color: red;"><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/>원</td>
						</tr>
					</c:when>

					<c:otherwise>
						<tr>
							<td>
								<strong>결제 금액</strong>
							</td>
							<td><fmt:formatNumber value="${res.total_price}" pattern="#,###,###"/>원</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<div class="mb-5"></div>
		</div>
	</div>
	
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
var iwContent = '<a href="https://map.kakao.com/link/to/${room.country},38.1808,128.6121" style="color:blue" target="_blank">길찾기</a>',
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