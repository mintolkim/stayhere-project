<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역 -->
<!-- flatpickr  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/rangePlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

<!-- custom js&css -->
<link rel="stylesheet" type="text/css"	href="${path}/resources/css/search.css">
<!-- 그외 페이지별 들어갈 script & css 추가 영역 -->

<title>STAYHERE</title>
</head>
<body class="d-flex flex-column">
	<%@ include file="../include/navbar.jsp"%>

	<c:if test="${map.error != null }">
		<script type="text/javascript">
		 	alert("${map.error}");
		</script>
	</c:if>
	
	<!-- search-bar -->
	<div class="search-wrap search-fixed mt-5">
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

	
	<!-- 컨텐츠 수정 영역 start -->
	<div class="container">
		<div class="my-5">
			<div class="row">
				<!-- 좌측 필터 영역  -->
				<div class="col-lg-3 p-2">
				 <div class="filter-option-wrap">
					<div class="btn-list-map text-center p-4 border rounded-5">
						<button class="btn btn-custom w-100" onclick="goToMap()">
						 지도로 보기</button>
					</div>
					<form method="get" name="filterFrom">
						<div class="filter-sec p-2">
							<!-- 정렬기준 옵션 -->
							<div class="sort-option border-bottom py-4">
								<div class="filter-name mb-3 fw-bold">정렬기준</div>
								<select class="form-select" name="sort" id="sort"
									onchange="filterFormSubmit(filterFrom)">
									<option value="res_count" selected>추천순</option>
									<option value="price_desc">가격높은순</option>
									<option value="price_asc">가격낮은순</option>
									<option value="review_asc">평점높은순</option>
									<option value="review_desc">평점낮은순</option>
								</select>
							</div>
							
							<!-- 후기평점  -->
							<div class="review-option border-bottom py-4">
								<div class="filter-name mb-3 fw-bold">후기평점</div>
								<input class="form-check-input" type="radio" name="reviewStar"
									id="review-0" value="0" onchange="filterFormSubmit(filterFrom)" checked>
								<label class="form-check-label" for="review-1">0+</label> 
								<input class="form-check-input" type="radio" name="reviewStar"
									id="review-1" value="1" onchange="filterFormSubmit(filterFrom)">
								<label class="form-check-label" for="review-1">1+</label> 
								<input	class="form-check-input" type="radio" name="reviewStar"
									id="review-2" value="2" onchange="filterFormSubmit(filterFrom)">
								<label class="form-check-label" for="review-2">2+</label> 
								<input class="form-check-input" type="radio" name="reviewStar"
									id="review-3" value="3" onchange="filterFormSubmit(filterFrom)">
								<label class="form-check-label" for="review-3">3+</label> 
								<input class="form-check-input" type="radio" name="reviewStar"
									id="review-4" value="4" onchange="filterFormSubmit(filterFrom)">
								<label class="form-check-label" for="review-4">4+</label> 
								<input class="form-check-input" type="radio" name="reviewStar"
									id="review-5" value="5" onchange="filterFormSubmit(filterFrom)">
								<label class="form-check-label" for="review-5">5+</label>
							</div>
							
							<!-- 가격범위  -->
							<div class="price-option border-bottom py-4">
								<div class="filter-name mb-3 fw-bold">가격범위</div>
								<div class="slider">
									<div class="progress"></div>
								</div>
								<div class="range-input">
									<input type="range" class="range-min" name="lower" step="10000"	min="0"	max="1000000"
										<c:choose>
											<c:when test="${param.lower != null}">
												value="${param.lower}"
											</c:when>
											<c:otherwise>
												value="0"
											</c:otherwise>
										</c:choose>
										onchange="filterFormSubmit(filterFrom)"> 
										
										<input type="range" class="range-max" name="higher" step="10000" min="0"	max="1000000"
											<c:choose>
											<c:when test="${param.higher != null}">
												value="${param.higher}"
											</c:when>
											<c:otherwise>
												value="1000000"
											</c:otherwise>
										</c:choose>
										onchange="filterFormSubmit(filterFrom)">
								</div>
								<div class="result-price pt-3">
									<div class="field">
										<span>최소</span> 
										<input type="number" class="result-min"
											<c:choose>
													<c:when test="${param.lower != null}">
														value="${param.lower}"
													</c:when>
													<c:otherwise>
														value="0"
													</c:otherwise>
												</c:choose>
											readonly>
									</div>
									<div class="separator">-</div>
									<div class="field">
										<span>최대</span> 
										<input type="number" class="result-max"
											<c:choose>
													<c:when test="${param.higher != null}">
														value="${param.higher}"
													</c:when>
													<c:otherwise>
														value="1000000"
													</c:otherwise>
												</c:choose>
											readonly>
									</div>
								</div>
							</div>
							
							<!-- 옵션선택 -->
							<div class="other-option border-bottom py-4">
								<div class="filter-name mb-3 fw-bold">옵션선택</div>

								<!-- 인원수 옵션  -->
								<div class="personnel-filter row mb-1">
									<label for="personnel" class="col-sm-6 col-form-label">인원수</label>
									<div class="col-sm-6">
										<select class="form-select" name="people" id="people"
											onchange="filterFormSubmit(filterFrom)">
											<option value="" disabled selected>선택</option>
											<option value="1">1명</option>
											<option value="2">2명</option>
										</select>
									</div>
								</div>

								<!-- 침대옵션 -->
								<div class="beds-filter row mb-1">
									<label for="beds" class="col-sm-6 col-form-label">침대수</label>
									<div class="col-sm-6">
										<select class="form-select" name="bed" id="bed"
											onchange="filterFormSubmit(filterFrom)">
											<option value="" disabled selected>선택</option>
											<option value="1">1개</option>
											<option value="2">2개</option>
											<option value="3">3개</option>
											<option value="4">4개이상</option>
										</select>
									</div>
								</div>

								<!-- 화장실 옵션 -->
								<div class="baths-filter row mb-1">
									<label for="baths" class="col-sm-6 col-form-label">화장실수</label>
									<div class="col-sm-6">
										<select class="form-select" name="bath" id="bath"
											onchange="filterFormSubmit(filterFrom)">
											<option value="" disabled selected>선택</option>
											<option value="1">1개</option>
											<option value="2">2개</option>
											<option value="3">3개</option>
											<option value="4">4개이상</option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</form>
							<!-- 전체 버튼 초기화 -->
							<div class="mt-2 text-end">
				        <a href="#" class="text-decoration-underline fs-6 text-secondary" 
				        onclick="resetOption()">옵션초기화</a>
				    	</div>
					</div>
				</div>

				<!-- 우측 검색 결과 -->
				<div class="col-lg-9">
					<c:choose>
						<c:when test="${map.count > 0 }">
							<div class="search-count p-2">
								<span><b>${map.count}개</b>의 데이터가 검색되었습니다.</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="search-count p-2">
								<span>검색결과가 없습니다. 다시 검색해주세요.</span>
							</div>
						</c:otherwise>
					</c:choose>
					<!--검색 결과 정보-->
					<div class="list-wrap">
						<div class="list-item">
							<c:forEach var="row" items="${map.list}">
								<section class="result-rooms-list my-3">
										<a href="${path}/rooms/detail/${row.room_idx}" class="text-black text-decoration-none">
										<div class="card my-2 border rounded-5" style="max-width: 100%;">
											<div class="row g-0">
												<div class="col-md-4">
													<div id="indicators-${row.room_idx}" class="carousel slide indicators"
														data-interval="false">
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
														<div class="carousel-inner rounded-img-start">
															<div class="carousel-item active">
																<img src="${path}/imgUpload/${row.photo1}"
																	class="d-block w-100 card-img-size-h-300" alt="...">
															</div>
															<div class="carousel-item card-img">
																<img src="${path}/imgUpload/${row.photo2}"
																	class="d-block w-100 card-img-size-h-300" alt="...">
															</div>
															<div class="carousel-item card-img">
																<img src="${path}/imgUpload/${row.photo3}"
																	class="d-block w-100 card-img-size-h-300" alt="...">
															</div>
															<div class="carousel-item card-img">
																<img src="${path}/imgUpload/${row.photo4}"
																	class="d-block w-100 card-img-size-h-300" alt="...">
															</div>
														</div>
														<button class="carousel-control-prev" type="button"
															data-bs-target="#indicators-${row.room_idx}"
															data-bs-slide="prev">
															<span class="carousel-control-prev-icon"
																aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
														</button>
														<button class="carousel-control-next" type="button"
															data-bs-target="#indicators-${row.room_idx}"
															data-bs-slide="next">
															<span class="carousel-control-next-icon"
																aria-hidden="true"></span> <span class="visually-hidden">Next</span>
														</button>
													</div>
												</div>
												<div class="col-md-8">
													<div class="card-body p-4">
														<div
															class="d-flex justify-content-between align-items-center py-1 pt-2">
															<h4 class="room-title fw-bold mb-0 text-truncate px-2 ">
																${row.room_name}</h4>
															<p class="icon mb-0">
																<c:choose>
																	<c:when test="${row.review_count > 0}">
																		<i class="bi-star-fill"></i>
																		<span><fmt:formatNumber pattern="#.00"
																				value="${row.review_star}" /></span>
																		<span>(${row.review_count})</span>
																	</c:when>
																	<c:otherwise>
																		<i class="bi-star-fill"></i>(0)
																</c:otherwise>
																</c:choose>
															</p>
														</div>
														<p class="card-text text-secondary mt-0 px-2 small">
															<i class="bi bi-geo-alt-fill pe-1"></i>${row.city}, ${row.country}
														</p>
														<p class="card-text text-secondary px-2 mb-4"> ${row.contents}<span>...</span></p>
														<p class="card-text text-secondary mb-1 px-2 small">
															<i class="bi bi-calendar-check pe-1"></i>
															<fmt:formatDate pattern="MM월 dd일" value="${row.check_in}" />
															<span>~</span>
															<fmt:formatDate pattern="MM월 dd일" value="${row.check_out}" />
														</p>
														<p class="card-text text-secondary mb-1 px-2 small">
															<i class="bi bi-check-square-fill pe-1"></i> 
															침대	${row.beds} · 화장실 ${row.baths} · 최대인원 ${row.max_people}
														</p>
														<p class="card-text mt-3 text-end">
															<span class="fw-bold fs-4"> ￦ <fmt:formatNumber
																	pattern="#,###" value="${row.room_price}" />
															</span> /박
														</p>
													</div>
												</div>
											</div>
										</div>
										</a>
								</section>
							</c:forEach>
						</div>
					</div>
					<c:if test="${map.count > 0}">
						<!-- 페이지네이션 -->
						<nav class="d-flex justify-content-center my-2"
							aria-label="Search results pages">
							<ul class="pagination">
								<c:choose>
									<c:when test="${map.pager.curPage > 1}">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Previous"
											onclick="pagination('${map.pager.prevPage}')"> <span
												aria-hidden="true">&laquo;</span>
										</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item disabled"><a class="page-link"
											href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a></li>
									</c:otherwise>
								</c:choose>
								<c:forEach var="num" begin="${map.pager.blockBegin}"
									end="${map.pager.blockEnd}">
									<c:choose>
										<c:when test="${num == map.pager.curPage}">
											<li class="page-item active" aria-current="page"><a
												class="page-link">${num}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="#"
												onclick="pagination('${num}')">${num}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${map.pager.curPage < map.pager.totPage}">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Next"
											onclick="pagination('${map.pager.nextPage}')"> <span
												aria-hidden="true">&raquo;</span>
										</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item disabled"><a class="page-link"
											href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
						<!-- 페이지 네이션 끝 -->
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<script>
	
		$(function(){
			optionChecked(); 
			multiRangeHandler(); 
			
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
		
		
		//멀티 Range 핸들러 스크립트
		function multiRangeHandler(){
			const rangeInput = document.querySelectorAll(".range-input input");
	    const resultPrice = document.querySelectorAll(".result-price input");
	    const range = document.querySelector(".slider .progress");
	    
			let priceGap = 50000;

	    resultPrice.forEach(input => {
	        input.addEventListener("input", e => {
	            let minPrice = parseInt(resultPrice[0].value);
	            let maxPrice = parseInt(resultPrice[1].value);

	            if ((maxPrice - minPrice >= priceGap) && maxPrice <= rangeInput[1].max) {
	                if (e.target.className === "input-min") {
	                    rangeInput[0].value = minPrice;
	                    range.style.left = ((minPrice / rangeInput[0].max) * 100) + "%";
	                } else {
	                    rangeInput[1].value = maxPrice;
	                    console.log(rangeInput[1].max);
	                    range.style.right = 100 - (maxPrice / rangeInput[1].max) * 100 + "%";
	                }
	            }
	        });
	    });
	    
	    rangeInput.forEach(input => {
	        input.addEventListener("input", e => {
	            let minVal = parseInt(rangeInput[0].value);
	            let maxVal = parseInt(rangeInput[1].value);
	            
	            if ((maxVal - minVal) < priceGap) {
	                if (e.target.className === "range-min") {
	                    rangeInput[0].value = maxVal - priceGap;
	                } else {
	                    rangeInput[1].value = minVal + priceGap;
	                }
	            } else {
	                resultPrice[0].value = minVal;
	                resultPrice[1].value = maxVal;
	                range.style.left = ((minVal / rangeInput[0].max) * 100) + "%";
	                range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
	            }
	        });
	    });	    
		}
    
    //지도 페이지로 이동하기
    function goToMap(){
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
    	
    	const param = location.search; //현재 주소URL에 있는 파라미터 값 가져오기 
    	location.href = "${path}/search/map/${map.cityname}/${map.checkin_date}/${map.checkout_date}" + param;
    }
    
    //필터 ajax통신
    function filterFormSubmit(f){
    	var cityname = $("#cityname").val();
		  var checkIn = $("#checkin_date").val();
		  var checkOut = $("#checkout_date").val();
		  var sort = $("#sort").val();
		  var people = $("#people").val();
		  var bed = $("#bed").val();
		  var bath = $("#bath").val();
		  var lower = $(".range-min").val();
		  var higher = $(".range-max").val();
	
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
		  
// 		  $.ajax({
// 			  type : "get",
// 			  url : "${path}/search/"+cityname+"/"+checkIn+"/"+checkOut,
// 			  data : {
// 				  "city" : cityname,
// 				  "check_in" : checkIn,
// 				  "check_out" : checkOut,
// 				  "sort" : sort,
// 				  "people" : people,
// 				  "bed" : bed,
// 				  "bath" : bath,
// 				  "lower" : lower,
// 				  "higher" : higher
// 			  },
// 			  success : function(date){
// 				  console.log("통신 성공");
// 				  console.log("date")
// 			  }
// 		  })
		  
		  f.aciton = "${path}/search/" + cityname +"/" + checkIn + "/" + checkOut;
		  f.submit();
    }
    
    //페이지네이션 이동
    function pagination(page){
//     	console.log(page);
    	const nowUrl = location.href; //현재주소
    	const isParam = location.search;
    	const searchParams = new URL(nowUrl).searchParams; //파라미터값 담기
    	const pageParam = searchParams.get("page");
    	
    	if(isParam == ""){ //만약 파라미터값이 없다면
    		location.href = nowUrl + "?page=" + page;	
    	} else if(pageParam == null) { //만약 파라미터에 page 값이 없다면..
    		location.href = nowUrl + "&page=" + page;	
    	} else { //page값이 있다면
    		searchParams.set("page", page); //page 파라미터 값을 변경 
//     		console.log(searchParams.toString()); 
    		const newParam = searchParams.toString(); //파라미터 값을 가져오고
//     		console.log(newParam);
    		const url = location.href.split("?"); //현재 url에서 파라미터 값을 제외한 url을 가져온다.
//     		console.log(url[0]);
    		location.href = url[0] +"?"+newParam;
    	}
    }
    
    function optionChecked(){    	
    	const nowUrl = location.href; //현재주소
    	const searchParams = new URL(nowUrl).searchParams;
    	const rangeInput = document.querySelectorAll(".range-input input");
			const range = document.querySelector(".slider .progress");
			
			var sort = searchParams.get("sort");
			var reviewStar = searchParams.get("reviewStar");
    	var minVal = searchParams.get("lower");
    	var maxVal = searchParams.get("higher");
    	var people = searchParams.get("people");
    	var bed = searchParams.get("bed");
    	var bath = searchParams.get("bath");

    	if(sort != null){
    		$("#sort").val(sort).attr("selected", "selected");
    	} else {
    		$("#sort").val("res_count").attr("selected", "selected");
    	}
    	
    	if(reviewStar != null){
    		$("#review-"+reviewStar).val(reviewStar).prop("checked", true);
    	} else {
    		
    	}
    	
    	if(minVal != null || maxVal != null){
				range.style.left = ((minVal / rangeInput[0].max) * 100) + "%";
     		range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
			}
    	
    	if(people != null){
    		$("#people").val(people).attr("selected", "selected");
    	}
    	
    	if(bed != null){
    		$("#bed").val(bed).attr("selected", "selected");
    	}
    	
    	if(bath != null){
    		$("#bath").val(bath).attr("selected", "selected");
    	}
    	
    }
    
     
   
    //옵션전체초기화
    function resetOption(){
    	var cityname = $("#cityname").val();
		  var checkIn = $("#checkin_date").val();
		  var checkOut = $("#checkout_date").val();
    	
			location.href = "${path}/search/" + cityname +"/" + checkIn + "/" + checkOut;
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
    	 
 			 console.log("scrollTop : " + scrollTop);
 			 console.log("windowsHeight : " + windowsHeight);
 			 console.log("documentHeight : " + documentHeight);
 		
 			 if(windowsHeight > 730){
         if ($(this).scrollTop() > searchBar.top+300) {
    	 			console.log(searchBar.top);
             $(".search-fixed").addClass('fixed');
             $(".search-fixed").removeClass('search-wrap');
             $(".search-fixed").removeClass('mt-5');
             $(".filter-option-wrap").addClass('fixed');
         } else {
             $(".search-fixed").removeClass('fixed');
             $(".search-fixed").addClass('search-wrap');
             $(".search-fixed").addClass('mt-5');
             $(".filter-option-wrap").removeClass('fixed');
         }
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

	<!-- 컨텐츠 수정 영역 end -->

	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
>>>>>>> branch 'commit(jys)' of https://github.com/mintolkim/styahere-project.git
</html>