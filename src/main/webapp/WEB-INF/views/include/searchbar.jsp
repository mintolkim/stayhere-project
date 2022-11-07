<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--search bar start -->



	<div class="search-wrap d-flex justify-content-center">
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
		
	<!-- search bar end -->
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
 		
         if ($(this).scrollTop() > searchBar.top+300) {
    	 			console.log(searchBar.top);
             $(".search-wrap").addClass('fixed');
             $(".filter-option-wrap").addClass('fixed');
         } else {
             $(".search-wrap").removeClass('fixed');
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
