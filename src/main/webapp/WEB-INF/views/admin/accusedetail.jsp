<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>
</head>
<body>
	<!-- 리뷰목록 -->
	<div class="row gx-5">
		<c:forEach var="row" items="${list}">
			<div class="mb-4">
				<div class="card h-100 shadow border-0">
					<div class="card-body p-4">
						<table class="table">
							<tr>
							<th scope="row" class="table-light">신고자</th>
							<td>${row.userid }</td>
							</tr>
							<tr >
							<th scope="row" class="table-light">신고글</th>
							<td><a class="stretched-link"
							 href="${path}/rooms/detail/${row.room_idx}">${row.r_title }</a></td>
							</tr>
							<tr >
							<th scope="row" class="table-light">신고아이디</th>
							<td>${row.writer }</td>
							</tr>
							<tr>
							<th scope="row" class="table-light">신고내용</th>
							<td>${row.acc_content }</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>