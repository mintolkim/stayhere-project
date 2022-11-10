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
	<!-- 세션값 변수로 담기 -->
	<c:set var="host_in" value="${sessionScope.h_userid}"/>
	<c:set var="geust_in" value="${sessionScope.userid}"/>

	<div class="container-fuild wrap">
		<div class="chating-wrap border">
			<div class="top-bar">
				<div class="d-flex p-2">
					<div class="chat_info d-flex align-items-center p-2">
						<img src="${path}/imgUpload/${photo1}">
						<div class="ps-2">
							<c:if test="${host_in != null}">
								<span class="chat_title">[${room_name}] ${userid}님과의 채팅</span>
							</c:if>
							<c:if test="${geust_in != null}">
								<span class="chat_title">[${room_name}] ${h_userid}님과의 채팅</span>
							</c:if>
						</div>
					</div>
				</div>
			</div>		

			<div class="msg-wrap p-4">
				<c:forEach var="chatRoom" items="${chatHistory}">
					<c:set var="cid" value="${chatRoom.senderId}" />
					<c:choose>
						<c:when test="${host_in eq cid || geust_in eq cid}">
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
									<c:if test="${host_in eq host.h_userid}">
										<c:choose>
											<c:when test="${guest.profile_img != null}">
												<img src="${path}/imgUpload/${guest.profile_img}" alt="profile_img">
											</c:when>
											<c:otherwise>
												<img src="${path}/resources/images/guest.png" alt="profile_img">
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${geust_in eq guest.userid}">
										<c:choose>
											<c:when test="${host.h_profile_img != null}">
												<img src="${path}/imgUpload/${host.h_profile_img}" alt="profile_img">
											</c:when>
											<c:otherwise>
												<img src="${path}/resources/images/guest.png" alt="profile_img">
											</c:otherwise>
										</c:choose>
									</c:if>
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
						<c:choose>
								<c:when test="${sessionScope.userid != null }">
									<input type="hidden" value="${sessionScope.name}" id="senderName"/>
									<input type="hidden" value="${sessionScope.userid}" id="senderId"/>
								</c:when>
								<c:when test="${sessionScope.h_userid != null }">
									<input type="hidden" value="${sessionScope.h_name}" id="senderName"/>
									<input type="hidden" value="${sessionScope.h_userid}" id="senderId"/>
								</c:when>
							</c:choose>
						<input type="hidden" value="${userid}" id="userid" />
						<input type="hidden" value="${room_idx}"	id="room_idx" /> 
						<input type="hidden" value="${h_userid}" id="h_userid" /> 
						<input type="hidden" value="${c_idx}" id="c_idx" />
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
		var senderName = $('#senderName').val();
		var senderId = $('#senderId').val();
		var h_userid = $('#h_userid').val();
		var userid = $('#userid').val();
		var room_idx = $('#room_idx').val();
		var c_idx = $('#c_idx').val();
		
/*
		function setConnected(connected) {		
			$('#connect').prop('disabled', connected);
			$('#disconnect').prop('disabled', !connected);
			if (connected) {
				$('#sendMessage').show();
			} else {
				$('#sendMessage').hide();				
			}
		};
*/
		
		$(document).ready(connect());
		
		function connect() {
			var socket = new SockJS('${path}/broadcast');
			var url = '/user/' + c_idx + '/queue/messages';
			console.log(url);
			stompClient = Stomp.over(socket);
			ajaxChatRead(c_idx, senderId);
			
			stompClient.connect({}, function() {
				stompClient.subscribe(url, function(output) {
					console.log("broadcastMessage working");
					showBroadcastMessage(createTextNode(JSON.parse(output.body)));
				});
						//setConnected(true);				
				}, 
						function (err) {
							alert('error' + err);
			});
		};
		
