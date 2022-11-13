<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<style type="text/css">
#profile-tab a {
color: black;
text-decoration: none;
}
#profile-tab a:hover {
color: #ffc107;
text-decoration: none;
}
.box {
    width: 250px;
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
}
</style>
</head>

<body>
<!-- 프로필 탭 -->
	<div class="list-group col-lg-3 mt-4" align="center" id="profile-tab">	
		<div class="mx-auto">
			<c:if test="${guest.profile_img != null}">			
				<div class="box mb-3">
					<img class="profile" src="${path}/imgUpload/${guest.profile_img}" style="border-radius: 50%; width: 250px; height: 250px;">
				</div>
			</c:if>
			
			<c:if test="${guest.profile_img == null}">
				<div class="box mb-3"> 		
					<img class="profile" src="${path}/resources/images/guest.png" style="border-radius: 50%; width: 250px; height: 250px;">
				</div>
			</c:if>
			
			<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">마이 페이지</a>
			<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약 정보</a>
			<a href="${path}/reviews/reviewUserList/${sessionScope.userid}" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
			<a href="${path}/chatlist" class="list-group-item list-group-item-action">1:1 채팅목록</a>
      		<a href="${path}/qna/scraplist"class="list-group-item list-group-item-action">스크랩</a>
			<a href="${path}/wishlist/list.do" class="list-group-item list-group-item-action">관심 스테이</a>
		</div>
	</div>
</body>