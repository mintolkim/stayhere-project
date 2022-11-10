<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Host Room Write</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
a { text-decoration: none; color: black;}
.lead a { color: black; font-size: 16px;}
.lead a:hover { color: black; font-size: 16px; font-weight: 640;}
label { 
	font-size: 13px;
}
.box {
    width: 200px;
    height: 200px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
    background-color: #c3c3c3;
}
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
//구글 차트 라이브러리 로딩
google.charts.load("current", {packages:["corechart"],'language':'ko'});
//라이브러리 로딩이 완료되면 drawChart함수호출, ()는 안씀
google.charts.setOnLoadCallback(drawChart);

function drawChart(){
	//차트 그리기에 필요한 json 데이티 로딩
	var jsonData=$.ajax({
		url: "${path}/host/montlychart",
		dataType: "json",
		async: false //동기식처리(순차적 처리:데이터를 다부른 후 챠트출력하기 위해)
	    }).responseText;
  var data=new google.visualization.DataTable(jsonData);
  var options = {
  		title: '월별 매출', 
  		subtitle: 'Sales, Expenses, and Profit: 2021.12-2022.11',
  	    is3D: true,
  	    animation: { //차트가 뿌려질때 실행될 애니메이션 효과
              startup: true,
              duration: 300,
              easing: 'linear' },
  	    legend: { position: 'bottom' },
  	    bar: {groupWidth: "90%"},
          series: {
            0: { color: '#ffcd4a' }
          },
          vAxis: { gridlines: { count: 5 },
          	format : 'long'}
  }
	var chart=new google.visualization.ColumnChart(
     	  document.getElementById("chart_div"));   

      chart.draw(data, options);
}

</script>
</head>
<body class="d-flex flex-column">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
    <div>
   	<i class="bi bi-arrow-left-circle fs-1 mx-5" onclick="window.history.back();"></i>
    </div>
	<div class="container" >
	  <div class="row">
	    <div class="col-3" align="center">
	    <c:if test="${map.dto.h_profile_img!=null}">
	      <div class="box" >
		  <img class="profile" src="${path}/imgUpload/${map.dto.h_profile_img}">
		  </div>
	    </c:if>
	    <c:if test="${map.dto.h_profile_img==null}">
	      <div class="box" >
		  <img class="profile" src="${path}/resource/images/guest.png ">
		  </div>
	    </c:if>		  
		  <br>
		  <div style="margin-bottom: 3%;">
		  <p class="lead" style="font-size: 20px;">${sessionScope.h_name}님 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-heart" viewBox="0 0 16 16">
  		  <path d="M8 6.982C9.664 5.309 13.825 8.236 8 12 2.175 8.236 6.336 5.309 8 6.982Z"/>
  		  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.707L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.646a.5.5 0 0 0 .708-.707L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"/>
		  </svg></p>
		  </div>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}">월별매출</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}/weekly">주간매출</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}/room">숙소별매출</a></p>
		  </div>
	      <div class="col-md-8" align="center">
	      <jsp:useBean id="now" class="java.util.Date" />
	      <h4>
	      <fmt:formatDate value="${now}" pattern="yyyy"/> 년 매출
	      </h4>
	      <br>
	 	    매출합계: <fmt:formatNumber type="number" value="${map.yearSum}" maxFractionDigits="3" /> 원 
	      <div id="chart_div" style="height: 100%;"></div>
	      </div>
		</div>
	  </div>
			<c:if test="${message == 'noWeekend' }">
			<script type="text/javascript">
			alert("이번 주의 매출내역이 없습니다.");
			</script>
			</c:if>
    </div>
  </section>

 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>