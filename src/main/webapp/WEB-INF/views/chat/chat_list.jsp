<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역  start-->

<!-- 그외 페이지별 들어갈 script & css 추가 영역 end -->
<title>STAYHERE</title>

<style type="text/css">
.title {
    text-align: center;
    font-size: 26px;
    font-weight: bold;
    letter-spacing: 10px;
}

.profile {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
}

.thumb img {
    width: 100%;
    height: 155px;
    border-top-left-radius: 1rem;
    border-bottom-left-radius: 1rem;
}

.info p {
    text-align: left;
    margin: 0;
    padding:0;
}

.search-input input[name='keyword']::placeholder{
	font-size: 0.85rem;
}

</style>

</head>
<body class="d-flex flex-column">

	<%@ include file="../include/navbar.jsp"%>
	
	<!-- 컨텐츠 수정 영역 start -->
	<div class="container">
		<section class="col-lg-12 mt-3 mb-5 mb-3 mx-5 px-5" id="features">
			<div class="default_width container-fluid mx-5" align="center">
				<div class="row" align="center">
					<!-- 사이트바  -->
					<div class="list-group col-sm-2 mt-4 mx-2 px-2" id="profile-tab">
						<div class="container" id="box">
							<img class="profile" src="./resources/images/guest.png">
						</div>
						<br> 
						<a	href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">프로필</a> 
						<a href="${path}/reservations/list/guest"	class="list-group-item list-group-item-action">예약내역</a> 
						<a href="" class="list-group-item list-group-item-action">내가 작성한 리뷰</a> 
						<a href="${path}/chatlist" class="list-group-item list-group-item-action">나의 채팅목록</a>
						<a href="#" class="list-group-item list-group-item-action">관심스테이</a>
					</div>
					
					<!-- 타이틀  -->
					<div class="col-sm-8 mt-2 mx-2 mb-2" align="center">
						<p class="title border-bottom pb-3">My Chat List</p>

						<c:choose>
							<c:when test="${map.count <= 0}">
								<div class="mt-5">
									<h5>채팅목록이 하나도 존재하지 않습니다.</h5>
								</div>
							</c:when>
							<c:otherwise>

								<!-- 검색바 -->
								<div class="d-flex justify-content-between align-items-center">
									<div class="count">
										<span>총 <strong>${map.count}개</strong>의 채팅방이 검색되었습니다.
										</span>
									</div>
									<div class="search-order">
										<form name="searchForm" class="d-flex align-items-center">
											<div class="search-input">
												<input class="form-control" name="keyword" id="keyword"
													placeholder="검색어를 입력해주세요"
													onkeypress="javascript:if(event.keyCode==13) searchChatList(searchForm)">
											</div>
											<div class="search-btn">
												<i class="bi-search btn btn-custom"
													onclick="searchChatList(searchForm)"></i>
											</div>
										</form>
									</div>
								</div>
								<!-- 검색바 끝 -->

								<!--결과 정보-->
								<div class="list-wrap">
									<div class="chat-list-item">
										<c:forEach var="row" items="${map.chatlist}">
											<section class="chat-list my-3">
												<div class="card my-2 border rounded-5">
													<div class="row g-0">
														<div class="col-md-3">
															<div class="thumb">
																<img src="${path}/imgUpload/${row.photo1}">
															</div>
														</div>
														<div class="col-md-9 chat-info-1">
															<!--생성-->
															<div
																class="card-body d-flex flex-column justify-content-between">
																<div class="d-flex py-1 pt-2">
																	<h5 class="room-name fw-bold mb-0 text-truncate px-2 ">
																		[${row.room_name}] ${row.senderId}님과의 채팅</h5>
																	<p class="icon-${row.c_idx} mb-0"></p>
																</div>
																<div class="info my-3">
																	<!-- 														<p class="card-text text-secondary ps-2 small"> -->
																	<%-- 															<i class="bi bi-house-door-fill"></i> 방정보 : ${row.room_name} --%>
																	<!-- 														</p> -->
																	<p class="card-text text-secondary ps-2 small">
																		<i class="bi bi-calendar-check-fill"></i> 채팅생성일자 :
																		<fmt:formatDate value="${row.create_date}"
																			pattern="yyyy-MM-dd(E) HH:mm:ss" />
																	</p>
																</div>
																<div class="btn-group">
																	<button type="button" class="btn btn-custom btn-sm"
																		onclick="chatPopUp('${row.room_idx}','${row.h_userid}','${row.userid}')">채팅하기</button>
																</div>
															</div>
															<!--끝-->
														</div>
													</div>
												</div>
											</section>
										</c:forEach>
									</div>
								</div>
								<!--결과 끝 -->

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
													href="#" aria-label="Previous"> <span
														aria-hidden="true">&laquo;</span>
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
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!-- 컨텐츠 수정 영역 end -->
	<%@ include file="../include/footer.jsp"%>

	<script type="text/javascript">
		//세션값에 있는 로그인 아이디 정보를 받아줌

		var userid;
		if ('${sessionScope.userid}' != "") {
			userid = '${sessionScope.userid}';
		}

		if ('${sessionScope.h_userid}' != "") {
			userid = '${sessionScope.h_userid}';
		}

		console.log("userid : " + userid);

		//html(JSP)파일이 로드되면 바로 initialize() 메서드를 실행시킴
		// 		$(document).ready(initialize());
		$(function() {
			initialize()
		});

		function initialize() {
			getUnreadMessageInfo();
			unreadAlertInfinite();
		}


		//async(비동기) 방식으로 일정간격 업데이트 되어야 하는 정보들(메세지 알림기능) 
		function getUnreadMessageInfo() {
			$.ajax({
				url : "${path}/chatUnreadMessageInfo/ajax",
				type : "POST",
				data : JSON.stringify({
					'userid' : userid
				}),
				contentType : "application/json; charset=utf-8",
				success : function(data) {
					var parsed = JSON.parse(data);
					var length = parsed.chatList.length;

					for (var i = 0; i < length; i++) {
						$(".icon-" + parsed.chatList[i].c_idx).html("");
						messageUnreadCheck(
								parsed.chatList[i].messageUnread,
								parsed.chatList[i].c_idx);
					}
				}
			});
		}

		//1000milliseconds(==1초) 간격으로 getUnreadMessageInfo()를 실행시키는 반복 메서드
			 	function unreadAlertInfinite() {
			 		setInterval(() => {
			 			getUnreadMessageInfo();				
					}, 1000);
			 	}

		//일정 간격으로 업데이트된 데이터를 화면에 출력하는 메서드 됨
		function messageUnreadCheck(messageUnread, c_idx) {		
			if(messageUnread == "new message"){
				var infoStr = "<span class='text-danger fw-bold'>"+ messageUnread + "</span>"
				$(".icon-" + c_idx).append(infoStr);
			} else if(messageUnread == "send complete") {
				var infoStr = "<span class='text-success fw-bold'>"+ messageUnread + "</span>"
				$(".icon-" + c_idx).append(infoStr);
			} else {
				var infoStr = "<span class='text-black-50 fw-bold'>"+ messageUnread + "</span>"
				$(".icon-" + c_idx).append(infoStr);
			}
		}
		
		//검색결과 폼 적용
		function searchChatList(f){
			f.sumbit();
		}
		
		//채팅방으로 이동하기
		function chatPopUp(room_idx,h_userid,userid){
			var left = $(document).width()-600; //문서 가로사이즈 - 600;
			window.open("${path}/chatroom/"+room_idx+"/"+h_userid+"/"+userid,"_blank","width=550, height=700, left=" + left + ", top=100, scrollbars=no, toollbars=no, location=no,");
		}
		
	    //페이지네이션 이동
	    function pagination(page){
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
	    		const newParam = searchParams.toString(); //파라미터 값을 가져오고
	    		const url = location.href.split("?"); //현재 url에서 파라미터 값을 제외한 url을 가져온다.
	    		location.href = url[0] +"?"+newParam;
	    	}
	    }
		
	</script>

</body>
</html>