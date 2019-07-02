<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<script src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

			function submitForm() {
				$.ajax({
					url : '/mypage/login',
					type : 'POST',
					data : $('#form').serialize(),
					dataType : 'JSON',
					success : function(data) {
						if (data.success != true) {
							if (data.error == "noUserId") {
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
			};
	

	
	function press(f){ 
		var keycode = event.keyCode;
		if(keycode == 13){ //javascript에서는 13이 enter키를 의미함 
			console.log("로그인 실행 중입니다! 개발자 여러분들은 콘솔을 켜도 의미가 없어요!");
			submitForm(); //formname에 사용자가 지정한 form의 name입력 
			
		} 
		
	}

</script>
</head>
<link rel="stylesheet" type="text/css" href="/css/login.css" />
<style>

</style>
<body onselectstart="return false" ondragstart="return false">

<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	<div id="content">
		<div id="content_login_put">
			<h1>로그인</h1>
			<P>로그인을 위하여 아래 아이디의 비밀번호를 입력해 주세요.</P>

		</div>
		<c:choose>
			<c:when
				test="${sessionScope.userId eq null and sessionScope.userPw eq null}">
				<form action="/login" method="post" id="form" name="form" >
					<div id="id_ping">
						<input type="text" id="id" autocomplete="off" placeholder="아이디"
							name="userId" onkeypress="press(this.form)">
					</div>
					<div id="id_pw">
						<input type="password" id="pw" autocomplete="off" placeholder="비밀번호"
							name="userPw" onkeypress="press(this.form)">
					</div>
					<div id="get">
						<button type="button" id="submit" title="submit" onclick="submitForm()">로그인</button>
					</div>
					<div ID="join_content">
           				<span> 
           					<a href="/mypage/join">회원가입</a></span>
           				<span> | </span>
           				<span> 
           					<a href="/mypage/find">아이디 / 비밀번호찾기</a>
           				</span>
       </div>
				</form>
			</c:when>
			<c:otherwise>
				<li><a href="logout">로그아웃</a></li>
			</c:otherwise>
		</c:choose>


	</div>
<jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
</body>
</html>