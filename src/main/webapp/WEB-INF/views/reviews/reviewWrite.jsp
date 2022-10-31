<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE-REVIEW</title>
<script type="text/javascript">
	$(function() {
		$("#btnInsert").click(function() {
			document.form1.submit();
		});

	});
</script>
<style type="text/css">
.titleB{
		margin-top: 10px;
		margin-bottom: 30px;
}
.star fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
    margin-bottom: 30px;
}
.star fieldset legend{
    text-align: right;
}
.star input[type=radio]{
    display: none;
}
.star label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
.star label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
.star label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
.star input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
.reviewText input, .roomsInfo input{
		display: block;
		width: 50%;
		min-width: 300px;
		margin-bottom: 10px;
		margin-top: 10px;
}
.reviewText textarea{
		width: 50%;
		min-width: 300px;
}
.btnSubmit{
		text-align: center;
		margin-top: 30px;
}
.btnSubmit2{
		display: inline-block;
}

</style>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
		<%@ include file="../include/navbar.jsp"%>

		<!-- 본문영역-->
		<section class="py-5" id="features">
			<div class="container rounded-3 py-5 px-4 px-md-5 mb-5" align="center">
				<p class="lead fw-normal text-muted mb-0">"당신의 경험을 공유하세요"</p>
				<h2 class="titleB fw-bolder">리뷰쓰기</h2>
				<form id="form1" name="form1" method="post" action="${path}/reviews/insert.do">
					<div class="container roomsInfo">
					  <!-- 숙소정보 끌어와야함.(room_idx, room_name, photo1)
					  <input name="roomReview" id="roomReview" placeholder="숙소 정보끌어오기전  임시 작성칸(번호입력)"> -->
					</div>
					<div class="container star">
					  <p class="lead fw-normal text-muted mb-0">숙소는 만족하셨나요?</p>
						<fieldset>
							<input type="radio" name="reviewStar" value="5" id="rate1">
								<label for="rate1">★</label>
							<input type="radio" name="reviewStar" value="4" id="rate2">
								<label for="rate2">★</label>
							<input type="radio" name="reviewStar" value="3" id="rate3">
								<label for="rate3">★</label> 
							<input type="radio" name="reviewStar" value="2" id="rate4">
								<label for="rate4">★</label> 
							<input type="radio" name="reviewStar" value="1" id="rate5">
								<label for="rate5">★</label>
						</fieldset>
					</div>
					<div class="container reviewText">
						<p class="lead fw-normal text-muted mb-0">어떤 점이 좋았나요?</p>
						<input name="r_title" id="r_title" placeholder="제목을 입력하세요">
						<textarea id="review_content" name="review_content"	placeholder="내용을 입력하세요"></textarea>
					</div>
					<div class="btn btnSubmit">
						<!-- 삭제는 임시버튼 유저리뷰리스트 만들고 이동 -->
						<button class="btn btnSubmit2 btn-outline-warning" type="submit" id="btnUpdate">수정</button>
						<button class="btn btnSubmit2 btn-outline-warning" type="submit" id="btnDelete">삭제</button>
						<button class="btn btnSubmit2 btn-warning" type="submit" id="btnInsert">작성</button>
					</div>
				</form>

			</div>
		</section>
	</main>

	<!--footer  -->
	<%@ include file="../include/footer.jsp"%>

</body>
</html>