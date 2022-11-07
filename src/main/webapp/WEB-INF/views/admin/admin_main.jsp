<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/admin_header.jsp"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style type="text/css">
body{
background-color: #f7f7f7;}
.topcard1,.topcard2,.topcard3,.topcard4{
padding: 20px;
border-radius: 10px;
box-shadow: 5px 5px 5px 5px #e8e8e8;
margin-top: 20px;
font-weight: bold;
}
.card{box-shadow: 5px 5px 5px 5px #e8e8e8;}
.card-header{color:#ff8000; font-weight: bold;}
.topcard1{border-left: 4px solid #fe3995;}
.topcard2{border-left: 4px solid #f6aa33;}
.topcard3{border-left: 4px solid #2abe81;}
.topcard4{border-left: 4px solid #6e4ff5;}
#roomtable, #qnatable{font-size: 12px;text-align:center;}
</style>
<script type="text/javascript">
google.charts.load("current", {packages:["corechart"],'language':'ko'});
google.charts.setOnLoadCallback(mothlyChart);
google.charts.setOnLoadCallback(categoryChart);
function mothlyChart(){
	//차트 그리기에 필요한 json 데이티 로딩
	var jsonData=$.ajax({
		url: "${path}/chart/montlychart",
		dataType: "json",
		async: false //동기식처리(순차적 처리:데이터를 다부른 후 챠트출력하기 위해)
	    }).responseText;
    var data=new google.visualization.DataTable(jsonData);
    var options = {
    		title: '월별 매출', 
    	    is3D: true,
    	    animation: { //차트가 뿌려질때 실행될 애니메이션 효과
                startup: true,
                duration: 300,
                easing: 'linear' },
    	    legend: { position: 'bottom' },
    	    bar: {groupWidth: "90%"},
            series: {
              0: { color: '#2abe81' }
            },
            vAxis: { gridlines: { count: 5 },
            	format : 'long'}
    }
	var chart=new google.visualization.ColumnChart(
       	  document.getElementById("monthlyChart"));   
        chart.draw(data, options);
}
function categoryChart(){
	//차트 그리기에 필요한 json 데이티 로딩
	var jsonData=$.ajax({
		url: "${path}/chart/cateChart",
		dataType: "json",
		async: false //동기식처리(순차적 처리:데이터를 다부른 후 챠트출력하기 위해)
	    }).responseText;
    var data=new google.visualization.DataTable(jsonData);
    
	    var chart=new google.visualization.PieChart(
	    	    document.getElementById("categoryChart"));
	         
	        var counter = 0;
	         var handler = setInterval(function(){ 
	             counter = counter + 0.1
	             options = {
	               title: '카테고리별 매출',
	    	    legend: { position: 'right' },
	               is3D: false,
		    	    pieHole: 0.4,
		    	    colors: ['#fe3995', '#f6aa33', '#6e4ff5', '#2abe81', '#c7d2e7'],
		    	    pieSliceText: 'label',
	               slices: { 1: {offset: counter},                       
	                         5: {offset: counter},
	               }
	             };
	             chart.draw(data, options);
	             if (counter > 0.3) clearInterval(handler);
	         }, 200);         
	         
}

</script>
</head>
<body>
 <div id="layoutSidenav">
  <div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
				<h2 class="mt-4 fw-bold" style="color:#585858;">DashBoard</h2>
					<div class="row">
						<div class="col-xl-3 col-md-6">
							<div class="card mb-4 topcard1">
							<div class="row">
							<div class="col-9">
								<div  style="color:#fe3995;">이번 달 매출</div>
								<div class="fw-bolder fs-4"style="color: #2E2E2E;"><fmt:formatNumber value="${map.thismonth }" pattern="##,###"/></div>
							 </div><div class="col-3 fs-1" style="color: #D8D8D8;"><i class="bi bi-currency-dollar"></i></div>
							 </div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card mb-4 topcard2">
							<div class="row">
							<div class="col-9">
								<div style="color:#f6aa33;">2022년 매출</div>
								<div class="fw-bolder fs-4"style="color: #2E2E2E;"><fmt:formatNumber value="${map.thisyear }" pattern="##,###"/></div>
								</div><div class="col-3 fs-1" style="color: #D8D8D8;"><i class="bi bi-currency-exchange"></i></div>
							 </div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card mb-4 topcard3">
							<div class="row">
							<div class="col-9">
								<div style="color:#2abe81;">이번 달 회원 유입수</div>
								<div class="fw-bolder fs-4"style="color: #2E2E2E;"><fmt:formatNumber value="${map.monthguest }" pattern="##,###"/></div>
								</div><div class="col-3 fs-1" style="color: #D8D8D8;"><i class="bi bi-person-fill"></i></div>
							 </div>
							</div>							
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card mb-4 topcard4">
							<div class="row">
							<div class="col-9">
								<div style="color:#6e4ff5;">전체 회원수</div>
								<div class="fw-bolder fs-4"style="color: #2E2E2E;"><fmt:formatNumber value="${map.totalguest }" pattern="##,###"/></div>
								</div><div class="col-3 fs-1" style="color: #D8D8D8;"><i class="bi bi-people-fill"></i></div>
							 </div>
							</div>
						</div>
					</div>
					<!-- 차트 -->
					<div class="row">
                            <div class="col-xl-8">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                         	월별 매출 현황
                                    </div>
                                    <div class="card-body" style="width: 100%; height: 400px;" align="center"id="monthlyChart"></div>
                                </div>
                            </div>
                            <div class="col-xl-4">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="bi bi-pie-chart-fill"></i>
                                        	카테고리별 매출
                                    </div>
                                    <div class="card-body" style="width: 100%; height: 400px;" align="center"id="categoryChart"></div>
                                </div>
                            </div>
                        </div>
                     <!-- 이번 달 최고 매출숙소 Top 10 -->
                     <div class="row">
						<div class="col-xl-7">
							<div class="card mb-4">
								<div class="card-header">
									<i class="bi bi-hand-thumbs-up-fill"></i> 이번달 최고 매출 숙소 Top10
								</div>
								<div class="card-body">
									<table id="roomtable" class="table table-striped table-hover"
										style="width: 100%;">
										<thead>
											<tr>
												<!-- 프로필 -->
												<th></th>
												<th>숙소명</th>
												<th>호스트</th>
												<th>1박가격</th>
												<th>주소</th>
												<th>리뷰 수</th>
												<th>총 예약 수</th>
												<th>평균 별점</th>
												<th>연매출(원)</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="room" items="${map.roomlist }" >
												<tr>
													<td >
													<a href="${path}/rooms/detail/${room.room_idx}">
													<c:if test="${room.photo1 == null}">
															<img class="me-3 ms-2"
																src="${path }/resources/images/guest.png"
																style="width: 60px; height: 60px;" />
														</c:if> <c:if test="${room.photo1 != null}">
															<img class="me-2 ms-2"
																src="${path}/imgUpload/${room.photo1 }"
																style="width: 60px; height: 60px;">
														</c:if></a> </td><td align="left">${room.room_name }</td>
													<td>${room.h_userid }</td>
													<td><fmt:formatNumber value="${room.room_price }"
															pattern="##,###" /></td>
													<td>${room.address1 }</td>
													<td>${room.review_count }</td>
													<td>${room.res_count }</td>
													<td><c:forEach begin="1" end="${room.review_star }">
															<span style="color: #ffbf00; font-size: 14px;">
															<i class="bi bi-star-fill"></i></span>
														</c:forEach> <c:forEach begin="1" end="${5-room.review_star }">
															<span style="color: #ffbf00; font-size: 14px;">
															<i class="bi bi-star"></i></span>
														</c:forEach></td>
													<td><fmt:formatNumber value="${room.total_price }"
															pattern="##,###" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="col-xl-5">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="bi bi-patch-question-fill"></i>
                                        	QnA 답변대기 목록
                                    </div>
                                    <div class="card-body">
                                     <table id="qnatable" class="table table-striped table-hover"
										style="width: 100%;">
										<thead>
											<tr>
												<!-- 프로필 -->
												<th>카테고리</th>
												<th>제목(댓글 수)</th>
												<th>글쓴이</th>
												<th>조회수</th>
												<th>작성일자</th>
												<th>스크랩 수</th>
												<th>추천 수</th>
												<th>채택상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="qna" items="${map.qnalist }" >
												<tr>
													<td>
													<div class="badge mb-2"
													style="background: #ffeed0; color: black;">${qna.category }</div>
													</td>
													<td align="left">
													<a class="text-decoration-none link-dark "
													href="${path }/qna/qnaview.do?q_idx=${qna.q_idx}">
													${qna.subject}(${qna.comment_count })</a></td>
													<td>${qna.userid }</td>
													<td>${qna.view_count }</td>
													<td><fmt:formatDate value="${qna.write_date }"
																pattern="yy.MM.dd" /></td>
													<td>${qna.scrap }</td>
													<td>${qna.likey }</td>
													<td style="font-weight: bold; color: #8d8d8d;"> 답변대기</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
                                    </div>
                                </div>
                            </div>
                        </div>
				</div>
			</main>

			<%@ include file="../include/footer.jsp"%>
 </div>
</div>
</body>
</html>
