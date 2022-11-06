<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>
<!-- font awesome 아이콘 -->
<script src="https://kit.fontawesome.com/fdfee59c02.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>STAYHERE</title>
<script type="text/javascript">
$(function(){
	listReply();
	listAttach();
});
function checkImageType(fileName){
	var pattern=/jpg|png|gif/i; //정규표현식(i는 대소문자 무시)
	return fileName.match(pattern); //규칙에 맞으면 true가 리턴
}
function getOriginalName(fileName){
	if(checkImageType(fileName)){//이미지 파일이면 skip
		return;
	}
	var idx=fileName.indexOf("_")+1; //uuid를 제외한 파일이름만 뽑음
	return fileName.substr(idx);
}
function getImageLink(fileName){
	if(!checkImageType(fileName)){ //이미지 파일이 아니면 skip
		return;
	}
	return fileName;
}
function getFileInfo(fullName){
	var fileName, imgsrc, getLink, fileLink;
	if(checkImageType(fullName)){ //이미지 파일인 경우
		imgsrc="${path}/qna/displayFile?fileName="
			+fullName;
	}
		getLink="${path}/qna/displayFile?fileName="
				+fullName;
	// uuid_filename (+1은 _ 다음의 filename을 뽑아냄)
	fileName=fullName.substr(fullName.indexOf("_")+1);
	//json 리턴
	return {fileName: fileName, imgsrc: imgsrc,
			getLink: getLink, fullName:fullName };
}
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
	var qidx= $("#qidx").val();
	var contents= $("#contents").val();
		$.ajax({
			type: 'POST',
			dataType:'json',
			url: "${path }/qna/addcomment.do",
			data:{
				"writer":writer,
				"q_idx":qidx,
				"contents":contents
			},
			success: function(result){
				location.href="${path}/qna/qnadetail.do?q_idx="+result;
			}
		});
	}
}
//댓글 목록 출력 함수
function listReply(){
	$.ajax({
		type: "get",
		url: "${path}/qna/commentlist.do?q_idx=${dto.q_idx}",
		success: function(result){
			$("#listReply").html(result);
		}
	});
}
//첨부파일 리스트 출력
function listAttach(){
	$.ajax({
		type: "post",
		url: "${path}/qna/getAttach/${dto.q_idx}",
		success: function(list){
			$(list).each(function(){
				var fileInfo=getFileInfo(this);
				//console.log(fileInfo);
				var str="<div><a href='"+fileInfo.getLink+"'>"
					+fileInfo.fileName+"</a></div>";
			$("#uploadedList").append(str);
		});
	}
});
}
function addscrap(q_idx,scrap){
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
			location.href="${path}/qna/qnadetail.do?q_idx="+q_idx;
		},
		error: function(result){
			alert("이미 스크랩하신 글입니다.");
		}
	});
}
function addlikey(q_idx,like){
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
			location.href="${path}/qna/qnadetail.do?q_idx="+q_idx;
		},
		error: function(result){
			alert("이미 추천하신 글입니다.");
		}
	});
}
function delscrap(q_idx,scrap){
	var userid;
	if("${sessionScope.userid != null}"=="true"){
		userid="${sessionScope.userid}";
	}else if("${sessionScope.h_userid != null}"=="true"){
		userid="${sessionScope.h_userid}";
	}
	$.ajax({
		type: 'POST',
		dataType:'json',
		url: "${path }/qna/delscrap.do",
		data:{
			"userid":userid,
			"q_idx":q_idx
		},
		success: function(result){
			if(result==1)
			location.href="${path}/qna/qnadetail.do?q_idx="+q_idx;
		}
	});
}
function dellikey(q_idx,like){
	var userid;
	if("${sessionScope.userid != null}"=="true"){
		userid="${sessionScope.userid}";
	}else if("${sessionScope.h_userid != null}"=="true"){
		userid="${sessionScope.h_userid}";
	}
	$.ajax({
		type: 'POST',
		dataType:'json',
		url: "${path }/qna/dellikey.do",
		data:{
			"userid":userid,
			"q_idx":q_idx
		},
		success: function(result){
			if(result==1)
			location.href="${path}/qna/qnadetail.do?q_idx="+q_idx;
		}
	});
}
</script>
</head>
<body class="d-flex flex-column">
<%@ include file="../include/navbar.jsp"%>
<!-- content -->
  <section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div class="justify-content-center flex-sm-column d-sm-flex align-items-center">
				<h2 class="fw-bold" style="font-size: 40px;">Q&A</h2>
				<h2 class="fw-light " style="font-size: 18px; margin-top: 20px;">
					Q&A > <a href="${path }/qna/qnalist.do?category=${dto.category}">${dto.category }</a>
				</h2>
			</div>
			<!--목록으로 돌아가기 -->
			<div class="row">
			 <div class="col-9">
			<span onclick="location.href='${path}/qna/qnalist.do'" style="cursor:pointer;">
			<i class="fa-solid fa-rotate-left"></i> 목록으로 돌아가기</span>
			 </div>
			 <c:if test="${dto.userid == sessionScope.userid || dto.userid == sessionScope.h_userid }">
			 <div class="col-3" align="right">
			  <span onclick="location.href='${path }/qna/qnaedit.do?q_idx=${dto.q_idx }'"
			  style="cursor:pointer;">[수정/삭제]</span>
			 </div>
			  </c:if>
			</div>
			<div class="row mt-4 mb-4" style="border-bottom:2px solid #000;"></div>
			<!-- 프로필-->
			<div class="row mt-3 mb-4">
				<div class="col-9">
					<div class="d-flex align-items-center">
						<img class="rounded-circle me-3"
							src="${path}/imgUpload/${dto.profile_img}"
							style="width: 50px; height: 50px;" />
						<div class="small">
							<div class="fw-bold">${dto.userid }</div>
							<div class="text-muted ">
								<fmt:formatDate value="${dto.write_date }"
									pattern="M월 dd일, yyyy / HH:mm:ss" />
							</div>
						</div>
					</div>
				</div>
				<div class="col-3 ms-auto" align="right">
					<i class="fa-regular fa-eye"> ${dto.view_count }</i> &nbsp; 
				<c:if test="${scrap==0 }">
				 <div id="scraparea" onclick="addscrap('${dto.q_idx}','${dto.scrap +1}');" style="cursor:pointer; display:inline;">
						<i class="fa-regular fa-bookmark"> ${dto.scrap }</i> &nbsp;</div> </c:if>
				<c:if test="${scrap==1 }">
				 <div id="delscraparea" onclick="delscrap('${dto.q_idx}','${dto.scrap -1}');" style="cursor:pointer; display:inline;">
						<i class="fa-solid fa-bookmark"> ${dto.scrap }</i> &nbsp; </div></c:if>
				<c:if test="${likey==0 }">
				 <div id="likearea" onclick="addlikey('${dto.q_idx}','${dto.likey +1}');" style="cursor:pointer; display:inline;">
						<i class="fa-regular fa-thumbs-up"> ${dto.likey }</i></div></c:if>
				<c:if test="${likey==1 }">
				 <div id="dellikearea" onclick="dellikey('${dto.q_idx}','${dto.likey -1}');" style="cursor:pointer; display:inline;">
						<i class="fa-solid fa-thumbs-up"> ${dto.likey }</i></div></c:if>
				</div>
			</div>
			 <!-- Post content-->
               <article>
                   <!-- Post header-->
                   <header class="mb-4">
                   <!-- Post categories-->
                   <div class="row">
                    <div class="col-8">
                       <div class="badge mb-2" style="background: #ffeed0; color: black;">${dto.category }</div>
                       <!-- Post title-->
                       <h2 class="fw-bolder mb-3">${dto.subject }</h2>
                       <!-- Post meta content-->
                       <div class="text-muted fst-italic mb-5"><fmt:formatDate value="${dto.write_date }"
		pattern="M월 dd일, yyyy / HH:mm:ss" /></div>
						</div>
						<div class="col-4 ms-auto" align="right"> 
						 <div id="uploadedList" style="width:100%;"></div>
						</div>
                       </div>
                   </header>
                   <!-- Post content-->
                   <section class="mb-5 mt-3">
                       <p class="fs-6 mb-4" >${dto.contents }
                       </p>
                   </section>
               </article>
               <!-- 댓글 영역 -->
               <div id="listReply" style="width:100%;"></div>
           </div>
	</section>	
<!-- footer -->
<%@ include file="../include/footer.jsp"%>
</body>
</html>