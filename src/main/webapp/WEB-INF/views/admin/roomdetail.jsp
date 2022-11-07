<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호스트 룸 정보</title>
<%@ include file="../include/header.jsp"%>
<style type="text/css">
</style>
</head>
<body>
	<div style="margin: 20px auto; text-align: center;">
		<c:forEach var="row" items="${list}">
			<div class="card mb-3" style="width: 100%; height: 160px;">
				<div class="row g-0">
					<div class="col-md-4">
						<img class="img-fluid rounded-start"
							src="${path}/imgUpload/${row.photo1}" style="height: 160px;">
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<h5 class="card-title fw-bolder">${row.room_name}
								<span> <b style="font-size: 10px; color: orange;">${row.admin_confirm}</b>
								</span>
							</h5>
							<b class="lead card-text" style="font-size: 15px;">${row.address1}
								${row.address2}</b><br> <b class="lead card-text"
								style="font-size: 15px;">타입: ${row.room_type}</b><br> <b
								class="lead card-text" style="font-size: 15px;">가격 : <fmt:formatNumber
									type="number" maxFractionDigits="3" value="${row.room_price}" />
								원
							</b> <b class="lead card-text" style="font-size: 15px;">,1인당 추가
								가격 : <fmt:formatNumber type="number" maxFractionDigits="3"
									value="${row.add_people}" /> 원
							</b><br> <b class="lead card-text" style="font-size: 15px;">침대
								: ${row.beds}개, 화장실 : ${row.baths}개</b><br>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>