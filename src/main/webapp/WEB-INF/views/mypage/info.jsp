<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/mypage.css" />
<script>
	$(document).ready(function() {
		$('#bottomSubmit').click(function(){
			$.ajax({
				type : "POST",
				url : "/mypage/info",
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
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	<header> </header>
	<c:choose>
		<c:when test="${sessionScope.reUserPw eq null }">
			<h1>권한이 없습니다.</h1>
		</c:when>
		<c:otherwise>
			<div id="contentJoin">
				<div id="contentJoinSelect" class="container"
					data-animation="ripple">
					<div class="JoinSelect" style="background: #fff; color: #10a3e6;"
						id="updateSelect">회원정보관리</div>
					<div class="JoinSelect" id="reservationcheck">예약/대여 내역</div>
					<div class="JoinSelect" id="paymentManagement">결제관리</div>
				</div>
					<div id="passwordPassAlert">
						<div id="passwordContentsPing">
							<div id="passwordContents">비밀번호는 영어와 숫자를 섞어주세요.</div>
							<div id="contentsBottom"></div>
						</div>
					</div>
					<div id="repasswordPassAlert">
						<div id="repasswordContentsPing">
							<div id="repasswordContents">비밀번호를 다시 입력해주세요</div>
							<div id="recontentsBottom"></div>
						</div>
					</div>
					<div id="JoinSelectOne" style="display: block;">
						<table class="tableContent">
							<tr>
								<th>아이디</th>
								<th width="50px"></th>
								<th><input type="text" readonly
									value="${sessionScope.userId}"></th>
							</tr>
							<form id="form">
								<tr>
									<th>비밀번호</th>
									<th width="20px"></th>
									<th><input type="password" id="password" name="userPw"></th>
								</tr>
								<tr>
									<th>비밀번호확인</th>
									<th width="20px"></th>
									<th><input type="password" id="passwordCheck" ></th>
								</tr>
								<tr>
									<th>이름</th>
									<th width="20px"></th>
									<th><input type="text" name="userName"></th>
								</tr>
								<tr>
									<th>핸드폰</th>
									<th width="20px"></th>
									<th>
										<input type="text" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
												maxlength="11" size="20" name="phoneNum"/>
									</th>
								</tr>
								
							</form>
						</table>
						<div id="bottomSubmit">
							<button type="submit">수정완료</button>
						</div>
					</div>
					<div id="reservationTab" style="display: none;" style="margin-top: 90px;">
						<div id="reservePosition">
							
						</div>
					</div>
					<div id="cardPayment" style="display: none;">
						<div id="cardPaymentTitle">결제수단 관리</div>
						<div id="cardIndex">
							<div class="cardPing">
								<img src="/img/1-12.png">
								<div class="paymentMethod">
									<button class="select"></button>
									<button></button>
								</div>
							</div>
							<div class="cardPing">
								<img src="/img/cardToss.png">
								<div class="paymentMethod">
									<button class="not"></button>
									<button></button>
								</div>
							</div>
						</div>
						<div id="methodDescription">
							<ul>
								<li>현재 페이지는 결제 수단 카드를 관리하는 사용자 페이지 입니다.</li>
								<li>최대 두 개까지 저장 할 수 있으며, 주 결제 카드를 정할 수 있습니다.</li>
								<li>카드 아래 왼쪽 별 표시를 누르면 주 결제 카드를 정할 수 있습니다.</li>
								<li>주 결제 카드 설정을 하면 요금 결제 시 좀 더 빠른 결제를 할 수 있습니다.</li>
							</ul>
						</div>
					</div>
				</div>
			<jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
		</c:otherwise>
	</c:choose>
</body>
<script type="text/javascript" src="/js/mypage.js"></script>
<script type="text/javascript" src="/js/QRcode.js"></script>
</html>