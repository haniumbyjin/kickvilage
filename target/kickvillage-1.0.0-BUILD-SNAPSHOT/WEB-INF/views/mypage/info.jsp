<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('#submit').click(function(){
			$.ajax({
				type : "POST",
				url : "/mypage/update",
				data : $('#form').serialize() ,
				datatype : "JSON",
				success : function(data) {
					if(data.error == "emptyUserPw"){
						alert("비밀번호를 입력해주세요");
					} else if(data.error == "wrongUserPw"){
						alert("비밀번호 형식에 맞춰서 입력해주세요");
					} else if(data.error == "reUserPw"){
						alert("똑같은 비밀번호를 입력해주세요.");
					} else if(data.error == "emptyUserName"){
						alert("이름을 입력해주세요");
					} else if(data.error == "wrongPhoneNum"){
						alert("전화번호 형식에 맞춰서 입력해주세요");
					} else if(data.error == "emptydriverLisence"){
						alert("운전면허 유무를 입력해주세요");
					}
				}, error : function(err){
					console.log(err)
				}
			});
		});
	});
</script>
<script>
	$(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "/mypage/userInfo",
			datatype : "JSON",
			success : function(data) {
				$('#userId').val(data.userId);
				$('#userName').val(data.userName);
				$('#phoneNum').val(data.phoneNum);
				$('#driverLisence').val(data.driverLisence);

			}, error : function(err){
				console.log(err)
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
			<a href="/mypage/info">내정보</a>
			<a href="/reserve/list">거래내역</a>
			<a href="/mypage/card">카드정보</a>
			<div>
				<div>
					${sessionScope.userId}
				</div>
			</div>
			<form id="form">
				<div>
					비밀번호 수정<input type="password" name="userPw" id="userPw" />
				</div>
				<div>
					<p class="userPwCk">비밀번호를 입력해주세요</p>
				</div>

				<div>
					수정 할 비밀번호 다시입력<input type="password" name="reUserPw" />
				</div>
				
				<div>
					<p class="reUserPwCk">비밀번호를 입력해주세요</p>

				</div>
				
				<div>
					 이름<input type="text" name="userName" id="userName" />
				</div>
				
				<div>
					<p class="phoneNumCk">이름을 입력해주세요</p>
				</div>
				<div>
					핸드폰번호<input type="text" name="phoneNum" id="phoneNum" />
				</div>
				<div>
					<p class="phoneNumCk">핸드폰번로를 입력해주세요</p>
				</div>

				<div>
					<select name="driverLisence" id="driverLisence">
						<option value="y">운전면허있음</option>
						<option value="n" selected="selected">운전면허없음</option>
					</select>
				</div>
			</form>
			<button id="submit">회원정보 수정</button>
		</c:otherwise>
	</c:choose>
</body>
</html>