/*
		function disconnect() {
			
			if(stompClient!= null) {
				
				stompClient.disconnect(function() {
					console.log('disconnected...');
					setConnected(false);
				});
			}
		}
*/
		//WebSocket broker 경로로 JSON형태 String 타입 메시지 데이터를 전송함 
		function sendBroadcast(json) {
			stompClient.send("/app/broadcast", {}, JSON.stringify(json));
		}
		
		//보내기 버튼 클릭시 실행되는 메서드
		function send() {
			//ajaxChatRoom();
			var content = $('#message').val().trim();
			console.log("content 입니다 : " + content);
			sendBroadcast({
				'c_idx': c_idx,
				'senderName': senderName,
				'content': content,
				'room_idx': room_idx,
				'userid': userid,
				'senderId': senderId,
				'h_userid': h_userid
				});
			$('#message').val("");
		}
		
		var inputMessage = document.getElementById('message'); 
		inputMessage.addEventListener('keyup', function enterSend(event) {
			
			if (event.keyCode === null) {
				event.preventDefault();
			}
			
			if (!event.shiftKey && event.keyCode === 13) {
				//입력된 값 양끝 공백제거
				var content = $('#message').val().trim();
				
				if(content==''){
					$('#message').val("");
					return false;
				}
				
				send();
			}
		});
		
		//입력한 메시지를 HTML 형태로 가공
		function createTextNode(messageObj) {
			console.log("createTextNode");
			console.log("messageObj: " + messageObj.content);
			messageObj.content = messageObj.content.replace(/\n/ig, '<br>');
			var guest_in = '${sessionScope.userid}';
			var host_in = '${sessionScope.h_userid}';
			
			if(messageObj.senderId == guest_in || messageObj.senderId == host_in){
				return "<div class='outgoing_msg'><div class='sent_msg'>"
				+ "<div class='message'><span class='host_read_check'></span><p>"
				+ messageObj.content 
				+ "</p></div><span class='time_date'>"
				+ messageObj.sendTime
	    	+ "</span></div></div>";
			
			} else if (guest_in == "") { //호스트가 입장했다면...프로필 이미지 때문 나누기..
				return "<div class='incoming_msg'><div class='incoming_msg_img'>"
				+ "<c:choose><c:when test='${guest.profile_img != null}'>"
				+ "<img src='${path}/imgUpload/${guest.profile_img}' alt='profile_img'>"
				+ "</c:when><c:otherwise>"
				+ "<img src='${path}/resources/images/guest.png' alt='profile_img'>"
				+ "</c:otherwise></c:choose>"
		    + "</div><div class='received_msg'><div class='received_name'>"
		    + messageObj.senderId
		    + "</div><div class='received_withd_msg'>"
		    + "<div class='message'><p>"
		    + messageObj.content  
		    + "</p><span class='user_read_check'></span></div>"
		    + "<span class='time_date'>"
		    + messageObj.sendTime
		    + "</span></div></div></div>";
			} else { //게스트가 입장했다면..
				return "<div class='incoming_msg'><div class='incoming_msg_img'>"
				+ "<c:choose><c:when test='${host.h_profile_img != null}'>"
				+ "<img src='${path}/imgUpload/${host.h_profile_img}' alt='profile_img'>"
				+ "</c:when><c:otherwise>"
				+ "<img src='${path}/resources/images/guest.png' alt='profile_img'>"
				+ "</c:otherwise></c:choose>"
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
		
		
		function clearBroadcast() {
			$('.msg-wrap').html("");
		}
		
		//읽음처리
		function ajaxChatRead(c_idx, reader) {
			console.log("ajaxChatread");
			var flag = "";
			if (reader == userid) {
				flag = "user";
			} else {
				flag = "host";
			}
			$.ajax({
				url:'${path}/chatread/chatroom/ajax',
				type: 'POST',
				data: JSON.stringify({
					'c_idx': c_idx,
					'flag': flag
				}),
				dataType: 'json',
				contentType: 'application/json'
			})
		}
	
	</script>
</body>
</html>