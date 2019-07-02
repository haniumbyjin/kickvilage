<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
</head>
<body>
	<form action="/admin/join" method="post" id="form">

		<div>
			아이디<input type="text" name="adminId"  id="adminId"  />
		</div>

		<div>
			비밀번호<input type="password" id="adminPw" name="adminPw" />
		</div>
		<div>
			<button type="submit"  id="submit">회원가입</button>
		</div>
	</form>
	
</body>
</html>