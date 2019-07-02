<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('#add').click(function() {
			$.ajax({
				url : '/reserve/add',
				type : 'POST',
				dataType : 'JSON',
				data : $('#form').serialize(),
				success : function(data) {
					if (data.result == "reserved") {
						alert('이미 예약된 킥보드입니다.');
					}else if (data.result =="success") {
						alert('예약되었습니다.');
					} else{
						alert('데이터베이스 오류입니다.');
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
		});
	});
</script>
</head>
<body>
	<c:choose>
		<c:when test="${sessionScope.userId eq null }">
			<h1>권한이 없습니다.</h1>
		</c:when>
		<c:otherwise>
			<form id="form" name="form">
				<div>
					킥보드대여장소고유값<input type="text" id="rentalStationNum"
						name="rentalStationNum" />
				</div>

				<div>
					킥보드고유값<input type="text" id="serialNum" name="serialNum" />
				</div>

				<div>
					카드정보<input type="text" id="card" name="card" />
				</div>
				<div>
					<select id="rentalFee" name="rentalFee">
						<option value=10000>1시간/5000원 보증금 5000원</option>
						<option value=15000>2시간/10000원 보증금 5000원</option>
					</select>
				</div>
			</form>
			<div>
				<button id="add">결재하기</button>
			</div>
		</c:otherwise>
	</c:choose>

</body>
</html>