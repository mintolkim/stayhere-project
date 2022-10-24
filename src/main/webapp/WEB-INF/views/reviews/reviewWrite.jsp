<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Insert title here</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />
<script src="${path}/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function() {
	$("#btnSave").click(function(){
		location.href="${path}/reviews/list.do";
	});
});

</script>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
		<%@ include file="../include/navbar.jsp"%>
		
		<!-- 본문영역-->
		<section class="py-5" id="features">
			<div class="container px-5 my-5">
				<h2>리뷰작성</h2>
				
				<form id="form1" name="form1" method="post" action="${path}/reviews/insert.do">
					<div>
						제목 <input name="title" id="title" size="80" placeholder="제목을 입력하세요">
					</div>

					<div style="width: 700px;">
						내용
						<textarea id="content" name="content" rows="3" cols="80" 
						placeholder="내용을 입력하세요"></textarea>
						<script>
							// ckeditor 적용
							CKEDITOR.replace("content", {
								filebrowserUploadUrl : "${path}/#.do"
							});// 업로드 관련파일 작업 논의 후 추가
						</script>
					</div>
					<div>
						첨부파일을 등록하세요
						<!-- 업로드 관련파일 작업 논의 후 추가 -->
					</div>
					<div style="width: 700px; text-align: center;">
						<button type="button" id="btnSave">확인</button>
					</div>
				</form>
				
			</div>
		</section>
	</main>
	
	<!--footer  -->
	<%@ include file="../include/footer.jsp"%>

</body>
</html>