<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script>
 //$(document).ready(function(){
	 
// 	list();
// });
// 	function list(){
// 		$.ajax({
// 			url : '/reserve/list',
// 			type : 'POST',
// 			dataType : 'JSON',
// 			success : function(data){
// 				var result = document.getElementById("list");
// 				result.innerHTML = "";
// 				for(var list of data.list){
// 					if(list.availability == "n" ){
// 						result.innerHTML +="<span>"+list.reserveNum+"</span>";
// 						result.innerHTML +="<span>"+list.rentalStationNum+"</span>",
// 						result.innerHTML +="<span>"+list.returnStationNum+"</span>";
// 						result.innerHTML +="<span>"+list.reserveDate+"</span>";
// 						result.innerHTML +="<span>"+list.rentalDate+"</span>";
// 						result.innerHTML +="<span>" + list.returnDate + "</span>";
// 						result.innerHTML +="<span>"+list.serialNum+"</span>";
// 						result.innerHTML +="<span>"+list.availability+"</span>";
// 						result.innerHTML +="<span>"+"예약이 취소되었습니다."+"</span>";
// 						result.innerHTML +="</div>";
// 					}else{
// 						result.innerHTML +="<span>"+list.reserveNum+"</span>";
// 						result.innerHTML +="<span>"+list.rentalStationNum+"</span>";
// 						result.innerHTML +=	"<span>"+list.returnStationNum+"</span>";
// 						result.innerHTML +=	"<span>"+list.reserveDate+"</span>";
// 						result.innerHTML +=	"<span>"+list.rentalDate+"</span>";
// 						result.innerHTML +=	"<span>" + list.returnDate + "</span>";
// 						result.innerHTML +=	"<span>"+list.serialNum+"</span>";
// 						result.innerHTML +=	"<span>"+list.availability+"</span>";
// 						result.innerHTML +=	"<span><button type=\"button\" onclick=\"cancel(list.serialNum)\">"+"예약취소"+"</button></span>";
// 						result.innerHTML +="</div>";
// 					}
// 				};
// 			}
//		});
// 	}
	//아직 동작안함
	 function rental(key){ 
		//var reserve = eval(serialize("document.getElementById('"+ key + "')"));

		 $.ajax({
				url : '/reserve/rental',
				type : 'PATCH',
				dataType : 'JSON',
				data : {
					"serialNum":key
				},
				success : function(data){
					if(data.error == null){
						$("#clist").load("/reserve/list #clist");
						alert('대여시작');
					}else if(data.error =="noLogin"){
						alert('로그인정보없음');
					}else if(data.error =="noSerialNum"){
						alert('킥보드고유번호없음');
					}else if(data.error =="noStationNum"){
						alert('대여소 고유번호없음');
					}else if(data.error =="noCard"){
						alert('카드정보없음');
					}else if(data.error =="noRentalFee"){
						alert('가격정보없음');
					}else if(data.error =="use"){
						alert('이미 예약 대여 중인 킥보드');
					}
					
				}
			});
		 };

	//예약 취소하고 리로드 해줌 키값은 예약 번호임
	 function cancel(key){
		

		 $.ajax({
				url : '/reserve/cancel',
				type : 'PATCH',
				dataType : 'JSON',
				data : { "reserveNum":key},
				success : function(data){
						if(data.error == "noSerialNum"){
							alert('킥보드값이 없습니다.');
						} else if(data.error == "noUserId"){
							alert('로그인이 안되어있습니다.');
						} else if(data.error == null) {
							$("#clist").load("/reserve/list #clist");
							alert('예약취소완료');								
				 		};
					}
				});					
		 };
	
</script>
</head>
<body>
<div id="clist">
	<c:choose>
		<c:when test="${sessionScope.reUserPw eq null }">
			<h1>권한이 없습니다.</h1>
		</c:when>
		<c:when test="${sessionScope.reUserPw ne null && list.size() > 0}">
				<c:forEach var="list" items="${list}">
				<div id="${list.reserveNum}">
					<sapn id="reserveNum" name="reserveNum" value="${list.reserveNum}">
						
					</sapn>
					<span id="rentalStationNum" name="rentalStationNum">
						${list.rentalStationNum}
					</span>
					<span id="returnStationNum" name="returnStationNum">
						<p>${list.returnStationNum}</p>
					</span>
					<span id="reserveDate" name="reserveDate">
						<p>${list.reserveDate}</p>
					</span>
					<span id="rentalDate" name="rentalDate">
						<p>${list.rentalDate}</p>
					</span>
					<span id="serialNum" name="serialNum">
						<p>${list.serialNum}</p>
					</span>
					<span id="availability" name="availability">
						<p>${list.availability}</p>
					</span>
					</div>
					<c:choose>
					<c:when test="${list.availability eq 'n'}">
						<p>취소되었습니다.</p>
					</c:when>
					<c:when test="${list.rentalDate ne null}">
						<button onclick="return()">반납하기</button>
					</c:when>
					<c:otherwise>
					<span>
						<button onclick="cancel(${list.reserveNum})">취소하기</button>
					</span>
					<span>
						<button onclick="rental(${list.serialNum})">대여하기</button>
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