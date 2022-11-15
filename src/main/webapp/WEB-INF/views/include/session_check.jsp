<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

	<c:if test="${param.msg == 'hasSessionGuest' }">
	 <script> 
	  alert("[게스트]로 로그인 되어 있습니다.");
	  history.back();
	 </script>
	</c:if>
	
	<c:if test="${param.msg == 'hasSessionHost' }">
	 <script> 
	  alert("[호스트]로 로그인 되어 있습니다.");
	  history.back();
	 </script>
	</c:if>
	
	<c:if test="${param.msg == 'noSessionGuest' }">
	 <script> 
	  alert("로그인이 필요합니다.");
	  location.href="${path}/guest/login.do";
	 </script>
	</c:if>
	
	<c:if test="${param.msg == 'noSessionHost' }">
	 <script> 
	 	alert("로그인이 필요합니다.");
	  location.href="${path}/host/login.do";
	 </script>
	</c:if>
	
	
	<!-- LoginInterceptor message -->
	<c:if test="${param.msg == 'nologin' }">
	 <script> 
	  alert("로그인이 필요합니다.");
	  location.href="${path}/"
	 </script>
	</c:if>