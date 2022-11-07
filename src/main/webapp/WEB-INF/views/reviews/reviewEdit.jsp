<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<script src="${path}/resources/ckeditor/ckeditor.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- 구글 폰트  -->
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Montserrat:wght@300&display=swap"
	rel="stylesheet">
<script type="text/javascript">
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
		imgsrc="${path}/reviews/displayFile?fileName="
			+fullName;
	}
		getLink="${path}/reviews/displayFile?fileName="
				+fullName;
	// uuid_filename (+1은 _ 다음의 filename을 뽑아냄)
	fileName=fullName.substr(fullName.indexOf("_")+1);
	//json 리턴
	return {fileName: fileName, imgsrc: imgsrc,
			getLink: getLink, fullName:fullName };
}
$(function() {
	listAttach();
	$("#btnUpdate").click(function() {
		var str = "";
		//uploadedList 영역에 클래스이름이 file인 히든타입의태그를 각각 반복
		$(".uploadedList .file").each(function(i) {
			console.log(i);
			//hidden 태그 구성
			str += "<input type='hidden' name='files[" + i + "]'	value='" 
			+ $(this).val() + "'>";
		});
		//폼에 hidden 태그들을 붙임
		$("#form1").append(str);
		document.form1.submit();
	});//end btnUpdate
//파일을 마우스로 드래그하여 업로드 영역에 올라갈때 파일이 열리는 기본 효과 막음
$(".fileDrop").on("dragenter dragover", function(e) {
	e.preventDefault();
});
//마우스로 파일을 드롭할 때 파일이 열리는 기본 효과 막음
$(".fileDrop").on("drop", function(e) {
	e.preventDefault();
	//첫번째 첨부파일
	var files = e.originalEvent.dataTransfer.files;
	var file = files[0];
	//폼 데이터에 첨부파일 추가
	var formData = new FormData();
	formData.append("file", file);
	$.ajax({
		url : "${path}/reviews/uploadAjax.do",
		data : formData,
		dataType : "text",
		processData : false,
		contentType : false,
		type : "post",
		success : function(data,status,req) {
			$("#dragzone").html("");
			console.log("data : " + data);//업로된 파일 이름
			console.log("status : " + status);//성공,실패 여부
			console.log("req : " + req.status);//요청코드값
			//data : 업로드한 파일 정보와 Http 상태 코드
			var str="";
			var fileInfo = getFileInfo(data);
			if(checkImageType(data)){ //이미지 파일
				str="<div><a href='${path}/reviews/displayFile?fileName="
					+getImageLink(data)+"'>";
				str+="<img src='${path}/reviews/displayFile?fileName="
						+data+"' style='width:100px;height:auto;'></a>";	
			}else{//이미지가 아닌 경우
				str="<div>";
				str+="<a href='${path}/reviews/displayFile?fileName="
					+data+"'>"+getOriginalName(data)+"</a>";
			}
				str+="<span data-src="+data+" style='cursor:pointer;'>&nbsp;[<i class='fa-solid fa-trash'>삭제</i>]</span>";
				str+="<input type='hidden' class='file' value='"
					+fileInfo.fullName+"'></div>";
					console.log("fileName : "+fileInfo.fullName);
				$(".uploadedList").append(str);
				
		}
	});//end ajax
});//end filedrop
		
//첨부파일 삭제 함수
$(".uploadedList").on("click","span",function(event){//내부적으로 span태그가 클릭되면
	var that=$(this); //this는 현재 클릭한 태그, 즉 span태그
	$.ajax({
		url: "${path}/reviews/deleteFile",
		type: "post",
		data: {
			fileName: $(this).attr("data-src")
		},
		dataType: "text",
		success: function(result){
			if(result=="deleted"){
				that.parent("div").remove();//파일삭제되면 행전체<div>를 삭제처리
			}
		}
	});
});

//삭제 버튼
$("#btnDelete").click(function(){
	if(confirm("삭제하시겠습니까?")){
		document.form1.action="${path}/reviews/delete.do";
		document.form1.submit();
	}
});
});//end 첫번째 function
	
