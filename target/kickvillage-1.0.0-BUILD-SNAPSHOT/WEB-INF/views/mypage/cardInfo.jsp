<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function(){
			$.ajax({
				url : 'mypage/userInfo',
				type : 'POST',
				cache : false,
				datatype : 'JSON',
				success : function(data){
				
				}, error : function(err){
					console.log(err)
				}
			}
		});
	});
</script>
</head>
<body>
		<c:choose>
			<c:when test="${sessionScope.reUserPw eq null }">
			<h1>권한이 없습니다.</h1>
			</c:when>
			<c:otherwise>
			<a href="myPage/">
		
				<div>
				아이디<input type="text" name="userId" id="userId" />
				</div>
				<form id="form">
				<div>
				비밀번호 수정<input type="password" name="userPw" id="userPw"/>
				</div>
				<div>
					<p class="userPwCk">비밀번호를 입력해주세요</p>
				</div>
				<div>
					<p class="reUserPwCk">비밀번호를 다시 입력해주세요</p>
				</div>
				<div>
				이름<input type="text" name="userName" id="userNmae" />
				</div>
				<div>
					핸드폰번호 <input type="password" name="phoneNum" id="phoneNum"  />
				</div>	
				<div>
					운전면허유무<input type="password" name="driverLisence" id="driverLisence"  />
				</div>
	
				</form>
				<button id= "submit">회원정보 수정</button>
			</c:otherwise>
		</c:choose>
</body>
</html>