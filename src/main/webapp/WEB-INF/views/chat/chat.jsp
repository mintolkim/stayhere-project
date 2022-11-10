<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역  start-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
<!-- 그외 페이지별 들어갈 script & css 추가 영역 end -->
<title>STAYHERE</title>
</head>

<style>

.wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.chating-wrap{
	width: 500px;
}

.top-bar {
	background-color: #ffd28e;
}

.chat_info img {
	width: 40px;
	height: 40px;
	border-radius: 1rem;
}

.chat_title {
	font-size: 1.25rem;
	font-weight: 600;
}

.host_info {
	font-size: 0.75rem;
	font-weight: 300;
	color: #464646;
}

.msg-wrap {
	height: 500px;
	overflow-y: auto;
}

.msg-wrap::-webkit-scrollbar {
	width: 4px;
}

.msg-wrap::-webkit-scrollbar-thumb {
	background-color: #ffd28e;
	border-radius: 100px;
}

.msg-wrap::-webkit-scrollbar-track {
	background-color: #e4e4e4;
	border-radius: 100px;
}

.input-group textarea {
	resize: none;
}

.input-group textarea::-webkit-scrollbar {
	width: 5px;
}

.input-group textarea::-webkit-scrollbar-thumb {
	background-color: #ffd28e;
	border-radius: 100px;
}

.input-group textarea::-webkit-scrollbar-track {
	background-color: #e4e4e4;
	border-radius: 100px;
}

.btn-wrap {
	width: 66px;
}

.incoming_msg {
	margin: 26px 0;
}

.incoming_msg_img {
	display: inline-block;
	width: 6%;
}

.incoming_msg_img img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
}

.received_msg {
	display: inline-block;
	padding: 0 0 0 10px;
	vertical-align: top;
}

.received_name{
	font-size : 0.75rem;
	padding-left: 0.35rem;
	padding-bottom: 0.25rem;
}

.received_withd_msg .message p {
	background: #ebebeb none repeat scroll 0 0;
	border-radius: 6px;
	color: #111111;
	font-size: 0.9rem;
	margin: 0;
	padding: 5px 10px 5px 12px;
	width: 100%;
}

.received_withd_msg .message {
	display: flex;
	align-items: flex-end;
}

.received_withd_msg .message .user_read_check{
	padding-left: 4px;
	font-size: 0.75rem;
	color: #747474;
}

.sent_msg .message {
	display: flex;
	align-items: flex-end;
}

.sent_msg .message .host_read_check {
	padding-right: 4px;
	font-size: 0.75rem;
	color: #747474;
}
	
.sent_msg .time_date {
	float: right;
	color: #747474;
	font-size: 0.65rem;
	margin: 8px 0 0;
}

.received_withd_msg .time_date {
	float: left;
	color: #747474;
	font-size: 0.65rem;
	margin: 8px 0 0;
}

.outgoing_msg {
	overflow: hidden;
	margin: 1.25rem 0;
}

.sent_msg {
	float: right;
}

.mesgs {
	float: left;
	padding: 30px 15px 0 25px;
	width: 60%;
}

.sent_msg p {
	background: #ffb94f none repeat scroll 0 0;
	border-radius: 6px;
	font-size: 0.9rem;
	margin: 0;
	color: #111111;
	padding: 5px 10px 5px 12px;
	width: 100%;
}

#send{
	background-color: #ffd28e; 
}
</style>

