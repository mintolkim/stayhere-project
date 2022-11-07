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
//댓글삭제
function delComment(review_idx, comment_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : "${path}/reviews/delComment.do",
			data : {
				"review_idx" : review_idx,
				"comment_idx" : comment_idx
			},
			success : function(result) {
				location.href = "${path}/reviews/detail.do?review_idx="+ result;
			}
		});
	} else {
		return;
	}
}
</script>
<style type="text/css">
.box1{
	width: 100%;
}
</style>
</head>
<body class="d-flex flex-column h-100">

	<section class="py-5" id="features box1">
		<div class="container px-5 my-5">
			<!-- 리뷰댓글 -->
			<section>
				댓글 ${map.count}개
				<div class="card bg-light">
					<div class="card-body">
						<input type="hidden" id="reComment_idx" name="review_idx"
							value="${map.review_idx}">
						<textarea class="form-control" id="contents" name="contents"
							rows="3" placeholder="코멘트를 남겨주세요!" onkeydown='mykeydown()'></textarea>
						<c:if test="${map.count > 0}">
						<!-- Comment with nested comments-->
						<c:forEach var="co" items="${map.list}" varStatus="vs">
							<c:if test="${co.re_level < 1}">
								<!-- 댓글 아이디 & 내용-->
								<div class="d-flex mb-4">
									<div class="flex-shrink-0 mt-3">
										<c:if test="${co.profile_img != null }">
											<img class="rounded-circle"
												src="${path}/resources/images/${co.profile_img}"
												style="width: 50px; height: 50px;" />
										</c:if>
										<c:if test="${co.h_profile_img != null }">
											<img class="rounded-circle"
												src="${path}/resources/images/${co.h_profile_img}"
												style="width: 50px; height: 50px;" />
										</c:if>
									</div>
									<div class="ms-3" style="width: 100%;">
										<div class="fw-bold mt-3">${co.writer}</div>
										<div class="fw-lighter" style="font-size: 15px;">
											<fmt:formatDate value="${co.write_date}"
												pattern="M월 dd일, yyyy / HH:mm" />
											<c:if
												test="${co.writer == sessionScope.userid || co.writer == sessionScope.h_userid }">
												<span class="ms-1"
													onclick="delComment('${co.review_idx}','${co.comment_idx}');"
													style="cursor: pointer; font-size: 13px;">[댓글삭제]</span>
											</c:if>
										</div>
										<div class="mt-3">${co.contents}</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</c:if>
					</div>
				</div>
			</section>

		</div>
	</section>

</body>
</html>