<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<script src="https://kit.fontawesome.com/fdfee59c02.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>STAYHERE</title>
<script type="text/javascript">
$(function() {
	listReply();
	listAttach();
});
function checkImageType(fileName) {
	var pattern = /jpg|png|gif/i; //정규표현식(i는 대소문자 무시)
	return fileName.match(pattern); //규칙에 맞으면 true가 리턴
}
function getOriginalName(fileName) {
	if (checkImageType(fileName)) {//이미지 파일이면 skip
		return;
	}
	var idx = fileName.indexOf("_") + 1; //uuid를 제외한 파일이름만 뽑음
	return fileName.substr(idx);
}
function getImageLink(fileName) {
	if (!checkImageType(fileName)) { //이미지 파일이 아니면 skip
		return;
	}
	return fileName;
}
function getFileInfo(fullName) {
	var fileName, imgsrc, getLink, fileLink;
	if (checkImageType(fullName)) { //이미지 파일인 경우
		imgsrc = "${path}/reviews/displayFile?fileName=" + fullName;
	}
	getLink = "${path}/reviews/displayFile?fileName=" + fullName;
	// uuid_filename (+1은 _ 다음의 filename을 뽑아냄)
	fileName = fullName.substr(fullName.indexOf("_") + 1);
	//json 리턴
	return {
		fileName : fileName,
		imgsrc : imgsrc,
		getLink : getLink,
		fullName : fullName
	};
}
//첨부파일 리스트 출력
function listAttach() {
	$.ajax({
		type : "post",
		url : "${path}/reviews/getAttach/${dto.review_idx}",
		success : function(list) {
			$(list).each(function() {
				var fileInfo = getFileInfo(this);
				var str = "<div><a href='"+fileInfo.getLink+"'>"
						+ fileInfo.fileName + "</a></div>";
				$("#uploadedList").append(str);
			});
		}
	});
}
//댓글입력
function mykeydown() {
	if(window.event.keyCode==13){ //enter 일 경우
	var writer;
	if("${sessionScope.userid != null}"=="true"){
		writer = "${sessionScope.userid}";
	}else if("${sessionScope.h_userid != null}"=="true"){
		writer="${sessionScope.h_userid}";
	}else{
		if(confirm("로그인이 필요합니다. 로그인페이지로 이동하시겠습니까?")){
			location.href="${path}/guest/login.do";
			}else return;
	}
	var review_idx= $("#reComment_idx").val();//리뷰코멘트 히든 아이디
	var contents= $("#contents").val();
		$.ajax({
			type: 'POST',
			dataType:'json',
			url: "${path}/reviews/addcomment.do",
			data:{
				"writer" : writer,
				"review_idx" : review_idx,
				"contents" : contents
			},
			success: function(result){
				location.href="${path}/reviews/detail.do?review_idx="+result;
			}
		});
	}
}
//댓글 목록 출력 함수
function listReply() {
	$.ajax({
		type : "get",
		url : "${path}/reviews/commentlist.do?review_idx=${dto.review_idx}",
		success : function(result) {
			$("#listReply").html(result);
		}
	});
}
/* function accuseCheck(review_idx){
	 var user;
	 if("${sessionScope.userid != null}"=="true"){
	 user="${sessionScope.userid}";
	 }else if("${sessionScope.h_userid != null}"=="true"){
	 user="${sessionScope.h_userid}";
	 }else{
	 if(confirm("로그인이 필요합니다. 로그인페이지로 이동하시겠습니까?")){
	 location.href="${path}/guest/login.do";
	 }else return;
	 }
	 $.ajax({
	 type: 'POST',
	 dataType:'json',
	 url: "${path}/reviews/accuseCheck.do",
	 data:{
	 "review_idx":review_idx
	 },
	 success: function(result){
	 if(result==1)
	 location.href="${path}/reviews/accuseCheck.do?review_idx="+review_idx;
	 },
	 error: function(result){
	 alert("이미 신고하신 글입니다.");
	 }
	 });
	
	 } */
</script>
<style type="text/css">
.title {
	margin-bottom: 30px;
}

.profile {
	width: 50px;
	height: 50px;
}

.spanB span {
	margin-right: 10px;
}

.guestProfile {
	margin-right: 10px;
}

.reviewImage {
	width: 300px;
	height: 200px;
}

.reviewContent {
	margin-top: 20px;
	width: 100%;
}

#replyList {
	width: 70%;
	min-width: 300px;
}