<body>
	<div class="container-fuild wrap">
		<div class="chating-wrap border">
			<div class="top-bar">
				<div class="d-flex p-2">
					<div class="chat_info d-flex align-items-center p-2">
						<img src="${path}/imgUpload/${chatRoomInfo.photo1}">
						<div class="ps-2">
							<span class="chat_title">[${chatRoomInfo.room_name}] ${chatRoomInfo.h_userid}님과의 채팅</span>
						</div>
					</div>
				</div>
			</div>

			<div class="msg-wrap p-4">
				<c:forEach var="chatRoom" items="${chatHistory}">
					<c:set var="uid" value="${guest.getUserid()}" />
					<c:set var="cid" value="${chatRoom.senderId}" />
					<c:choose>
						<c:when test="${uid eq cid}">
							<div class="outgoing_msg">
								<div class="sent_msg">
									<div class="message">
									<span class="host_read_check"></span>
									<p>${chatRoom.content}</p>
									</div>
									<span class="time_date">${chatRoom.sendTime}</span>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="incoming_msg">
								<div class="incoming_msg_img">
									<img src="${path}/imgUpload/${chatRoomInfo.h_profile}" alt="profile_img">
								</div>
								<div class="received_msg">
									<div class="received_name">
										${chatRoom.senderId}
									</div>
									<div class="received_withd_msg">
										<div class="message">
											<p>${chatRoom.content}</p> 
											<span class="user_read_check"></span>
										</div>
										<span class="time_date"> ${chatRoom.sendTime}</span>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="send-wrap">
				<div class="d-flex flex-row border-top">
					<div class="input-group p-1">
						<textarea class="border-0 w-100 p-2 form-control" id="message"
							placeholder="메시지를 입력해주세요"></textarea>
					</div>
					<div class="btn-wrap">
						<button id="send" class="btn py-1 h-100" onclick="send()">전송</button>
						<input type="hidden" value="${guest.getName()}" id="userName" />
						<input type="hidden" value="${guest.getUserid()}" id="userid" />
						<input type="hidden" value="${chatRoomInfo.room_idx}"	id="room_idx" /> 
						<input type="hidden" value="${chatRoomInfo.h_userid}" id="h_userid" /> 
						<input type="hidden" value="${chatRoomInfo.c_idx}" id="c_idx" />
					</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	$(function(){
		ScrollBottom();
	})
	
	//스크롤 하단 고정
	function ScrollBottom(){
		$(".msg-wrap").scrollTop($(".msg-wrap")[0].scrollHeight);
	}
	</script>

	<script type="text/javascript">

		var stompClient = null;
		var userName = $('#userName').val()
		var userid = $('#userid').val();
		var h_userid = $('#h_userid').val();	
		var room_idx = $('#room_idx').val();
		var senderName = $('#userName').val();
		var c_idx = $('#c_idx').val();
		
		$(function(){
			connect();
			ajaxChatRead();
			unreadAlertInfinite();
		});
		
		
		//소켓 연결
		function connect() {
			//map URL using SockJS
			console.log("connected");
			var socket = new SockJS('${path}/broadcast');
			var url = '/user/' + c_idx + '/queue/messages';
			//webSocket 대신 SockJS을 사용하므로 Stomp.client()가 아닌 Stomp.over()를 사용함
			stompClient = Stomp.over(socket);
			console.log("connect ajaxRead");
			//connect(header, connectCallback(==연결에 성공하면 실행되는 메서드))
			stompClient.connect({}, function() {
				console.log("connected STOMP");
				//url: 채팅방 참여자들에게 공유되는 경로
				//callback(function()): 클라이언트가 서버(Controller broker로부터)로부터 메시지를 수신했을 때 실행
				stompClient.subscribe(url, function(output) {
					//JSP <body>에 append할 메시지 contents
					showBroadcastMessage(createTextNode(JSON.parse(output.body)));
				});
				}, 
					//connect() 에러 발생 시 실행
					function (err) {
						alert('error' + err);
			});
		};
		
		//WebSocket broker 경로로 JSON형태 String 타입 메시지 데이터를 전송함 
		function sendBroadcast(json) {
			stompClient.send("/app/broadcast", {}, JSON.stringify(json));
		}
		
		//보내기 버튼 클릭시 실행되는 메서드
		function send() {
			var content = $('#message').val();
			sendBroadcast({
				'c_idx': c_idx,
				'userName' : userName,
				'content': content,
				'userid': userid, 
				'h_userid': h_userid,
				'room_idx': room_idx,
				'senderName': senderName,
				'senderId' : userid
				});
			$('#message').val("");
		}
		
		//메시지 입력 창에서 Enter키 누르면 전송/ Shift+Enter키 입력시 개행처리
		$("#message").on('keyup', function enterSend(event) {
			if (event.keyCode === null) {
				event.preventDefault();
			}
			
			if (!event.shiftKey && event.keyCode === 13) {
				//입력된 값 양끝 공백제거
				var content = $('#message').val().trim();
				
				if(content==''){
					console.log("이거 실행안되니.....");
					$('#message').val("");
					return false;
				}
				
				send();
			}
		}
		
		);
		
		//입력한 메시지를 HTML 형태로 가공
		function createTextNode(messageObj) {
			console.log("createTextNode");
		 	console.log(messageObj.senderName + "  " + messageObj.senderId);
		 	//개행값 <br>로 치환하기
			messageObj.content = messageObj.content.replace(/\n/ig, '<br>');
			console.log("messageObj: " + messageObj.content);
			
			//보낸사람과 접속한 사람의 아이가 같다면..
			if(messageObj.senderId == userid){
				return "<div class='outgoing_msg'><div class='sent_msg'>"
				+ "<div class='message'><span class='host_read_check'></span><p>"
				+ messageObj.content 
				+ "</p></div><span class='time_date'>"
				+ messageObj.sendTime
	    	+ "</span></div></div>";
			
			} else {
				return "<div class='incoming_msg'><div class='incoming_msg_img'>"
				+ "<img src='${path}/imgUpload/${chatRoomInfo.h_profile}' alt='profile_img'>"
		    + "</div><div class='received_msg'><div class='received_name'>"
		    + messageObj.senderId
		    + "</div><div class='received_withd_msg'>"
		    + "<div class='message'><p>"
		    + messageObj.content  
		    + "</p><span class='user_read_check'></span></div>"
		    + "<span class='time_date'>"
		    + messageObj.sendTime
		    + "</span></div></div></div>";
			}
			
    }
		
		//HTML 형태의 메시지를 화면에 출력해줌 
		//해당되는 id 태그의 모든 하위 내용들을 message가 추가된 내용으로 추가.
		//추가 후 스크롤은 하단으로 이동됨
		function showBroadcastMessage(message) {
            $(".msg-wrap").append(message);
            $(".msg-wrap").animate({
            	scrollTop: $(".msg-wrap")[0].scrollHeight
            }, 1000);
        }
		
		//유저 읽음처리 
		function ajaxChatRead() {
			console.log("hi");
			$.ajax({
				url:'${path}/chatread/product/ajax',
				type: 'POST',
				data: JSON.stringify({
					'c_idx' : c_idx,
					'userid' : userid
				}),
				dataType: 'json',
				contentType: 'application/json'
			});
		}
		
		//읽기 체크
		function ajaxReadCheck(){
			console.log("read check..");
			$.ajax({
				url : '${path}/chatreadCheck/ajax',
				type: 'POST',
				data: JSON.stringify({
					'c_idx' : c_idx,
					'userid' : userid,
					'h_userid' : h_userid
				}),
				dataType: 'json',
				contentType: 'application/json',
				success : function(data){
					console.log("chat_read_host : " + data.chat_read_host);
					console.log("chat_read_user : " + data.chat_read_user);
					var host = data.chat_read_host;
					var user = data.chat_read_user;
					var host_txt = $(".host_read_check").text();
					var user_txt = $(".host_read_check").text();
					
					if(host == 1){
						$(".host_read_check").text("");
					}
					
					if(user == 1){
						$(".user_read_check").text("");
					}
				}
			});
		}
		
		function unreadAlertInfinite() {
	 		setInterval(() => {
	 			ajaxReadCheck();				
			}, 1000);
	 	}
		
	
	</script>
</body>
</html>