<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="./include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역  start-->
<!-- flatpickr  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/rangePlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

<!-- 그외 페이지별 들어갈 script & css 추가 영역 end -->
<title>STAYHERE</title>

</head>
<body class="d-flex flex-column">
<!-- nav_search_bar 는 검색창 노출화면 -->
<%@ include file="./include/navbar.jsp" %>

<!-- 컨텐츠 수정 영역 start -->
<!-- search-bar -->
<div class="bg-image-full">
<div class="py-5 search-bg-wrap" style="background-image: url('${path}/resources/images/main_bg_03.jpg')">
	<div class="container search-wrap">
		<div class="search-fixed">
		<div class="search-bar border px-4">
			<form method="post" id="searchFrom">
				<div class="row">
					<div class="col-lg-5 col-sm-5 col-12 d-flex align-items-center rounded-pill">
						<div class="form-floating form-group w-100">
							<input class="form-control border-0 shadow-none" id="cityname"
								name="cityname" placeholder="여행지를 입력해주세요" value="${map.cityname}"> 
								<label for="cityname">여행지 입력</label>
						</div>
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
							onclick="submitMainSearch(searchFrom)">
							<i class="bi-search"></i>
						</button>
					</div>
				</div>
			</form>
		</div>
		</div>
	</div>
</div>
</div>


<!-- room-list-->
<div class="room-list-wrap">
	<div class="container-fluid p-4 mt-3">
		<div id="room-list"	class="row g-3">
			<c:forEach var="row" items="${map.list}">
				<section class="list-item col-xxl-2 col-xl-3 col-lg-3 col-md-4 col-sm-6">
						<div class="card border-0" style="width: 100%; cursor: pointer;" onclick="goToDetail(${row.room_idx})">
							<div class="card-img">
								<!-- 이미지가 여러장 일경우 인디케이터 사용 -->
								<div id="indicators-${row.room_idx}" class="carousel slide indicators stop-action">
									<div class="carousel-indicators">
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="0" class="active" aria-current="true"
											aria-label="Slide 1"></button>
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="1" aria-label="Slide 2"></button>
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="2" aria-label="Slide 3"></button>
										<button type="button"
											data-bs-target="#indicators-${row.room_idx}"
											data-bs-slide-to="3" aria-label="Slide 4"></button>
									</div>
									<div class="img-list carousel-inner rounded-img">
										<div class="carousel-item active">
											<img src="${path}/imgUpload/${row.photo1}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
										<div class="carousel-item card-img">
											<img src="${path}/imgUpload/${row.photo2}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
										<div class="carousel-item card-img">
											<img src="${path}/imgUpload/${row.photo3}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
										<div class="carousel-item card-img">
											<img src="${path}/imgUpload/${row.photo4}"
												class="d-block w-100 card-img-size" alt="...">
										</div>
									</div>
									<button class="carousel-control-prev" type="button"
										data-bs-target="#indicators-${row.room_idx}" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</button>
									<button class="carousel-control-next" type="button"
										data-bs-target="#indicators-${row.room_idx}"
										data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</button>
								</div>
								<div class="btn boder-0 shadow-none card-img-overlay-top text-end">
									<i id="wish-icon-${row.room_idx}" class="bi-heart text-danger fw-bold fs-5"
										onclick="wishListToggle(event, ${row.room_idx})"></i>
								</div>
							</div>
							<div class=" card-body">
								<div
									class="d-flex justify-content-between align-items-center py-1 pb-2">
									<p class="room-title fw-bold mb-0 text-truncate">${row.country},
										${row.city}</p>
									<p class="icon mb-0">
										<c:if test="${row.review_count > 0}">
											<i class="bi-star-fill"></i>
											<span> <fmt:formatNumber pattern="#.00"
													value="${row.review_star}" />
											</span>
										</c:if>
									</p>
								</div>
								<p class="card-text text-secondary mb-0 small">
									침대	${row.beds} · 화장실 ${row.baths}</p>
								<p class="card-text text-secondary mb-0 small">
									<fmt:formatDate pattern="MM월 dd일" value="${row.check_in}" />
									<span>~</span>
									<fmt:formatDate pattern="MM월 dd일" value="${row.check_out}" />
								</p>	
								<p class="card-text mb-0 pt-2">
									<span class="fw-bold">￦ <fmt:formatNumber
											pattern="#,###" value="${row.room_price}" />
									</span> <span>/박</span> 
