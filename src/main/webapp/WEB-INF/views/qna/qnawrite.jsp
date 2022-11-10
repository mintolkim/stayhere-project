<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STAYHERE</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript" src="${path }/resources/ckeditor/ckeditor.js"></script>
<style type="text/css">
#write{
margin-top: 30px;
border-collapse:collapse;
border-top: 1px solid #ffca2c;
}
#write th{
width: 20%;
border-bottom: 1px solid #ffca2c;
padding: 10px;
background: #ffeed0;
text-align: center;}
#write input[type="text"],input[type="password"]{
border: 2px solid #e8e8e8;
padding: 5px;
border-radius: 10px;}
#write td{
padding: 10px;
border-bottom: 1px solid #ffca2c;}
#writeInsert{
width: 80px;
border: 1px solid #ffca2c;
border-radius: 5px;
padding: 3px;}
.fileDrop {
width: 100%;
border: 2px dashed #d1d1d1;
background-color: #f8f8f8;
border-radius: 20px;
padding: 30px;
font-size: 14px;
color: #848484;
}
</style>
<script>
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
$(function(){
	$("#btnSave").click(function(){
		var str="";
   //uploadedList 영역에 클래스이름이 file인 히든타입의태그를 각각 반복
		$(".uploadedList .file").each(function(i){
			console.log(i);
			//hidden 태그 구성
			str += "<input type='hidden' name='files["+i+"]' value='"+ $(this).val()+"'>";
		});
		//폼에 hidden 태그들을 붙임
		$("#form1").append(str);
		document.form1.submit();
	});	
$(".fileDrop").on("dragenter dragover",function(e){
	//기본 효과 막음
	e.preventDefault();
});
$(".fileDrop").on("drop",function(e){
	e.preventDefault();
	//첫번째 첨부파일
	var files=e.originalEvent.dataTransfer.files;
	var file=files[0];
	//폼 데이터에 첨부파일 추가
	var formData=new FormData();
	formData.append("file",file);
	$.ajax({
		url: "${path}/qna/uploadAjax.do",
		data: formData,
		dataType: "text",
		processData: false,
		contentType: false,
		type: "post",
		success: function(data,status,req){
			$("#dragzone").html("");
			console.log("data : " + data);//업로된 파일 이름
			console.log("status : " + status);//성공,실패 여부
			console.log("req : " + req.status);//요청코드값
			var str="";
			var fileInfo=getFileInfo(data);
			if(checkImageType(data)){ //이미지 파일
				str="<div><a href='${path}/qna/displayFile?fileName="
					+getImageLink(data)+"'>";
				str+="<img src='${path}/qna/displayFile?fileName="
					+data+"' style='width:70px;height:70px;'></a>";	
			}else{//이미지가 아닌 경우
				str="<div>";
				str+="<a href='${path}/qna/displayFile?fileName="
					+data+"'>"+getOriginalName(data)+"</a>";
			}
				str+="<span data-src="+data+" style='cursor:pointer;'>&nbsp;[<i class='bi bi-trash-fill'></i> 삭제]</span>";
				str+="<input type='hidden' class='file' value='"
					+fileInfo.fullName+"'></div>";
					console.log("fileName : "+fileInfo.fullName);
				$(".uploadedList").append(str);
				
		}
	});
});

//첨부파일 삭제 함수
$(".uploadedList").on("click","span",function(event){//내부적으로 span태그가 클릭되면
	var that=$(this); //this는 현재 클릭한 태그, 즉 span태그
	$.ajax({
		url: "${path}/qna/deleteFile",
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

});

</script>
</head>
<body>
 <%@ include file="../include/navbar.jsp"%>
  <!-- content -->
  <section class="py-5">
  <div class="container px-4 px-lg-5 mt-5">
   <div class="justify-content-center flex-sm-column d-sm-flex align-items-center">
   <h2 class="fw-bold" style="font-size: 40px;">Q&A</h2>
   <h2 class="fw-light " style="font-size: 18px; margin-top: 20px;">Q&A 글작성 게시판입니다</h2></div>
    <!-- 게시판 글쓰기 -->
    <form id="form1" name="form1" action="${path }/qna/insert.do" method="post">
    <table id="write" style="width:100%;">
     <tr>
     <th>제목</th>
     <td>
     <input type="text" id="subject" name="subject" style="width:100%;"></td>
     </tr>
     <tr>
     <th>카테고리</th>
     <td><select class="form-select" id="category" name="category">
      <option value="결제문의">결제문의</option>
      <option value="예약문의">예약문의</option>
      <option value="숙소문의">숙소문의</option>
      <option value="기타">기타</option>
     </select></td>
     </tr>
     <tr>
     <td colspan="2">
       <textarea class="form-control" rows="20" id="ckeditor" name="contents"></textarea>
       <script>
         CKEDITOR.replace('ckeditor',{
        	width: '100%',
         	height: '400px',
         	filebrowserUploadUrl:"${path}/qna/fileupload.do"
         });
       </script>
	  </td>
     <tr>
     <tr>
     <th>첨부파일</th>
     <td>
		<div class="fileDrop" id="fileDrop">
			<div id="dragzone" align="center"><i class="bi bi-plus-circle"></i> 파일을 드래그해서 추가해주세요.</div>
		<div class="uploadedList"></div>
		</div>
	</td>
     </tr>
     <tr>
     <th>비밀글 설정</th>
     <td><input type="password" name="passwd" id="passwd"> </td>
     </tr>
    </table>
     <div align="right" style="margin-top:20px;">
     <button type="button"  id="btnSave" style="display:inline-block;font-weight: bold;" 
				class="btn btn-warning">작성하기</button>
    </div>
     </form>
    </div>
    </section>
    <!-- footer -->
     <footer>
  <%@ include file="../include/footer.jsp"%>
  </footer>

</body>
</html>