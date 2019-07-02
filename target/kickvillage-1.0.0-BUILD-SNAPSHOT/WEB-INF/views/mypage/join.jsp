<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 주소 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/joincheck.js" ></script>
</head>
<body>
	<form action="/mypage/userjoin" method="post" id="form">

		<div>
			아이디<input type="text" name="userId"  id="userId"  />
		</div>

		<div>
			<p class="userIdCk">아이디가 비었습니다.</p>
		</div>

		<div>
			<p> 비밀양식 : 최소 8자리에 숫자, 문자, 포함 20자리까지   </p>
		</div>

		<div>
			비밀번호<input type="password" id="userPw" name="userPw" />
		</div>

		<div>
			<p class="userPwCk">비밀번호를 입력해주세요 </p>
		</div>

		<div>
			비밀번호확인<input type="password" id="reUserPw" name="reUserPw" />
		</div>
		
		<div>
			<p class="reUserPwCk">같은 비밀번호를 입력해주세요</p>
		</div>
		
		<div>
			이름<input type="text" id="userName" name="userName" />
		</div>
		<div>
			<p class="userNameCk">이름을 입력해주세요</p>
		</div>
		<div>
			전화번호<input type="text" id="phoneNum" name="phoneNum" />
		</div>
		<div>
			<p class="phoneNumCk">전화번호를 입력해주세요</p>
		</div>
		
		<div>
			운전면허증유무
			<select name="driverLisence">
				<option value="y">있음</option>
				<option value="n" seleted="seleted">없음</option>
			</select>
		</div>
		
		<div>
			<button type="button"  id="submit">회원가입</button>
		</div>
	</form>
	
</body>
</html>