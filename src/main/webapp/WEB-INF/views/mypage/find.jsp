<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shourtcut icon" href="${path}/mypage/find">
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<title>비밀번호,아이디 찾기</title>

<script type="text/javascript">
	$(document).ready(function() {
		$('#findPw').on('click', function() {
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : '/mypage/findPw',
				data : {
					"receiver" : $('#PwReceiver').val(),
					"userId" : $('#userId').val()
				},
				success : function(data) {
					if (data.result == "noUserId") {
						alert('아이디를 입력해주세요');
					} else if (data.result == "noSearchId") {
						alert('아이디를 찾을 수 없습니다.');
					} else if (data.result == "success") {
						alert('이메일전송 성공');
						location.href = "/mypage/login";
					} else if (data.result == "emailError") {
						alert('이메일전송 실패');
					} else {
						alert('데이터베이스 오류 ');
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});

		$('#findId').on('click', function() {
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : '/mypage/findId',
				data : {
					"userName" : $('#userName').val(),
					"phoneNum" : $('#phoneNum').val(),
					"receiver" : $('#IdReceiver').val()
				},
				success : function(data) {
					if (data.result == "noUserName") {
						alert('아이디를 입력해주세요');
					} else if (data.result == "wrongEmail") {
						alert('이름형식이 맞지않습니다.');
					} else if (data.result == "noPhoneNum") {
						alert('핸드폰번호를 입력해주세요');
					} else if (data.result == "wrongPhoneNum") {
						alert('전화번호 형식에 맞지 않습니다.');
					} else if (data.result == "nonexistent") {
						alert('회원정보가 없습니다.');
					} else if (data.result == "success") {
						alert('이메일전송 성공');
						location.href = "/mypage/login";
					} else if (data.result == "emailError") {
						alert('이메일전송 실패');
					} else {
						alert('데이터베이스 오류 ');
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
	});
</script>
</head>
<style>
body {
	background: #f2faff;
}
#pawIdPosition {
	width:1200px;
	margin: 0 auto;
	display: grid;
    grid-template-columns: 600px 600px;
    font-family: "NanumSquare";
	position: relative;
	top:200px;
}
#idSearch, #pwSearch {
	height: 300px;
	border: 1px solid #bbb;
	padding: 20px;
    position: relative;
} 
.position {
	display: grid;
	grid-template-columns: 120px 400px;
	grid-gap: 20px;
    margin: 10px;
    line-height: 30px;
    position: relative;
}
.position input{
        height: 20px;
        width: 330px;
        padding: 5px 10px;
        border: 1px solid #999;
    }
    .position input:hover {
        outline: none;
        border: 1px solid #10a3e6;
        transition: 0.4s;
    } 
    .position input:focus {
        outline: none;
        border: 1px solid #6844ff;
        transition: 0.4s;
    } 
#findId, #findPw {
        height: 50px;
        width:100px;
        position: absolute;
        bottom: 30px;
        left: 50%;
        transform: translate(-50%, 0 );
        background-color: #10a3e6;
        border: 0px;
        color: #fff;
        transition: 0.4s;
        cursor: pointer;
    }
#findId:hover {
    background-color: #6844ff;
    border: 0px;
    transition: 0.4s;
    }
#findPw:hover {
    background-color: #6844ff;
    border: 0px;
    transition: 0.4s;
    }
    #idSearch {
        border-right: 0px;
    }
    footer {
    position: absolute;
    bottom: 0px;
    }
@media all and (max-width:1024px) {
body {
	overflow-y:scroll !important;
	overflow-x:hidden; 
}
#header_ping {
    	position: fixed;
    	top:0px;
}
	footer {
		display: none;
	}
	#pawIdPosition {
		width:100%;
		display:block;
	}
	.position {
		    grid-template-columns: 100%;
	}
	.position input{
	    width: 90%;
	    padding: 1% 5%;
}
	#idSearch {
	height: 450px;
	border-right: 1px solid #bbb;
	}
	#pawIdPosition {
	top: 60px;
	}
	#pwSearch {
	height: 380px;
	}
}
</style>
<body>
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	<div id="pawIdPosition">
	<div id="idSearch">
	<h1>아이디 찾기</h1>
	<div>
		<div id="idName" class="position">
			<span>이름</span><span><input id="userName" name="userName" /></span>
		</div>
		<div id="idNumber" class="position">
			핸드폰 번호<input id="phoneNum" name="phoneNum" />
		</div>
		<div id="idEmail" class="position">
			이메일<input id="IdReceiver" name="receiver" />
		</div>
	</div>
	<button id="findId">확인</button>
	</div>
	<div id="pwSearch">
	<h1>비밀번호 찾기</h1>
	
	<div>
		<div id="pwId" class="position">
			아이디<input id="userId" name="userId" />
		</div>
		<div id="pwEmail" class="position">
			이메일<input id="PwReceiver" name="receiver" />
		</div>
	</div>
	<button id="findPw">확인</button>
	</div>
	</div>
	<jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
</body></html>