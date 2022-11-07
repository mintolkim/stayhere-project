<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>

<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52817c98591dad1c8811f3daa6bca00b"></script>

<style type="text/css">
#map{
 width: 100%;
 height:100%;
 border-radius: 15px;
}
</style>

</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역 시작 -->
  <section class="mt-3 mb-5" id="features">
	    <div class="container px-5 mx-0 mb-4">
		<h3>관심스테이</h3>
			<c:choose>
				<c:when test="${wishCount==0}">
					<span class="fs-6">추가한 관심 스테이가 없습니다.</span><br><br>
					<a href="${path}/">스테이히어의 다양한 숙소를 살펴보려면 이곳을 클릭!</a>
				</c:when>
				<c:otherwise>
					<span class="fs-6">${wishCount}개의 관심스테이가 있습니다.</span>
		    	</c:otherwise>
		    </c:choose>
		</div>
	
	<!-- 페이지 전체 영역 -->
	<div class="row" style="padding: 0;">
		
		<!-- 숙소 목록 영역 , 전체 페이지의 50%(캐러셀 형태 출력) -->
 		<div class="col-lg-6 px-0">
			<div class="container-fluid">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="wish" items="${wishList}">
						<section class="list-item col-lg-6">
							<a href="${path}/rooms/detail/${wish.room_idx}" class="text-black text-decoration-none"> 
								<div class="card border-0" style="width: 100%;">
									<div class="card-img">
										<!-- 이미지가 여러장 일경우 인디케이터 사용 -->
										<div id="indicators-${wish.room_idx}" class="carousel slide indicators">
											<div class="carousel-indicators">
												<button type="button"
													data-bs-target="#indicators-${wish.room_idx}"
													data-bs-slide-to="0" class="active" aria-current="true"
													aria-label="Slide 1"></button>
												<button type="button"
													data-bs-target="#indicators-${wish.room_idx}"
													data-bs-slide-to="1" aria-label="Slide 2"></button>
												<button type="button"
													data-bs-target="#indicators-${wish.room_idx}"
													data-bs-slide-to="2" aria-label="Slide 3"></button>
												<button type="button"
													data-bs-target="#indicators-${wish.room_idx}"
													data-bs-slide-to="3" aria-label="Slide 4"></button>
											</div>
											<div class="img-list carousel-inner rounded-img">
												<div class="carousel-item active">
													<img src="${path}/imgUpload/${wish.photo1}"
														class="d-block w-100 card-img-size" alt="...">
												</div>
												<div class="carousel-item card-img">
													<img src="${path}/imgUpload/${wish.photo2}"
														class="d-block w-100 card-img-size" alt="...">
												</div>
												<div class="carousel-item card-img">
													<img src="${path}/imgUpload/${wish.photo3}"
														class="d-block w-100 card-img-size" alt="...">
												</div>
												<div class="carousel-item card-img">
													<img src="${path}/imgUpload/${wish.photo4}"
														class="d-block w-100 card-img-size" alt="...">
												</div>
											</div>
											<button class="carousel-control-prev" type="button"
												data-bs-target="#indicators-${wish.room_idx}" data-bs-slide="prev">
												<span class="carousel-control-prev-icon" aria-hidden="true"></span>
												<span class="visually-hidden">Previous</span>
											</button>
											<button class="carousel-control-next" type="button"
												data-bs-target="#indicators-${wish.room_idx}"
												data-bs-slide="next">
												<span class="carousel-control-next-icon" aria-hidden="true"></span>
												<span class="visually-hidden">Next</span>
											</button>
										</div>
										<div
											class="btn boder-0 shadow-none card-img-overlay-top text-end">
											<i id="wish-icon-${wish.room_idx}" class="bi-heart text-danger fw-bold fs-5"
												onclick="wishListToggle(event, ${wish.room_idx})"></i>
										</div>
									</div>
									<div class=" card-body">
										<div
											class="d-flex justify-content-between align-items-center py-1 pb-2">
											<p class="room-title fw-bold mb-0 text-truncate">${wish.room_name}</p>
										<%-- 
											리뷰 별점 표시 											
											<p class="icon mb-0">
 												<c:if test="${row.review_count > 0}">
													<i class="bi-star-fill"></i>
													<span> <fmt:formatNumber pattern="#.00"
															value="${row.review_star}" />
													</span>
												</c:if>
											</p>  				--%>
										</div>
										<p class="card-text text-secondary mb-0 small">
											${wish.contents}</p>
										<p class="card-text text-secondary mb-0 small">
											<fmt:formatDate pattern="MM월 dd일" value="${wish.check_in}" />
											<span>~</span>
											<fmt:formatDate pattern="MM월 dd일" value="${wish.check_out}" />
										</p>	
										<p class="card-text mb-0 pt-2">
											<span class="fw-bold">￦ <fmt:formatNumber
													pattern="#,###" value="${wish.room_price}" />
											</span> <span>/박</span>
										</p>
									</div>
								</div>
							</a>
						</section>
	

					</c:forEach>
				</div>
			</div>
   		 </div>
		<!-- 지도 영역 , 전체 페이지의  50%(숙소 위치에 마커) -->
		<div class="col-6 ps-0 pe-4">
			<div id="map">

			</div>
		</div>
		
		
	</div>
	


  </section>
  <!-- 본문영역 끝 -->
<script type="text/javascript">
//지도출력
var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var mapOption = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(35.8773582, 128.6042956), //지도의 중심좌표.
	level: 10 //지도의 레벨(확대, 축소 정도)
};
var map = new kakao.maps.Map(mapContainer, mapOption); //지도 생성 및 객체 리턴


//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
var mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);


//불러온 json배열을 저장
var addressList =JSON.parse('${map.addressList}');

var adrArray = [];
for(var k in addressList){
    var $obj = addressList[k];
    adrArray.push({
    	content : '<div style="height:155px;padding:5px;">'+
    	'<img src="${path}/imgUpload/'+$obj.photo1+'"style="width:100%;height:100px;"><br>'+
    	'<span style="font-size:12px;"><b>'+$obj.room_name+'</b></span><br>'+
    	'<span style="font-size:12px;">'+$obj.room_price.toLocaleString()+'원</span></div>',
    	latlng: new kakao.maps.LatLng($obj.lat,$obj.lng),
    	price: $obj.room_price
    });
}
var imageSrc = 'https://cdn-icons-png.flaticon.com/512/6005/6005818.png', // 마커이미지의 주소입니다    
imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다.

//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
 markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

for (var i = 0; i < adrArray.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: adrArray[i].latlng, // 마커의 위치
        image: markerImage // 마커이미지 설정 
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

</script>

<script type="text/javascript">
$(function(){
	wishListCheck();
});	

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
    					location.href="${path}/wishlist/list.do";
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

 </main>
 <!-- footer -->
 <%@ include file="../include/footer.jsp"%>
</body>
</html>