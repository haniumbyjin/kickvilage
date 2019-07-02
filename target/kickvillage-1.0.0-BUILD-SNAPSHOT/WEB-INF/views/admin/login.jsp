<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="/js/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	$(function(){
		  $('#submit').click(function (){
			  
			  if($('input[name=adminId]').val() == '') {
				  alert('아이디가 없음');
				  return false;
			  }
			  if($('input[name=adminPw]').val() == '') {
				  alert('비밀번호가 없음');
				  return false;
			  }
			  
			  $.ajax({
				  	url : '/admin/login',
					type : 'POST',
					data : $('#form').serialize(),
					dataType : 'JSON',
					success : function(data) {
						if (data.success != true) {
							if (data.error == "noId")  {
								alert('아이디가 비었습니다.');
							} else if (data.error == "noPw") {
								alert('비밀번호가 비었습니다..');
							} else if (data.error == "loginError") {
								alert('로그인 정보없음');
							}
						} else {
							alert('환영합니다.');
							location.href = data.url;
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
<form action="/manager/login" method="post" id="form">
	<div>
		<input type="text" name="adminId">아이디
	</div>
	<div>
		<input type="password" name="adminPw" >비밀번호
	</div>
	<div>
		<button type = "button" id="submit" >로그인</button>
	</div>
</form>
</body>
</html>