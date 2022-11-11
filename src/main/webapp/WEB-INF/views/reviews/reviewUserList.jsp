<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>

<style type="text/css">
a {
 text-decoration: none;
}

#profile-tab a {
 color: black;
	text-decoration: none;
}

#profile-tab a:hover {
 color: #ffc107;
 text-decoration: none;
}

.profile {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
}

#tableBody td{
	padding-top: 15px;
	vertical-align: middle;
}
#greviewList{
	text-align: center;
}
#greviewList a {
 color: black;
}
#greviewList a:hover {
 opacity: 0.5;
}
</style>

</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
	<!-- nav -->
	<%@ include file="../include/navbar.jsp"%>
	<!-- 본문영역-->
	<section class="mt-3 mb-5" id="features">
		<div class="container" align="center">
			<div class="row">
					
 				<div class="list-group col-lg-3 mt-4 " id="profile-tab">	
					<div style="width: 80%;">
						<c:if test="${guest.profile_img != null}">			 
							<img class="profile" src="${path}/imgUpload/${guest.profile_img}" style="border-radius: 50%; width: 230px; height: 230px;">
						</c:if>
						<br>
						<c:if test="${guest.profile_img == null}">
							<img class="profile" src="${path}/resources/images/guest.png" style="border-radius: 50%; width: 230px; height: 230px;">
							<br>
						</c:if>
	
						<br>
						<a href="${path}/guest/guest_view/${sessionScope.userid}" class="list-group-item list-group-item-action">마이 페이지</a>
						<a href="${path}/reservations/list/guest" class="list-group-item list-group-item-action">예약 정보</a>
						<a href="${path}/reviews/reviewUserList/${sessionScope.userid}" class="list-group-item list-group-item-action">내가 작성한 리뷰</a>
						<a href="${path}/chatlist" class="list-group-item list-group-item-action">채팅목록</a>
						<a href="${path}/wishlist/list.do" class="list-group-item list-group-item-action">관심 스테이</a>
					</div>
				</div>
						
				<div class="col-lg-9 mt-4 mb-5" align="center">	
		            <p style="text-align: center; font-size: 20px; font-weight: bold; letter-spacing: 12px;">My Review List</p>
					<p style="text-align: center; font-size: 14px; letter-spacing: 8px;">내가작성한리뷰</p>
					<br>
					
					<div class="col" align="left">
						<c:if test="${map.review_count == 0}">
							<span class="fs-5">작성한 리뷰가 없습니다.</span>
						</c:if>
						<c:if test="${map.review_count > 0}">
							<i class="bi bi-pencil-square"></i><span class="fs-6">&nbsp;${map.review_count}개의 리뷰가 있습니다.</span>
						</c:if>
					</div>	
					
					<div>
					<table id="greviewList" class="table table-hover">
						<thead class="table-light">
						<tr>
							<td>&nbsp;</td>
							<td>스테이</td>
							<td>리뷰</td>
							<td>별점</td>
							<td>리뷰작성일</td>
							<td>&nbsp;</td>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="row" items="${map.list}">
							<c:if test="${row.show == 'y'}">
						<tr id="tableBody">
							<td>
								<a href="${path}/rooms/detail/${row.room_idx}">
								<img class="me-3 ms-2" src="${path}/imgUpload/${row.photo1}" style="width: 50px; height: 50px;"></a>
							</td>
							<td>
								<a href="${path}/rooms/detail/${row.room_idx}">${row.room_name}</a>
							</td>
							<td class="fw-bold"><a href="${path}/reviews/detail.do?review_idx=${row.review_idx}">${row.r_title}</a></td>
							<td>
								<c:forEach begin="1" end="${row.review_star}">
									<span style="color: #ffbf00; font-size: 18px;">★</span>
								</c:forEach> 
								<c:forEach begin="1" end="${5-row.review_star}">
									<span style="color: #ffbf00; font-size: 18px;">☆</span>
								</c:forEach></td>
							<td><span> <fmt:formatDate value="${row.write_date}" pattern="yy.MM.dd" /></span></td>
							<td>
								<button class="btn btn-warning btn-sm editBtn" style="cursor: pointer;" 
								onclick="location.href='${path}/reviews/edit.do?review_idx=${row.review_idx}'">수정/삭제</button>
							</td>
						</tr>
						</c:if>
						
						</c:forEach>
						</tbody>
					</table>
					</div>	
				</div>
					
			</div>
		</div>
	  </section>

	</main>
	<!--footer  -->
	<%@ include file="../include/footer.jsp"%>

</body>
</html>