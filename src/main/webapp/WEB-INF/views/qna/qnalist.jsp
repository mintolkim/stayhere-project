<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<!-- font awesome 아이콘 -->
<script src="https://kit.fontawesome.com/fdfee59c02.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>STAYHERE</title>
<style type="text/css">
.breadcrumb-item{
margin:10px;
padding: 10px;
border-radius: 5px;}
#searchBtn{
border: 1px solid #c9c9c9;
border-radius: 10px;
padding: 5px;}
.breadcrumb-item a:link{text-decoration: none; color:black; font-weight: bold;}
.breadcrumb-item a:visited{text-decoration: none; color:black; font-weight: bold;}
.breadcrumb-item a:hover{text-decoration: none; color:black; font-weight: bold; background: #f3f4f6;}
</style>
<script type="text/javascript">
$(function(){
	let selection= "${map.select}";
	let category = "${map.category}";
	$("#selectQna").val(selection).prop("selected",true);
	$("."+category).css("background","#f3f4f6");
});
function addscrap(q_idx,scrap,index){
	var userid;
	if("${sessionScope.userid != null}"=="true"){
		userid="${sessionScope.userid}";
	}else if("${sessionScope.h_userid != null}"=="true"){
		userid="${sessionScope.h_userid}";
	}else{
		if(confirm("로그인이 필요합니다. 로그인페이지로 이동하시겠습니까?")){
			location.href="${path}/guest/login.do";
		}else return;
	}
	$.ajax({
		type: 'POST',
		dataType:'json',
		url: "${path }/qna/addscrap.do",
		data:{
			"userid":userid,
			"q_idx":q_idx
		},
		success: function(result){
			if(result==1)
			$("#scraparea"+index).html("<i class='fa-solid fa-bookmark'> "+scrap+"</i> &nbsp;");
		},
		error: function(result){
			alert("이미 스크랩하신 글입니다.");
		}
	});
}
function addlikey(q_idx,like,index){
	var userid;
	if("${sessionScope.userid != null}"=="true"){
		userid="${sessionScope.userid}";
	}else if("${sessionScope.h_userid != null}"=="true"){
		userid="${sessionScope.h_userid}";
	}else{
		if(confirm("로그인이 필요합니다. 로그인페이지로 이동하시겠습니까?")){
			location.href="${path}/guest/login.do";
		}else return;
	}
	$.ajax({
		type: 'POST',
		dataType:'json',
		url: "${path }/qna/addlikey.do",
		data:{
			"userid":userid,
			"q_idx":q_idx
		},
		success: function(result){
			if(result==1)
			$("#likearea"+index).html("<i class='fa-solid fa-thumbs-up'> "+like+"</i> ");
		},
		error: function(result){
			alert("이미 추천하신 글입니다.");
		}
	});
}
//페이지이동
function list(page){
	location.href="${path}/qna/qnalist.do?curPage="+page;
} 
//검색
function search(){
	var keyword = $("#searchBtn").val();
	location.href="${path}/qna/qnalist.do?keyword="+keyword;
}
//조회
function selectqna(){
	let select = $("#selectQna").val();
	location.href="${path}/qna/qnalist.do?select="+select;
}
</script>
<style type="text/css">
#qnatable{
border-collapse: collapse;
width: 100%;
font-size: 15px;
font-weight: lighter;
text-align: center;
}
.breadcrumb-item{
text-align: center;}
#qnatable a:link{text-decoration: none; color:#959595; }
#qnatable a:visited{text-decoration: none; color:#959595; }
#qnatable a:hover{text-decoration: underline; color:#836e53; }
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
		
		<!-- 리뷰작성 안내 -->
		<header class="py-5 bg-image-full"
			style="background-image: url('${path}/resources/images/qnaimg1.jpg'); background-size:100% 100%;">
			<div class="text-center my-5">
				<h1 class="text-white fs-3 fw-bolder">궁금하신 내용은 QnA게시판을 통해 답변 받아보세요!</h1>
				<button type="button" style="display:inline-block;font-weight: bold;" 
				onclick="location.href='${path}/qna/qnawrite.do'"class="btn btn-warning mt-3">작성하기</button>
			</div>
		</header>
		<!-- 본문영역-->
		<section class="py-5" id="features">
			<div class="container px-5 my-3 ">
			<!-- <div class="justify-content-center flex-sm-column d-sm-flex align-items-center mb-5">
				<h2 class="fw-bold" style="font-size: 40px;">Q&A</h2>
			</div> -->
				<!--글작성하기  -->
				 <div class="row">
				 <div class="col-2">
				
				</div>
				<div class="col-8" style="display: flex;  justify-content: center;">
				<!-- 카테고리 선택 -->
				<div style="--bs-breadcrumb-divider: ' ';" aria-label="breadcrumb"> 
					<ol class="breadcrumb">
						<li class="breadcrumb-item all"  ><a href="${path }/qna/qnalist.do?category=all">전체 </a></li>
						<li class="breadcrumb-item 결제문의" ><a href="${path }/qna/qnalist.do?category=결제문의">결제문의</a></li>
						<li class="breadcrumb-item 예약문의" ><a href="${path }/qna/qnalist.do?category=예약문의">예약문의</a></li>
						<li class="breadcrumb-item 숙소문의" ><a href="${path }/qna/qnalist.do?category=숙소문의">숙소문의</a></li>
						<li class="breadcrumb-item 기타" ><a href="${path }/qna/qnalist.do?category=기타">기타</a></li>
					</ol>
				</div>
				</div>
				<div class="col-2">
				<!--글 정렬 선택  -->
				<select class="form-select" id="selectQna" onchange="selectqna()" aria-label="select">
					<option value="q_idx">최신순</option>
					<option value="likey">추천순</option>
					<option value="scrap">스크랩순</option>
					<option value="comment_count">조회순</option>
				</select>
				</div>
				<hr>
				</div>
				<!--검색하기 -->
				<form class="d-flex justify-content-center mb-3" role="search">
					<input class="me-2" type="search" id="searchBtn" name="keyword" value="${map.keyword }" placeholder="Search.." size="40">
					<button class="btn" style="background:#ffca2c;" type="button" onclick="search()">검색</button>
				</form>
				
				<!-- 카드 -->
				<div class="row gx-5">
					<c:forEach var="qna" items="${map.list }" varStatus="vs">
						<div class="col-lg-6 mb-4">
							<div class="card h-100 shadow border-0">
								<a class="text-decoration-none link-dark "
									href="${path }/qna/qnaview.do?q_idx=${qna.q_idx}">
									<div class="card-body p-4">
										<div class="row">
											<div class="col-9">
												<div class="badge mb-2"
													style="background: #ffeed0; color: black;">${qna.category }</div>
													<c:if test="${qna.passwd != null }">
													 &nbsp;<i class="fa-solid fa-lock"></i>
													</c:if>
											</div>
											<div class="col-3">
												<c:if test="${qna.choose > 0 }">
													<span
														style="font-size: 18px; font-weight: bold; color: #ffca2c;">채택완료</span>
												</c:if>
												<c:if test="${qna.choose == 0 }">
													<span
														style="font-size: 18px; font-weight: bold; color: #8d8d8d;">답변대기</span>
												</c:if>
											</div>
										</div>
										<h5 class="card-title">${qna.subject }</h5>
									</div>
								</a>
								<div class="row">
									<div class="col-7">
										<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
											<div class="d-flex align-items-end justify-content-between">
												<div class="d-flex align-items-center">
												<c:if test="${qna.profile_img == null}">
												 <img class="rounded-circle me-3" 
														src="${path }/resources/images/guest.png"
														style="width: 50px; height: 50px;" />
												</c:if>
												<c:if test="${qna.profile_img != null}">
													<img class="rounded-circle me-3" 
														src="${path }/imgUpload/${qna.profile_img}"
														style="width: 50px; height: 50px;" /></c:if>
													<div class="small">
														<div class="fw-bold">${qna.userid }</div>
														<div class="text-muted">
															<fmt:formatDate value="${qna.write_date }"
																pattern="yyyy.MM.dd HH:mm:ss" />
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-5 ms-auto">
										<p></p>
										<i class="fa-regular fa-eye"> ${qna.view_count }</i> &nbsp; <i
											class="fa-regular fa-bookmark"> ${qna.scrap }</i> &nbsp; <i
											class="fa-regular fa-thumbs-up"> ${qna.likey }</i> &nbsp; <i
											class="fa-regular fa-comment"> ${qna.comment_count }</i>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<!-- 페이지 네비게이션 -->
					<table id="qnatable" class="mt-3">
						<tr>
							<td colspan="6" align="center"><c:if
									test="${map.pager.curBlock > 1}">
									<a href="#" onclick="list('1')">[처음]</a>
								</c:if> <c:if test="${map.pager.curBlock > 1}">
									<a href="#" onclick="list('${map.pager.prevPage}')"> [이전]</a>
								</c:if> <c:forEach var="num" begin="${map.pager.blockBegin}"
									end="${map.pager.blockEnd}">
									<c:choose>
										<c:when test="${num == map.pager.curPage}">
											<span style="color: #ffcae2; font-weight:bold;">${num}</span>
										</c:when>
										<c:otherwise>
											<a href="#" onclick="list('${num}')">${num}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach> <c:if test="${map.pager.curBlock < map.pager.totBlock}">
									<a href="#" onclick="list('${map.pager.nextPage}')">[다음]</a>
								</c:if> <c:if test="${map.pager.curPage < map.pager.totPage}">
									<a href="#" onclick="list('${map.pager.totPage}')">[끝]</a>
								</c:if></td>
						</tr>
					</table>
				</div>
			</div>
		</section>
	</main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>