<!-- 									<span>·</span> <span>  -->
<!-- 									<a href="#2" class="text-secondary">총액 ￦  -->
<%-- 									<fmt:formatNumber	pattern="#,###" value="${row.room_price}" /> --%>
<!-- 									</a></span> -->
								</p>
							</div>
						</div>
				</section>
			</c:forEach>
		</div>
	</div>
</div>
<!-- 컨텐츠 수정 영역 end -->

<script type="text/javascript">

	$(function(){
		wishListCheck();
		
		//상위 링크 이동 맊기 () 이미지 위 버튼 클릭 
		$(".stop-action button").on("click", function(e){
			e.stopPropagation();
		});
				
		$('.indicators').carousel({
	      // 슬리아딩 자동 순환 지연 시간
	      // false면 자동 순환하지 않는다.
	      interval: false,
	      // hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
	      pause: "hover",
	      // 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
	      wrap: true
		});
	});

	var curPage = 1;
	var totPage = ${map.pager.totPage};
	var isLoading = false;

	$(window).on("scroll", function() {
		var scrollTop = $(window).scrollTop(); // 위로 스크롤된 길이
		var windowsHeight = $(window).height(); //웹브라우저의 창의 높이
		var documentHeight = $(document).height(); // 문서 전체의 높이
		var isBottom = scrollTop + windowsHeight + 10 >= documentHeight;
// 		console.log("isLoading : " + isLoading);
		if (isBottom) {
				//만일 현재 마지막 페이지라면
				if (curPage >= totPage || isLoading) {
					return false; //함수종료
				} else {
					isLoading = true; //위에서 종료되지 않으면 로딩상태를 true로 변경
					$("#load").show(); //로딩바 표시
					curPage++; //현재페이지 1증가
					getRoomsList(curPage); //추가로 받을 리스트 ajax처리
				}
		}
	});

	//룸리스트 불러오기
	function getRoomsList(curPage) {
		$.ajax({
			type : "get",
			url : "${path}/addRoomsList",
			data : {
				"curPage" : curPage
			},

			success : function(data) {
// 			console.log(data);
				$("#room-list").append(data); //불러온 데이터 추가
				wishListCheck(); // 위시리스트 체크 여부 확인
				isLoading = false;
				$("#load").hide(); //로딩바 숨기기
			}
		});
	}
	
	
	//디테일 페이지로 이동하기
	function goToDetail(room_idx){
		if(room_idx != ""){
			location.href= "${path}/rooms/detail/"+room_idx;
		} else {
			alert("에러.....");
		}
	}
	
	
	//페이지 로드시 위시리스트 체크여부 확인
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
	
	//위시리스트 버튼 클릭
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
	    					alert("위시리스트에 추가되지 않았습니다.");
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
      
	 });
	 
     var searchBar = $(".search-wrap").offset();
     
          
     $(window).on("scroll", function () {
    	 
    	 var scrollTop = $(this).scrollTop(); // 위로 스크롤된 길이
 			 var windowsHeight = $(this).height(); //웹브라우저의 창의 높이
 			 var documentHeight = $(document).height(); // 문서 전체의 높이
 		
         if ($(this).scrollTop() > searchBar.top+300) {
    	 			console.log(searchBar.top);
             $(".search-fixed").addClass('fixed');
             $(".filter-option-wrap").addClass('fixed');
         } else {
             $(".search-fixed").removeClass('fixed');
             $(".filter-option-wrap").removeClass('fixed');
         }
    	 
     });

		//검색창 입력
		function submitMainSearch(f) {
		    //입력폼 유효성 검사
		    var cityname = $("#cityname").val();
		    var checkIn = $("#checkin_date").val();
		    var checkOut = $("#checkout_date").val();
	
		    if(cityname == ""){
			     alert("여행지를 입력해주세요.");
			     $("#cityname").focus();
			     return false;
			  }
		
			  if(checkIn == ""){
			     alert("체크인 날짜를 선택해주세요");
			     $("#checkin_date").focus();
			     return false;
			  }
		
			  if(checkOut == ""){
			      alert("체크아웃 날짜를 선택해주세요.");
			      $("#checkout_date").focus();
			      return false;
			  }
		    
		    f.action = "${path}/search/"+cityname+"/"+checkIn+"/"+checkOut;
		    f.submit();
		}
	 
	</script>

<!-- footer -->
<%@ include file="./include/footer.jsp" %>

</body>
</html>