//첨부파일 리스트를 출력하는 함수
function listAttach(){
	$.ajax({
		type: "post",
		url: "${path}/reviews/getAttach/${dto.review_idx}",
		success: function(list){
			$(list).each(function(){
				var str="";
				var fileInfo=getFileInfo(this);
				if(checkImageType(this)){ //이미지 파일
					str="<div><a href='${path}/reviews/displayFile?fileName="
						+getImageLink(this)+"'>";
					str+="<img src='${path}/reviews/displayFile?fileName="
						+this+"' style='width:100px;height:auto;'></a>";	
				}else{//이미지가 아닌 경우
					str="<div>";
					str+="<a href='${path}/reviews/displayFile?fileName="
						+this+"'>"+getOriginalName(this)+"</a>";
				}
					str+="<span data-src="+this+" style='cursor:pointer;'>&nbsp;[<i class='fa-solid fa-trash'>삭제</i>]</span>";
					str+="<input type='hidden' class='file' value='"
						+fileInfo.fullName+"'></div>";
						console.log("fileName : "+fileInfo.fullName);
					$(".uploadedList").append(str);
					$("#dragzone").html("");
			});
		}
	});
}
	
</script>
<style type="text/css">
.titleB {
	margin-top: 10px;
	margin-bottom: 30px;
}

.star fieldset {
	display: inline-block;
	direction: rtl;
	border: 0;
	margin-bottom: 30px;
}

.star fieldset legend {
	text-align: right;
}

.star input[type=radio] {
	display: none;
}

.star label {
	font-size: 3em;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
}

.star label:hover {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

.star label:hover ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

.star input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
.star p{
	font-size: 20px;
}
.reviewText input, .roomsInfo input {
	display: block;
	width: 70%;
	min-width: 300px;
	margin-bottom: 10px;
	margin-top: 10px;
}

.reviewText textarea {
	width: 70%;
	min-width: 300px;
}

.btnSubmit {
	text-align: center;
	margin-top: 30px;
}

.btnSubmit2 {
	display: inline-block;
}

.fileDrop {
	width: 70%;
	min-width: 300px;
	height: 100px;
	border: 1px dotted lightgray;
	background-color: lightgray;
	margin-top: 10px;
}
#r_title {
	height: 50px;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
  <%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5" id="features">
			<div class="container rounded-3 py-5 px-4 px-md-5 mb-5"
				align="center">
				<p class="lead fw-normal text-muted mb-0">"당신의 경험을 공유하세요"</p>
				<h2 class="titleB fw-bolder">리뷰작성</h2>
				<form id="form1" name="form1" method="post"
					action="${path}/reviews/update.do">
					<input type="hidden" name="review_idx" value="${dto.review_idx}">
					<p class="lead fw-normal text-muted mb-0">${dto.name}님 숙소는 만족하셨나요?</p>
					<!-- <div>
						<input type="radio" name="room_idx" value="25" id="room_idx">룸idx값을 불러오기 위한 편법
					</div> -->
					<!-- 별점 -->
					<div class="container star">
						<p class="lead fw-normal text-muted mb-0">⭐내가 준 별점 <b>${dto.review_star}점</b></p>
						<fieldset>
							<input type="radio" name="review_star" value="5" id="rate1">
							<label for="rate1">★</label> 
							<input type="radio" name="review_star" value="4" id="rate2"> 
							<label for="rate2">★</label> 
							<input type="radio" name="review_star"	value="3" id="rate3"> 
							<label for="rate3">★</label> 
							<input type="radio" name="review_star" value="2" id="rate4"> 
							<label for="rate4">★</label> 
							<input type="radio" name="review_star" value="1" id="rate5"> 
							<label for="rate5">★</label>
						</fieldset>
					</div>
					<div class="container reviewText">
						<p class="lead fw-normal text-muted mb-0">어떤 점이 좋았나요?</p>
						<input name="r_title" id="r_title" value="${dto.r_title}">
						<textarea class="form-control" id="review_content" name="review_content">${dto.review_content}</textarea>
						<script>
							// ckeditor 적용
							CKEDITOR.replace('review_content', {
								width: '70%',
								filebrowserUploadUrl : "${path}/reviews/imageUpload.do"
							});
						</script>
					</div>
					<div>
						<div class="fileDrop" id="fileDrop">
							<div id="dragzone" align="center">리뷰 이미지파일을 드래그해서 등록해 주세요.</div>
							<div class="uploadedList"></div>
						</div>
					</div>
					<div class="btn btnSubmit">
						<!-- 삭제는 임시버튼 유저리뷰리스트 만들면 이동 -->
						<button class="btn btnSubmit2 btn-outline-warning" type="submit"
							id="btnUpdate">수정</button>
						<button class="btn btnSubmit2 btn-outline-warning" type="submit"
							id="btnDelete">삭제</button>
					</div>
				</form>

			</div>
		</section>
 </main>
 <!--footer  -->
 <%@ include file="../include/footer.jsp" %>

</body>
</html>