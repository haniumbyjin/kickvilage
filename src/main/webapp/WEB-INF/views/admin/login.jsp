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
<style>
    html,body {
    margin: 0px;
    height:100%;
    width: 100%;
    display: block;
    overflow: hidden;
}
#content {
    width: 1200px;
    height: 590px;
    margin: 0 auto;
}
#content_login_put {
    width:1200px;
    height: 120px;
    padding: 130px 0 0 0;
}
#content_login_put h1 {
}
#content_login_put h1,p{
    font-family: 'NotoSansCJKkr-Regular';
    text-align: center;
}
#id_ping {
    width:500px;
    height: 50px;
    margin: 0 auto;
}
#id_pw{
    width:500px;
    height: 50px;
    margin: 0 auto;
    margin-top: 20px;
    margin-bottom: 50px;
}
#id {
    width: 420px;
    height: 50px;
    margin: 0 auto;
    padding: 0 20px 0 60px;
    border: 1px solid #cdcdcd;
    font-size: 12pt;
    background-image: url(../img/id.png);
    background-repeat: no-repeat;
    background-position: 20px center;
    border-radius: 3px;
}
#id {
        background-repeat: no-repeat;
    background-position: 20px center;
    border-radius: 3px;
}
#id:focus {
    background-size: 30px;
    background-position: 10px center;
    transition: 0.5s;
    border: 1px solid #6844ff !important;
}
#id:hover {
    border: 1px solid #10a3e6;
    transition: 0.5s;
}
#pw {
    width: 420px;
    height: 50px;
    margin: 0 auto;
    padding: 0 20px 0 60px;
    border: 1px solid #cdcdcd;
    font-size: 12pt;
    background-image: url(../img/pw.png);
    background-repeat: no-repeat;
    background-position: 20px center;
    
    
}
#pw:focus {
        background-size: 30px;
    background-position: 10px center;
    border: 1px solid #6844ff !important;
    transition: 0.5s;
}
#pw:hover {
     border: 1px solid #10a3e6;
    transition: 0.5s;
}
input:focus { outline: none; }
#get {
    width: 500px;
    height: 50px;
    background-color: #2f7ffa;
    color: white;
    font-size: 14pt;
    margin: 0 auto;
    text-align: center;
}
#get:hover {
    background-color: #6844ff;
    transition: 0.2s;
}
button {
    background: none;
    border: none;
    color: white;
    font-size: 14pt;
    width: 500px;
    height: 100%;
    padding-top: 5px;
    cursor: pointer;
}
footer{
    width: 100%;
    height: 100%;
    background-color: #f5f5f5;
}
#footer_ping {
    width:1200px;
    height: 100px;
    padding: 15px;
    margin: 0 auto;
    
}
#footer_eunhasu {
}
#footer_a {
    height: 40px;
    width: 1200px;
    border-bottom: 1px solid #e1e1e1;
    font-size: 10pt;
    color: #585858;
    margin-bottom: 15px
}
.eunhasu {
    color : #878787;
    font-size: 10pt;
    margin-top: 15px;
}
#join_content{
    width: 500px;
    height: 50px;
    margin: 0 auto;
    text-align: right;
    font-family: 'NotoSansCJKkr-Regular';
    font-size: 8pt;
    padding: 5px 0 0 0;
}
@media all and (max-width:1024px) {
	#content, #content_login_put {
		width:100%;
	}
	#content_login_put {
		height: auto;
	}
	#content_login_put p {
		margin: 25px 35px;
	}
	#id_ping, #id_pw, #get {
		width:90%;
	}
	#id, #pw {
		padding: 0;
		padding-left:17%;
		width: 83%;
	}
	#submit {
		width:100%;
	}
	#join_content {
		width: 90% !important;
    	padding: 10px 5% !important;
	}
	footer {
		display: none;
	}
}
</style>
<body>
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
<!-- <form action="/manager/login" method="post" id="form">
	<div>
		<input type="text" name="adminId">아이디
	</div>
	<div>
		<input type="password" name="adminPw" >비밀번호
	</div>
	<div>
		<button type = "button" id="submit" >로그인</button>
	</div>
</form> -->
<div id="content">
		<div id="content_login_put">
			<h1>관리자 로그인</h1>
			<P>관리자 계정이 접속 가능한 곳입니다.</P>

		</div>
				<form action="/manager/login" method="post" id="form" name="form" >
					<div id="id_ping">
						<input type="text" id="id" autocomplete="off" placeholder="아이디"
							name="adminId" onkeypress="press(this.form)">
					</div>
					<div id="id_pw">
						<input type="password" id="pw" autocomplete="off" placeholder="비밀번호"
							name="adminPw" onkeypress="press(this.form)">
					</div>
					<div id="get">
						<button type="button" id="submit" title="submit" onclick="submitForm()">로그인</button>
					</div>
					<div ID="join_content">
           				<span> 
           					<a href="/admin/join">회원가입</a></span>
           				<span> | </span>
           				<span> 
           					<a href="/mypage/login">아이디 / 비밀번호찾기</a>
           				</span>
       				</div>
				</form>

	</div>
<jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
</body>
</html>