<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/admin_header.jsp"%>
<style type="text/css">
.flip-box {
  background-color: transparent;
  perspective: 1000px; 
}
.flip-box-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transition: transform 0.8s;
  transform-style: preserve-3d;
}

.flip-box:hover .flip-box-inner {
  transform: rotateX(180deg);
}
.flip-box-front, .flip-box-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden; /* Safari */
  backface-visibility: hidden;
}
.flip-box-back {
  transform:rotateX(180deg);
}
.confirm-nav{
width: 100%;
font-weight: bold;
text-align: center;
padding: 15px;
border-top: 1px solid #e8e8e8;
border-right: 1px solid #e8e8e8;
border-left: 1px solid #e8e8e8;
}
.col-4{
padding: 15px;
border-right: 1px solid #e8e8e8;
border-left: 1px solid #e8e8e8;}
.approve{
background-image: url('${path}/resources/images/approve.png');
background-size:100% 100%;
}
.reject{
background-image: url('${path}/resources/images/rejected.png');
background-size: 98% 98%;}
.card-text{
font-size: 15px;}
</style>
<script type="text/javascript">
function changestate(room_idx, tmp){
	var state;
	if(tmp=="reject"){
		state="승인거절";
	}else{
		state="승인";
	}
	location.href="${path}/admin/roomConfirm?room_idx="+room_idx+"&state="+state;
}
</script>
</head>
<body>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content">
			 <p style="text-align: center; font-size: 34px; font-weight: bold; padding-top: 25px;">Room-Confirm status</p>
			<div class="row" >
				<div class="col-4" >
				 <div class="confirm-nav">승인거절</div>
					<c:forEach var="reject" items="${map.rejectlist }">
						<div class="card mb-3 mt-3" style="height: 180px;">
							<div class="row g-0">
								<div class="col-md-4">
									<img class="img-fluid rounded-start"
										src="${path}/imgUpload/${reject.photo1}"
										style="height: 180px;">
								</div>
								<div class="col-md-8 reject">
									<div class="card-body">
										<div class="fw-bolder fs-5">${reject.room_name}
											<span> <b style="font-size: 10px; color: red;">${reject.admin_confirm}</b>
											</span>
										</div>
										<b class="lead card-text" ><i class="bi bi-geo-alt-fill pe-1"></i>
										주소 : ${reject.address1}${reject.address2}</b><br> <b class="lead card-text"
											>타입: ${reject.room_type}</b><br>
										<b class="lead card-text" >가격 : <fmt:formatNumber
												type="number" maxFractionDigits="3"
												value="${reject.room_price}" /> 원
										</b> <b class="lead card-text" >,1인당
											추가 가격 : <fmt:formatNumber type="number" maxFractionDigits="3"
												value="${reject.add_people}" /> 원
										</b><br> <b class="lead card-text" > <i class="bi bi-check-square-fill pe-1"></i> 
										침대 : ${reject.beds}개, 화장실 : ${reject.baths}개</b><br>
											<b class="lead card-text" ><i class="bi bi-calendar-check pe-1"></i>프로모션 기간 : 
											<fmt:formatDate pattern="MM월 dd일" value="${reject.check_in}" />
											<span>~</span>
											<fmt:formatDate pattern="MM월 dd일" value="${reject.check_out}" />
											</b>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="col-4" >
				<div class="confirm-nav">승인대기</div>
					<c:forEach var="delay" items="${map.delaylist }">
						<div class="card mt-3 flip-box"
							style="width: 100%; height: 180px;">
							<div class="flip-box-inner">
								<div class="row g-0 flip-box-front">
									<div class="col-md-4">
										<img class="img-fluid rounded-start"
											src="${path}/imgUpload/${delay.photo1}"
											style="height: 180px;">
									</div>
									<div class="col-md-8">
										<div class="card-body">
											<div class="fw-bolder fs-5">${delay.room_name}
											<span> <b style="font-size: 10px; color: orange;">${delay.admin_confirm}</b>
											</span>
										</div>
											<b class="lead card-text" ><i class="bi bi-geo-alt-fill pe-1"></i>
										주소 : ${delay.address1}${delay.address2}</b><br> <b class="lead card-text"
											>타입: ${delay.room_type}</b><br>
										<b class="lead card-text" >가격 : <fmt:formatNumber
												type="number" maxFractionDigits="3"
												value="${delay.room_price}" /> 원
										</b> <b class="lead card-text" >,1인당
											추가 가격 : <fmt:formatNumber type="number" maxFractionDigits="3"
												value="${delay.add_people}" /> 원
										</b><br> <b class="lead card-text" > <i class="bi bi-check-square-fill pe-1"></i> 
										침대 : ${delay.beds}개, 화장실 : ${delay.baths}개</b><br>
											<b class="lead card-text" ><i class="bi bi-calendar-check pe-1"></i>프로모션 기간 : 
											<fmt:formatDate pattern="MM월 dd일" value="${delay.check_in}" />
											<span>~</span>
											<fmt:formatDate pattern="MM월 dd일" value="${delay.check_out}" />
											</b>
										</div>
									</div>
								</div>
								<div class="flip-box-back d-flex align-items-end justify-content-between">
									<div class="col-md-4" style="padding: 10px;">
									<c:if test="${delay.h_profile_img == null}">
									  <img class="rounded-circle me-3" 
										src="${path }/resources/images/guest.png"
										  style="width: 160px; height: 160px;" />
											</c:if>
									<c:if test="${delay.h_profile_img != null}">
									  <img class="rounded-circle me-3" 
										src="${path }/imgUpload/${delay.h_profile_img}"
										 style="width: 160px; height: 160px;" /></c:if>
									</div>
									<div class="col-md-8">
									 <div class="card-body">
									  <div class="fw-bolder fs-5">호스트 정보</div>
									   <b class="lead card-text" >ID : ${delay.h_userid }</b><br>
									   <b class="lead card-text" >NAME : ${delay.h_name }</b><br>
									   <b class="lead card-text" ><i class="bi bi-envelope"></i> EMAIL : ${delay.h_email }</b><br>
									   <b class="lead card-text" ><i class="bi bi-phone"></i> PHONE : ${delay.h_phone }</b><br>
									   <b class="lead card-text" ><i class="bi bi-calendar"></i> JOIN-DATE : 
									   <fmt:formatDate value="${delay.h_join_date }" pattern="YYYY년  MM월 dd일"/>
									   </b><br>
									 </div>
									</div>
								</div>
							</div>
						</div>
						<div style="width: 100%; padding: 10px;" align="right">
							<button type="button" class="btn btn-danger btn-sm"
								onclick="changestate('${delay.room_idx}','reject');">승인거절</button>
							<button type="button" class="btn btn-success btn-sm"
								onclick="changestate('${delay.room_idx}','confirm');">승인</button>
						</div>
					</c:forEach>
				</div>
				<div class="col-4">
				<div class="confirm-nav">승인완료</div>
				<c:forEach var="confirm" items="${map.confirmlist }">
						<div class="card mb-3 mt-3" style="width: 100%; height: 180px;">
							<div class="row g-0">
								<div class="col-md-4">
									<img class="img-fluid rounded-start"
										src="${path}/imgUpload/${confirm.photo1}"
										style="height: 180px;">
								</div>
								<div class="col-md-8 approve">
									<div class="card-body">
										<div class="fw-bolder fs-5">${confirm.room_name}
											<span> <b style="font-size: 10px; color: green;">${confirm.admin_confirm}</b>
											</span>
										</div>
										<b class="lead card-text" ><i class="bi bi-geo-alt-fill pe-1"></i>
										주소 : ${confirm.address1}${confirm.address2}</b><br> <b class="lead card-text"
											>타입: ${confirm.room_type}</b><br>
										<b class="lead card-text" >가격 : <fmt:formatNumber
												type="number" maxFractionDigits="3"
												value="${confirm.room_price}" /> 원
										</b> <b class="lead card-text" >,1인당
											추가 가격 : <fmt:formatNumber type="number" maxFractionDigits="3"
												value="${confirm.add_people}" /> 원
										</b><br> <b class="lead card-text" > <i class="bi bi-check-square-fill pe-1"></i> 
										침대 : ${confirm.beds}개, 화장실 : ${confirm.baths}개</b><br>
											<b class="lead card-text" ><i class="bi bi-calendar-check pe-1"></i>프로모션 기간 : 
											<fmt:formatDate pattern="MM월 dd일" value="${confirm.check_in}" />
											<span>~</span>
											<fmt:formatDate pattern="MM월 dd일" value="${confirm.check_out}" />
											</b>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				
				</div>
			</div>
<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
</body>
</html>
