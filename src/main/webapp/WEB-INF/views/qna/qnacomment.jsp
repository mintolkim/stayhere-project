<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
//대댓글 창 보이기
function comment2(index){
	var submenu = $("#comment"+index);
	if("${sessionScope.userid != null || sessionScope.h_userid != null}"=="true"){
		if(submenu.is(":visible")) submenu.slideUp();
		  else submenu.slideDown();
	}else{
		if(confirm("로그인이 필요합니다. 로그인페이지로 이동하시겠습니까?")){
		location.href="${path}/guest/login.do";
		}else return;
	}
}
//대댓글 달기
function mykeydown2(index,comment_idx) {
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
	var qidx= $("#qidx"+index).val();
	var contents= $("#contents"+index).val();
		$.ajax({
			type: 'POST',
			dataType:'json',
			url: "${path }/qna/addcomment2.do",
			data:{
				"writer":writer,
				"q_idx":qidx,
				"contents":contents,
				"comment_idx":comment_idx
			},
			success: function(result){
				location.href="${path}/qna/qnadetail.do?q_idx="+result;
			}
		});
	}
}
//댓글삭제
function delcomment(idx,q_idx){
	if(confirm("댓글을 삭제하시겠습니까?")){
	$.ajax({
		type: 'POST',
		dataType:'json',
		url: "${path }/qna/delcomment.do",
		data:{
			"comment_idx":idx,
			"q_idx":q_idx
		},
		success: function(result){
			location.href="${path}/qna/qnadetail.do?q_idx="+result;
		}
	});
	}else{
		return;
	}
}
//댓글 채택
function selectcoment(idx){
	var q_idx ="${map.q_idx}";
	if(confirm("댓글을 채택하시겠습니까?")){
		$.ajax({
			type: 'POST',
			dataType:'json',
			url: "${path }/qna/selectcoment.do",
			data:{
				"comment_idx":idx,
				"q_idx":q_idx
			},
			success: function(result){
				location.href="${path}/qna/qnadetail.do?q_idx="+result;
			}
		});
		}else{
			return;
		}
}
</script>
<style type="text/css">
.comment{
display:none;}
</style>
</head>
<body>
 <!-- Comments section-->
	<section style="margin-top: 250px;">
		댓글 ${ map.count}개
		<div class="card bg-light" >
			<div class="card-body">
							<input type="hidden" id="qidx" name="q_idx" value="${map.q_idx }">
				<textarea class="form-control" id="contents" name="contents" rows="3"
								placeholder="코멘트를 남겨주세요!" onkeydown='mykeydown()'></textarea>
				<c:if test="${map.count > 0 }">
					<!-- Comment with nested comments-->
					<c:forEach var="co" items="${map.list }" varStatus="vs">
					 <c:if test="${co.re_level < 1 }">
					   <!-- 댓글 아이디 & 내용-->
						<div class="d-flex mb-4">
							<div class="flex-shrink-0 mt-3">
							 <c:if test="${co.profile_img == null }">
								<img class="rounded-circle"
									src="${path }/resources/images/guest.png"
									style="width: 50px; height: 50px;" />
							 </c:if>
							 <c:if test="${co.profile_img != null }">
								<img class="rounded-circle"
									src="${path }/imgUpload/${co.profile_img}"
									style="width: 50px; height: 50px;" />
							 </c:if>
							</div>
							<div class="ms-3" style="width:100%;">
								<div class="fw-bold mt-3">${co.writer }
								<c:if test="${co.choose == 'y'}">
								<span style="font-size:15px; color:#fab005;">
								&nbsp;<i class="fa-solid fa-circle-check"> 채택댓글</i></span></c:if>
								</div>
								<div class="fw-lighter" style="font-size:15px;">
								<fmt:formatDate value="${co.write_date }"
									pattern="M월 dd일, yyyy / HH:mm" />
								<span class="ms-3" onclick="comment2('${vs.index }');"
									 style="color: blue; font-size: 13px; cursor:pointer;">[댓글쓰기]</span>
								<c:if test="${co.writer == sessionScope.userid || co.writer == sessionScope.h_userid }">
								 <span class="ms-1"
									onclick="delcomment('${co.comment_idx}','${co.q_idx }');"
									style="cursor:pointer; font-size: 13px;">[댓글삭제]</span>
								</c:if>
								<c:if test="${co.userid == sessionScope.userid && co.choose == 'n'
								 || co.userid == sessionScope.h_userid && co.choose == 'n'}">
								 <span class="ms-1" onclick="selectcoment('${co.comment_idx}');"
									 style="color: #fab005; font-size: 13px; cursor:pointer; font-weight:bold;">[채택하기]</span>
								</c:if>
								</div> 
								<div class="mt-3" >${co.contents }</div>
								<!-- 댓글 쓰기 폼 -->
								<div class="comment mt-3" id="comment${vs.index }" >
									<input type="hidden" id="qidx${vs.index }" name="q_idx"
										value="${map.q_idx }">
									<textarea class="form-control" id="contents${vs.index }"
										name="contents" rows="3" placeholder="답글을 남겨주세요!" 
										onkeydown="mykeydown2('${vs.index }','${co.comment_idx }');"></textarea>
								</div>
							</div>
						</div>
						</c:if>
						<!-- 대 댓글 아이디 & 내용  -->
						<c:if test="${co.re_level >= 1 }">
							<div class="d-flex mt-3 ms-5">
								<div class="flex-shrink-0">
									<c:if test="${co.profile_img == null }">
										<img class="rounded-circle"
											src="${path }/resources/images/guest.png"
											style="width: 50px; height: 50px;" />
									</c:if>
									<c:if test="${co.profile_img != null }">
										<img class="rounded-circle"
											src="${path }/imgUpload/${co.profile_img}"
											style="width: 50px; height: 50px;" />
									</c:if>
								</div>
								<div class="ms-3">
									<div class="fw-bold ">${co.writer }
									<c:if test="${co.choose == 'y'}">
								<span style="font-size:15px; color:#fab005;">
								&nbsp;<i class="fa-solid fa-circle-check"> 채택댓글</i></span></c:if>
									</div>
								<div class="fw-lighter" style="font-size:15px;"><fmt:formatDate value="${co.write_date }"
									pattern="M월 dd일, yyyy / HH:mm" />
									<c:if test="${co.writer == sessionScope.userid || co.writer == sessionScope.h_userid }">
								 <span class="ms-1"
									onclick="delcomment('${co.comment_idx}','${co.q_idx }');"
									style="cursor:pointer; font-size: 13px;">
									[댓글삭제]</span>
								</c:if>
								 <c:if test="${co.userid == sessionScope.userid && co.choose == 'n' || co.userid == sessionScope.h_userid && co.choose == 'n'}">
								 <span class="ms-1" 
								 onclick="selectcoment('${co.comment_idx}');"
									 style="color: #fab005; font-size: 13px; cursor:pointer; font-weight:bold;">
									 [채택하기]</span>
								</c:if>   
								</div>
								<div class="mt-3" >${co.contents }</div>
								</div>
								</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</section>
</body>
</html>