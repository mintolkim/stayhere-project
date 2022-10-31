<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 헤더에 공통 스크립트 또는 스타일시트 추가하기 -->
<%@ include file="../include/header.jsp"%>
<!-- 그외 페이지별 들어갈 script & css 추가 영역  start-->

<!-- 그외 페이지별 들어갈 script & css 추가 영역 end -->
<title>wishlist</title>

</head>
<body class="d-flex flex-column">
	<!-- nav_search_bar 는 검색창 노출화면 -->
	<!-- 폴더를 만들어서 적용할시 ../ 으로 변경 -->
<%-- 	<%@ include file="./include/nav_search_bar.jsp"%> --%>
	<%@ include file="../include/navbar.jsp"%>
	<!-- 컨텐츠 수정 영역 start -->
	<h2>WishList</h2>
	
	
	<c:when test="${map.count == 0}">
		<h4>추가한 관심 스테이가 없습니다.</h4>
	</c:when>
	<c:otherwise>
		<c:forEach var="row" items="${map.list}">
			<div>
				<a><img alt="" src="${path}/{dto.room_idx}"></a>
			</div>
		</c:forEach>
	</c:otherwise>
	
<script>
	function wishChange(bu_email, pic_num) {
		let likeCheck = document.getElementById(pic_num);
		let url;
		let msg;
		let heart;
		if(likeCheck.innerHTML.trim() == 'favorite_border'){
			url = '${pageContext.request.contextPath}/wish/insert'
			msg = '이 숙소를 찜했습니다'
			heart = 'favorite'
		} else {
			url = '${pageContext.request.contextPath}/wish/delete'
			msg = '찜을 취소했습니다'
			heart = 'favorite_border'
		}
		$.ajax({
			type:'POST',
			url:url,
			header:{"Content-Type":"application/json"},
			dateType:'json',
			data:{bu_email:bu_email},
			success : function(result){
				if(result == true){
				} else {
					likeCheck.innerHTML = heart;
					openToast(msg)
				}
			}
		})
	}
</script>	
	
	<!-- 컨텐츠 수정 영역 end -->
	
	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>