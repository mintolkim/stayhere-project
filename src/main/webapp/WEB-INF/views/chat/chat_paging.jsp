<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<nav class="d-flex justify-content-center my-2"
	aria-label="Search results pages">
	<ul class="pagination">
		<c:choose>
			<c:when test="${map.pager.curPage > 1}">
				<li class="page-item"><a class="page-link" href="#"
					aria-label="Previous" onclick="pagination('${map.pager.prevPage}')">
						<span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item disabled"><a class="page-link" href="#"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>
		<c:forEach var="num" begin="${map.pager.blockBegin}"
			end="${map.pager.blockEnd}">
			<c:choose>
				<c:when test="${num == map.pager.curPage}">
					<li class="page-item active" aria-current="page"><a
						class="page-link">${num}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="#"
						onclick="pagination('${num}')">${num}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${map.pager.curPage < map.pager.totPage}">
				<li class="page-item"><a class="page-link" href="#"
					aria-label="Next" onclick="pagination('${map.pager.nextPage}')">
						<span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item disabled"><a class="page-link" href="#"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</nav>
<!-- 페이지 네이션 끝 -->