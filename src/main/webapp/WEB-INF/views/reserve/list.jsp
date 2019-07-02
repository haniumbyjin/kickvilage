<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
	function QRcodeScanner() {
		app.QRcodeScanner();
		return false;
	}
	/* 
	    Call the 'showToast' method when the form gets 
	    submitted (by pressing button or return key on keyboard). 
	 */
	window.onload = function() {
		var form = document.getElementById("form");
		form.onsubmit = QRcodeScanner;
	}
</script>
<script>

function QRcode(serialNum){
	$.ajax({
			url : '/reserve/qrcode',
			type : 'POST',
			dataType : 'JSON',
			data :{
				"serialNum" : serialNum
			},
			success : function(data){
				if(data.result =="databaseError"){
					alert("데이터베이스 오류");	
				}else{
					$('#qrcode').qrcode("http://kickvillage.com:8080/reserve/rental?serialNum="+serialNum+"&randomNum="+encodeURI(data.result));
				}
			},
			error : function(err) {
				console.log(err);
			}
	})
};
</script>
<style>
p {
	margin: 0px;
}
.listClass > span {
	float: left;
	text-align: center;
}
.listClass  span  button {
	    width:60px;
    height: 30px;
    padding-top: 7px;
    border-radius: 15px;
    margin: 0 auto;
    color: white;
    background: #10a3e6;
    margin-top: 30px;
}
.listClass > span {
padding-top: 20px;
}
#serialNum div {
	width:100px
	;height: 50px;line-height: 50px;
}
#rentalStationNum div {
	width:400px;
	height: 50px;line-height: 50px;
}
#reserveDate div {
	width:200px;
	height: 50px;line-height: 50px;
}
#reserveDate div {
	width:200px;
	height: 50px;
	line-height: 50px;
}
</style>
</head>
<body>
	<div id="clist">
		<c:choose>
			<c:when test="${sessionScope.reUserPw eq null }">
				<h1>권한이 없습니다.</h1>
			</c:when>
			<c:when test="${sessionScope.reUserPw ne null && list.size() > 0}">
				<c:forEach var="list" items="${list}">
					<span id="serialNum" name="serialNum">
						<p>${list.serialNum}</p>
					</span>
					<span id="rentalStationNum" name="rentalStationNum">
						<p>${list.rentalStationNum}</p>
					</span>

					<span id="reserveDate" name="reserveDate">
						<p>${list.reserveDate}</p>
					</span>

					<span id="availability" name="availability">
						<p>${list.availability}</p>
					</span>

					<c:choose>
						<c:when test="${list.using eq 'n'}">
							<span>
								<button onclick="cancel(${list.serialNum})">취소하기</button>
							</span>
							
							<span id="form">
									<input type="submit" value="Make Toast"></input>
							</span>
							
							<span>
								<button onclick="QRcode(${list.serialNum})">QR코드</button>
							</span>
							<div id="qrcode"></div>
						</c:when>
						<c:otherwise>
							<span id="rentalDate" name="rentalDate">
								<p>${list.rentalDate}</p>
							</span>
							<span>
								<button onclick="return(${list.serialNum})">반납하기</button>
							</span>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div>게시판이 비어있습니다.</div>
			</c:otherwise>
		</c:choose>

	</div>
</body>
</html>