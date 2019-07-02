<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<c:choose>
			<c:when test="${sessionScope.admin eq null}">
				<a href="/admin/login">로그인</a>
				<!-- 관리자 회원가입은 일부러 링크를 남겨두지 않는다. 주소로 직접 들어올 것! -->
			</c:when>
			<c:otherwise>
				<h1>${sessionScope.admin}사마</h1>
				<ul>
					<li><a href="/admin/station">정류소 관리</a></li>
					<li><a href="/admin/kickboard">킥보드 관리</a></li>
					<li><a href="/admin/logout">로그아웃</a></li>
				</ul>
			</c:otherwise>
		</c:choose>
</body>
</html>