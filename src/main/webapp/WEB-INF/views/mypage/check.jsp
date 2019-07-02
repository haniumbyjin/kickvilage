<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script language="javascript" src="/js/mypageCheck.js"></script>
<style type="text/css">
body {
	background: #f2faff;
}
#content {
	width:1200px;
	margin:0 auto;
	position: relative;
	text-align: center;
}
h1 {
	text-align: center;
	margin: 150px 0 100px 0;
}
#userPw {
	width:600px;
	margin: 0 auto;
	height:20px;
	padding: 5px 10px 5px 10px; 
}
.password {
	position: relative;
	display: grid;
	grid-template-columns: 1fr 824px 1fr;  
	margin: 16px 0 0 0;
}
    #userPw {
        width:200px;
        height: 40px;
        border: 1px solid #666;
        font-size: 16pt;
        text-align: center;
        letter-spacing: 10px;
        transition: 0.2s;
        background-image: url(../img/pw.png);
        background-repeat: no-repeat;
        background-position: 20px center;
    }
    #userPw:hover {
        border: 1px solid #10a3e6;
        outline: none;
        transition: 0.2s;
}
    #userPw:focus {;
        border: 1px solid #6844ff;
        outline: none;
        transition: 0.2s;
}
    .submitPassword {
        display: grid;
        grid-template-columns: 624px 200px;
    }
    #submit {
        width: 150px;
        height: 50px;
        outline: none;
        background: #10a3e6;
        border: 0px;
        cursor: pointer;
        color: white;
        font-size: 12pt;
        transition: 0.2s;
    }
    #submit:hover {
        background: #6844ff;
        transition: 0.2s;
    }
    #submit:active {
        background: #6844ff;
        transition: 0.2s;
    }
    footer {
    position: absolute;
    bottom: 0px;
    }
    #userPw {
		width:600px; 
		height: 40px;
	}
@media all and (max-width:1024px) {
	#content {
	width:90%;
	padding: 0 5%;
	}
	footer {
	display:none;
	}
	.password {
		width:100%;
		display: block;
	}
	.submitPassword {
	 display: block;
	 width:100%;
	 margin: 0px;
	}
	#userPw {
		width:90%;
		font-size: 10pt;
		letter-spacing: 2px;
	}
	#submit {
		margin-top:30px;
		width:60%;
		
	}
}
</style>
</head>
<body>
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
<div id="content">
	<h1>비밀번호 재확인</h1>
	회원정보수정과 결재 관련 사항으로 인해 비밀번호 재인증을 해야합니다.
	<div id="form">
	<div class="password">
		<div></div>
        <div class="submitPassword">
            <div>
		    <input type="password" id="userPw" name="userPw" maxlength="20"/>
		    </div>
		    <div>
		    <button id="submit">확인</button>
		    </div>
		</div>
		<div></div>
	</div>
	</div>
</div>
<jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
</body>
</html>