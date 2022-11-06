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
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Year', 'Sales'],
          ['2022',  1170],
          ['2023',  660]
        ]);

        var options = {
          title: '${sessionScope.h_name}님의 연간매출',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

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
	<div class="container" >
	  <div class="row">
	    <div class="col-3" align="center">
	      <div class="box" >
		  <img class="profile" src="${path}/imgUpload/${dto.h_profile_img}">
		  </div>
		  <br>
		  <div style="margin-bottom: 3%;">
		  <p class="lead" style="font-size: 20px;">${sessionScope.h_name}님 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-heart" viewBox="0 0 16 16">
  		  <path d="M8 6.982C9.664 5.309 13.825 8.236 8 12 2.175 8.236 6.336 5.309 8 6.982Z"/>
  		  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.707L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.646a.5.5 0 0 0 .708-.707L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"/>
		  </svg></p>
		  </div>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}">연간매출</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}">월간매출</a></p>
    	  <p class="lead" ><a href="${path}/host/rooms_Sales/${sessionScope.h_userid}">일일매출</a></p>
		  </div>
	      <div class="col-md-8" align="center">
	       <div id="curve_chart" style="width: 900px; height: 500px"></div>
	      
	      
	      </div>
		</div>
	  </div>

    </div>
  </section>

 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>