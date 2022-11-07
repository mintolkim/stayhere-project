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
<%@ include file="../include/header.jsp"%>
</head>
<body class="d-flex flex-column">
<%@ include file="../include/navbar.jsp"%>
	<!-- 컨텐츠 수정 영역 start -->
	<div class="container">
		<div class="wrapper"></div>
	</div>
		<!-- 컨텐츠 수정 영역 end -->
<%@ include file="../include/footer.jsp"%>

<script type="text/javascript">
	 
	 //세션값에 있는 로그인 아이디 정보를 받아줌

	 	var userid;
	 if('${sessionScope.userid}' != ""){
		 userid = '${sessionScope.userid}';
	 }
	 
	 if('${sessionScope.h_userid}' != ""){
		 userid = '${sessionScope.h_userid}';
	 }
	 
	 console.log("userid : " + userid);

	 //html(JSP)파일이 로드되면 바로 initialize() 메서드를 실행시킴
// 		$(document).ready(initialize());
		$(function(){	initialize()});
	 
		function initialize() {
			getChatList();
			getUnreadMessageInfo();
// 			unreadAlertInfinite();
		}
		 
		//async(비동기)로 일정간격 업뎃되지 않아도 되는 img 파일을 불러옴
		function getChatList() {
			console.log("getChatList inprocess");
			$.ajax({
				url: "${path}/chatList/ajax",
				type: "POST",
				data: JSON.stringify({
					'userid' : userid
				}),
				contentType: "application/json; charset=utf-8",
				//전달을 성공했을때 Controller로부터 data를 return 받아 처리해주는 메서드	
				success: function(data) {
					console.log("getChatList 통신성공 : " + data);
					 var parsed = JSON.parse(data);
					 var length = parsed.chatList.length;
					 for (var i = 0; i < length; i++) {
						 //채팅방 갯수만큼 반복문을 돌면서 채팅방 틀(div, img 태그)를 만들어줌 
						 addChatDivImg(i, parsed.chatList[i].photo1);
					 }
				}
			});
		}
		
		 //async(비동기) 방식으로 일정간격 업데이트 되어야 하는 정보들(메세지 알림기능) 
		 function getUnreadMessageInfo() {
				 $.ajax({
					 url:"${path}/chatUnreadMessageInfo/ajax",
					 type: "POST",
					 data: JSON.stringify({
						 'userid': userid
					 }),
					 contentType: "application/json; charset=utf-8",
					 success: function(data) {						 
						 var parsed = JSON.parse(data);
						 var length = parsed.chatList.length;
						 
						 for (var i = 0; i < length; i++) {
							$('.wrapSellerTitle' + i).html('');
						 	addChatList(parsed.chatList[i].room_idx, parsed.chatList[i].userid, parsed.chatList[i].senderName, parsed.chatList[i].room_name, parsed.chatList[i].messageUnread, i);
						 }
					 }
			 });
		 }
	 	
		 
// 		 1000milliseconds(==1초) 간격으로 getUnreadMessageInfo()를 실행시키는 반복 메서드
// 	 	function unreadAlertInfinite() {
// 	 		setInterval(() => {
// 	 			getUnreadMessageInfo();				
// 			}, 1000);
// 	 	}
	 	
	 	//일정 간격으로 업데이트된 데이터를 화면에 출력하는 메서드 됨
	 	function addChatList(room_idx, userid, senderName, room_name, messageUnread, idx) {
	 		var str =
	 		'<a href="${path}/chatroom/' + 
	 		room_idx +
	 		'/' + 
	 		userid + 
	 		'">' +
	 		'<h3><span id="sellerName">' + 
	 		senderName +
	 		'&nbsp;</span>' +
	 		'<span id="title">' + 
	 		room_name + 
	 		'</span><span id="message">' + 
	 		messageUnread+'</span></h3></div></a>';
	 		
	 		//HTML화면의 <div class="wrapSellerTitle0,1,...etc"> 하위에 str 변수를 추가해준다.		 		 
	 		 $('.wrapSellerTitle' + idx).append(str);
	 	} 
	 	
	 	//페이지가 로드되는 시점 한 번만 출력하면 되는 div, img를 출력하는 메서드
	 	function addChatDivImg(idx, img) {
	 			$(".wrapper").append('<div class= chatMessageInfo' + idx + '><div class="photo"><img class="room_photo" src="${path}/imgUpload/' + img + '" width=20%></div><div class="wrapSellerTitle' +
	 					idx +
	 					'"></div></div>');
	 	}
	 	
	 	
	 </script>



	
<!-- Bootstrap core JS-->
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	 
</body>
</html>