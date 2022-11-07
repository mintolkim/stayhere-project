<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/admin_header.jsp"%>
<!-- 구글 차트 호출을 위한 js 파일 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
//구글 차트 라이브러리 로딩
google.charts.load("current", {packages:["corechart"],'language':'ko'});
//라이브러리 로딩이 완료되면 drawChart함수호출, ()는 안씀
google.charts.setOnLoadCallback(drawChart);

function drawChart(){
	//차트 그리기에 필요한 json 데이티 로딩
	var jsonData=$.ajax({
		url: "${path}/chart/montlychart",
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
              0: { color: '#2abe81' }
            },
            vAxis: { gridlines: { count: 5 },
            	format : 'long'}
    }
	var chart=new google.visualization.ColumnChart(
       	  document.getElementById("chart_div"));   
 
        chart.draw(data, options);
}
function selectoption(){
	var option=$("#selection").val();
	//막대차트
	if(option=='1'){
		var jsonData=$.ajax({
			url: "${path}/chart/montlychart",
			dataType: "json",
			async: false //동기식처리(순차적 처리:데이터를 다부른 후 챠트출력하기 위해)
		    }).responseText;
	    console.log(jsonData);
	    var data=new google.visualization.DataTable(jsonData);
	    var options = {
	    		title: '월별 매출', 
	    	    is3D: true,
	    	    animation: { //차트가 뿌려질때 실행될 애니메이션 효과
	                startup: true,
	                duration: 300,
	                easing: 'linear' },
	    	    bar: {groupWidth: "90%"},
	    	    legend: { position: 'bottom' },
	            series: {
	              0: { color: '#2abe81' }
	            },
	            vAxis: { gridlines: { count: 5 },
	            	format : 'long'}
	    }
	    var chart=new google.visualization.ColumnChart(
	         	  document.getElementById("chart_div"));   
	   
	          chart.draw(data, options);
	 //라인차트
	}else if(option=='2'){
		var jsonData=$.ajax({
			url: "${path}/chart/montlychart",
			dataType: "json",
			async: false //동기식처리(순차적 처리:데이터를 다부른 후 챠트출력하기 위해)
		    }).responseText;
	    console.log(jsonData);
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
	            series: {
	              0: { color: '#6e4ff5' }
	            },
	            vAxis: { gridlines: { count: 5 },
	            	format : 'long'}
	    }
	    var chart=new google.visualization.LineChart(
	    	    document.getElementById("chart_div"));  
	   
	          chart.draw(data, options);
	 //파이차트
	}else{
		var jsonData=$.ajax({
			url: "${path}/chart/montlychart",
			dataType: "json",
			async: false //동기식처리(순차적 처리:데이터를 다부른 후 챠트출력하기 위해)
		    }).responseText;
	    var data=new google.visualization.DataTable(jsonData);
	    var options = {
	    		title: '월별 매출', 
	    	    is3D: false,
	    	    pieHole: 0.4,
	    	    colors: ['#fe3995', '#f6aa33', '#6e4ff5', '#2abe81', '#c7d2e7', '#593ae1'],
	    	    pieSliceText: 'label',
	    	    legend: { position: 'right' },
	    }
	    var chart=new google.visualization.PieChart(
	    	    document.getElementById("chart_div"));
	         
	        var counter = 0;
	         var handler = setInterval(function(){ 
	             counter = counter + 0.1
	             options = {
	               title: '월별 매출',
	               is3D: false,
		    	    pieHole: 0.4,
		    	    colors: ['#fe3995', '#f6aa33', '#6e4ff5', '#2abe81', '#c7d2e7', '#593ae1'],
		    	    pieSliceText: 'label',
	               slices: { 1: {offset: counter},                       
	                         3: {offset: counter},                       
	                         5: {offset: counter},
	               }
	             };
	             chart.draw(data, options);
	             if (counter > 0.3) clearInterval(handler);
	         }, 200);         
	       
	}
}
$(function(){
$("#btn-print").on('click',function(){
	let printHtml = $(".print-page-area").html();
    let win=window.open('','연간 실적 추이','height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
	win.document.write("<html><head>");
		win.document.write("<link rel='stylesheet' type='text/css' href='${path}/resources/css/adminstyles.css'/>");
		win.document.write("</head><body>");
	win.document.write(printHtml);
	win.document.write("</body></html>");
	win.document.close();
	win.focus();
	setTimeout(function(){win.print();win.close();}, 1000);
});
});
</script>
</head>
<body>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content" class="print-page-area">
		<div class="text" style="margin-left:100px; margin-top:50px;">
		 <h3 class="fw-bolder" >STAYHERE 연간 실적 추이 </h3>
		  <h5>[2021.12 - 2022.11]</h5></div>
			<div style="margin-right:250px;" align="right">
			<select class="form-select" style="width:120px;display:inline;"id="selection" onchange="selectoption()">
				<option disabled selected>차트선택</option>
				<option value="1">막대차트</option>
				<option value="2">라인차트</option>
				<option value="3">파이차트</option>
			</select>
			<button type="button" id="btn-print" class="btn btn-secondary">
			<i class="fa-solid fa-print" ></i> 인쇄
			</button>
			</div>
			<div id="chart_div" style="width: 100%; height: 600px;"></div>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
</body>
</html>