#reviewStar {
	margin-bottom: 10px;
}
</style>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- nav -->
		<%@ include file="../include/navbar.jsp"%>


		<section class="py-5">
			<div class="container px-4 px-lg-5 mt-5">
				<div
					class="justify-content-center flex-sm-column d-sm-flex align-items-center title">
					<h2 class="fw-bold" style="font-size: 40px;">REVIEW</h2>
				</div>

				<!--목록으로 돌아가기 -->
				<div class="row">
					<div class="col-9">
						<span onclick="location.href='${path}/reviews/list.do'"
							style="cursor: pointer;"> <i
							class="fa-solid fa-rotate-left spanA"></i> 목록으로 돌아가기
						</span>
					</div>
					<c:if
						test="${dto.userid == sessionScope.userid || dto.userid == sessionScope.h_userid }">
						<div class="col-3 spanB" align="right">
							<span
								onclick="location.href='${path}/reviews/edit.do?review_idx=${dto.review_idx}'"
								style="cursor: pointer;">[ 수정 / 삭제 ]</span> <span
								onclick="location.href='#'" style="cursor: pointer; color: red;">[신고
								<i class="fa-solid fa-ban"></i> ]
							</span>
						</div>
					</c:if>
					<c:if test="${dto.userid == null }">
						<div class="col-3 spanB" align="right">
							<span onclick="location.href='#'"
								style="cursor: pointer; color: red;">[신고 <i
								class="fa-solid fa-ban"></i> ]
							</span>
						</div>
					</c:if>
				</div>

				<div class="row mt-4 mb-4" style="border-bottom: 2px solid #000;"></div>

				<div class="row mt-3 mb-4">
					<div class="col-9">
						<div class="d-flex align-items-center">
							<!-- 게스트프로필 이미지 -->
							<div class="rounded-circle me-3 guestProfile">
								<c:if test="${dto.profile_img != null}">
									<div class="profile_img">
										<img class="profile img-fluid rounded-circle"
											src="${path}/imgUpload/${dto.profile_img}">
									</div>
								</c:if>
								<!-- 로그인유저의 profile_img가없다면 디폴트 이미지 노출 -->
								<c:if test="${dto.profile_img == null}">
									<div class="profile_imgDefault">
										<img class="profile img-fluid rounded-circle"
											src="${path}/resources/images/guest.png">
									</div>
								</c:if>
							</div>
							<div class="small">
								<div class="fw-bold">${dto.name}(${dto.userid})</div>
								<div class="text-muted ">
									<fmt:formatDate value="${dto.write_date}"
										pattern="M월 dd일, yyyy / HH:mm:ss" />
								</div>
							</div>
						</div>
					</div>
					<!-- 조회수 -->
					<div class="col-3 ms-auto" align="right">
						<i class="fa-regular fa-eye"> ${dto.view_count}</i> &nbsp;
					</div>
				</div>
				<div class="row mt-3 mb-4">
					<!-- 리뷰별점 -->
					<div class="tab-pane">
						<div class="col-sm-6 review_star" id="reviewStar">
							<c:if test="${dto.review_star == '1' }">⭐ /5</c:if>
							<c:if test="${dto.review_star == '2' }">⭐ ⭐ /5</c:if>
							<c:if test="${dto.review_star == '3' }">⭐ ⭐ ⭐/5</c:if>
							<c:if test="${dto.review_star == '4' }">⭐ ⭐ ⭐ ⭐/5</c:if>
							<c:if test="${dto.review_star == '5' }">⭐ ⭐ ⭐ ⭐ ⭐/5</c:if>
						</div>
						<hr style="border: 1px solid #dadada; margin: 0 40px 0 40px;">
						<!-- 리뷰상세 -->
						<div class="col-lg-9 reviewContent">
							<article>
								<header class="mb-4">
									<h2 class="fw-bolder mb-1">${dto.r_title}</h2>
									<div class="text-muted fst-italic mb-2">
										<fmt:formatDate value="${dto.write_date}"
											pattern="M월 dd일, yyyy / HH:mm:ss" />
									</div>
									<div class="col-4 ms-auto" align="right">
										<div id="uploadedList" style="width: 100%;"></div>
									</div>
								</header>
								<!-- 리뷰내용-->
								<section class="mb-5">
									<p class="fs-5 mb-4">${dto.review_content}</p>
								</section>
							</article>

							<!-- 댓글영역-->
							<div id="listReply"></div>
						</div>
					</div>
				</div>


			</div>
		</section>
	</main>

	<!--footer  -->
	<%@ include file="../include/footer.jsp"%>

</body>
</html>