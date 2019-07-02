<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	qrcode();
});
	function qrcode(){
		$.ajax({
			url : '/reserve/reserve',
			type : 'POST',
			dataType : 'JSON',
			data : $('#form').serialize(),
			success: function(data){
				if(data.result == "admin"){
					jquery('#qrcode').qrcode(data.reserveRandamNum);
				} else if( data.result == "admin" ){
					
				}
			},error : function(err) {
				console.log(err);
			}
		});
	
	}
		
</script>
</head>
<body>
<form id="form" name="form">
	<div>
		킥보드대여장소고유값<input type="text" id="rentalStationNum" name="rentalStationNum" />
	</div>
	
	<div>
		킥보드고유값<input type="text" id="serialNum" name="serialNum"/>
	</div>
	
	<div>
		카드정보<input type="text" id="card" name="card"/>
	</div>
	<div>
		<select  id="rentalFee" name="rentalFee">
			<option value=10000>1시간/5000원 보증금 5000원</option>
			<option value=15000>2시간/10000원 보증금 5000원</option>
		</select>
	</div>
</form>
<div>
	<button id="add">결재하기</button>
</div>
<div id="qrcode"></div>
</body>
</html>