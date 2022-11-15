<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>
<style type="text/css">

</style>
<script type="text/javascript">
/* 예약 정보 팝업 */
function reserveDetail(res_idx) {
	const url = "${path}/reservations/popupDeatil.do?res_idx="+res_idx;
	
	const op = "width=450, height=800, location=no, toolbar=no";
	
	open(url, "예약정보", op)
}
</script>
</head>
<body>
	<div class="tab-pane active" id="status_1">
		<c:forEach var="res" items="${list}">
				<div class="row gx-4 gx-lg-5 align-items-center my-2 border border-1"
					style="border-color: #f2f2f2;">
					<div class="col-lg-6">
						<a href="${path}/rooms/detail/${res.room_idx}"><img
							class="d-block w-100" src="${path}/imgUpload/${res.photo1}"
							width="250px" height="250px" /></a>
					</div>
					<div class="col-lg-6 py-2" style="text-align: center;">
						<span class="fs-5 fw-bolder"><a class="text-decoration-none text-black"
							href="${path}/rooms/detail/${res.room_idx}">${res.room_name}</a></span>
						<hr class="gray_line">
						<i class="bi bi-geo-alt-fill">&nbsp;<span>${res.city}
							${res.country}</span><br> <span>${res.checkin_date} ~
							${res.checkout_date}</span></i><br>
						<hr class="gray_line">
						예약자 ID : ${res.userid }<br>
						<span class="fs-6 fw-bolder">￦<fmt:formatNumber
								value="${res.total_price}" pattern="#,###,###" /></span><br> <span><fmt:formatDate
								value="${res.res_date}" pattern="yyyy.MM.dd hh:mm" /></span><br>
						<button class="btn btn-warning btn-sm"
							onclick="reserveDetail(${res.res_idx})"
							style="color: white; font-size: 13px;">예약 정보</button>
					</div>
				</div>
		</c:forEach>
	</div>
</body>
</html>