<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<script src="/js/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	$(function(){
		  $('#submit').click(function (){
			  $.ajax({
				  	url : '/mypage/login',
					type : 'POST',
					data : $('#form').serialize(),
					dataType : 'JSON',
					success : function(data) {
						if (data.success != true) {
							if (data.error == "noUserId")  {
								alert('아이디가 비었습니다.');
							} else if (data.error == "noUserPw") {
								alert('비밀번호가 비었습니다..');
							} else if (data.error == "loginError") {
								alert('로그인 정보없음');
							}
						} else {
							alert('환영합니다.');
							location.href = "/";
						}
					},
					error : function(err) {
						console.log(err);
				}
			  });
		  });
		});
});
</script>
</head>
<body>
<div>${sessionScope.userName}</div>
		<c:choose>
			<c:when test="${sessionScope.userId eq null and sessionScope.userPw eq null}">
				<form action="/login" method="post" id="form">
					<div>
						<input type="text" name="userId">아이디
					</div>
					<div>
						<input type="password" name="userPw" >비밀번호
					</div>
					<div>
						<button type = "button" id="submit" >로그인</button>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<li><a href="logout">로그아웃</a></li>
			</c:otherwise>
		</c:choose>
</body>
</html>