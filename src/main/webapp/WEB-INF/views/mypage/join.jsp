<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/joincheck.js" ></script>
<link rel="stylesheet" type="text/css" href="/css/join.css">
</head>
<body  onselectstart="return false" ondragstart="return false">
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	    <div id="signUpLogo">
        <img src="../img/logoSignUp.png">
    </div>
	<form action="/mypage/userjoin" method="post" id="form">

		<div class="signUp_P signDiv">아이디</div>
		<div class="signDiv signInput">
			<input type="text" name="userId" id="userId" autocomplete="off">
		</div>
		<div class="signUp_P signDiv"></div>
		
		<div class="signUp_P signDiv">비밀번호</div>
		<div class="signDiv signInput">
			<input type="password" id="userPw" name="userPw">
		</div>
		<div class="signUp_P signDiv"></div>
		<div class="signUp_P signDiv">비밀번호 확인</div>
		<div class="signDiv signInput">
			<input type="password" id="reUserPw" name="reUserPw" autocomplete="off"/>
		</div>
		<div class="signUp_P signDiv"></div>

		<div class="signUp_P signDiv">이름</div>
		<div class="signDiv signInput">
			<input type="text" id="userName" name="userName" autocomplete="off"/>
		</div>
		<div class="signUp_P signDiv"></div>
		
		<div class="signUp_P signDiv">핸드폰</div>
		<div class="signDiv signInput">
			<input type="text" id="phoneNum" name="phoneNum" autocomplete="off" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</div>
		<div class="signUp_P signDiv"></div>
		<div class="signDiv signInput">
			<button type="button"  id="submit" class="signUp_P signDiv" style="margin-bottom: 30px;">회원가입</button>
		</div>
	</form>
	
</body>
</html>