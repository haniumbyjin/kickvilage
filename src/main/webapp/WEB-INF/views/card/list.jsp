<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<title>CardList</title>
<script>
	$(document).ready(function() {
		cardList();
	});
	
	function cardList(){
		$.ajax({
			type : 'GET',
			url : '/card/ajaxList',
			success : function(data) {
				var html = "";
				if(data.error == "error"){
					html += "<p>데이터베이스 오류입니다. 관리자에게 문의하시게</p>";
				}
				if(data.list.length>0){
					 for(var i=0; i<data.list.length; i++){
						    html += "<div id='update'>";
		                    html += "<p>" + data.list[i].cardNumFirst + "</p>";
		                    html += "<p>" + data.list[i].cardNumSecond + "</p>";
		                    html += "<p>" + data.list[i].cardNumThird + "</p>";       
		                    html += "<p>" + data.list[i].validityMonth + "</p>";
		                    html += "<p>" + data.list[i].validityYear + "</p>";
		                    html += "<button id='update' onclick='update(" + data.list[i].cardNum + ")'>카드수정</button>";
		                    html += "<button id='removeCheck' onclick='removeCheck(" + data.list[i].cardNum + ")'>카드삭제</button>";
		                    html += "</div>";
		                }
				}else{
					html += "<div>";
					html += "<h1>등록된 카드가 없습니다.</h1>";
					html += "</div>";	
				}
				html += "<a href='/card/add'>카드추가</a>";
				$("#list").html(html);
			},
			error : function(err) {
				console.log(err);
			}
		});
	};
		
	function update(cardNum){
		 var html = "";
		 html += "<form id='form'>";
         html += "<input id='cardNumFirst' name='cardNumFirst' />-";
         html += "<input id='cardNumSecond' name='cardNumSecond' /->";
         html += "<input id='cardNumThird' name='cardNumThird' />-";
         html += "<input id='cardNumFourth' name='cardNumFourth' />";
         html += "월<input id='validityMonth' name='validityMonth' />";
         html += "년<input id='validityYear' name='validityYear' />";
         html += "비밀번호 앞 두자리<input id='cardPw' name='cardPw' />";
         html += "</form>";
         html += "<button id='update' onclick='updateInput(" + cardNum + ")'>카드수정</button>";
         $("#update").html(html);
	}	
	
	 function updateInput(cardNum){
		$.ajax({
			processData : true , 
  			contentType : "application/json; charset=UTF-8",
			type : 'PATCH',
			dataType : 'JSON',
			url : '/card/' + cardNum,
			data : JSON.stringify({
				cardNum : $('#cardNum').val(),
				cardNumFirst : $('#cardNumFirst').val(),
				cardNumSecond : $('#cardNumSecond').val(),
				cardNumThird : $('#cardNumThird').val(),
				cardNumFourth : $('#cardNumFourth').val(),
				validityMonth : $('#validityMonth').val(),
				validityYear : $('#validityYear').val(),
				cardPw : $('#cardPw').val()
			}),
			success : function(data) {
				if (data.error == "noLogin") {
					alert('로그인이 필요한 서비스입니다.');
				} else if (data.error == "noCardNum") {
					alert('카드번호를 입력해주세요');
				} else if (data.error == "noCardPw") {
					alert('카드비밀번호를 입력해주세요');
				} else if (data.error == "noDate") {
					alert('유효기간을 입력해주세요');
				} else if (data.error == "lengthLimit") {
					alert('카드 번호, 또는 유효기간, 비밀번호를 정확히 입력해주세요 ');
				} else if (data.error == 'success') {
					alert('등록되었습니다.');
					cardList();
				} else {
					alert('데이터베이스 오류입니다.');
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	 function removeCheck(cardNum) {
			var result = confirm('정말 삭제하시겠습니까? 데이터는 복구되지 않습니다.');
			if (result == true) {
				cardRemove(cardNum);
			}
		}
	 function cardRemove(cardNum){
		 $.ajax({
			contentType : "application/json; charset=UTF-8",
			url : '/card/' +cardNum ,
			type : 'DELETE' ,
			dataType : 'JSON',
			success : function (data){
				if(data.error == 'noLogin'){
					alert('로그인이 필요한 서비스입니다.');
				}
				if(data.error == 'noCardNum'){
					alert('카드번호가 없습니다.');
				}
				if(data.error == 'noIdentity'){
					alert('본인이 아닙니다.');
				}
				if(data.success == "success"){
					alert('삭제되었습니다.');
					cardList();
				}else{
					alert('데이터베이스 오류입니다. 관리자에게 문의하세요.')
				}
			},
			error : function (error){
				consloe.log(error);
			}
		 });
	 }
</script>
</head>
<style>

#cardPayment {
    width: 900px;
    margin: 0 auto;
}
#cardPaymentTitle {
    width:900px;
    height: 20px;
    text-align: left;
    padding: 90px 25px 0 25px;
    font-family: "NanumSquare";
    font-size: 14pt;
}
#cardIndex {
    width:850px;
    padding: 40px;
}
#paymentMethod {
    width: 75px;
    margin: 0 auto;
}
#cardPing {
    width: 330px;
    display: inline-block;
    margin-right: 70px;
}
#cardPing img {
    width:330px;
}
#paymentMethod button {
    display: inline-block;
    width:33px;
    height: 29px;
    padding: 0px;
    border: 0px;
    outline: none; cursor: pointer;
    margin: 0 auto;
    background-image: url(../img/trash.png);
}
#paymentMethod button[class="select"] {
    background-image: url(../img/starYellow.jpg);
}
#paymentMethod button[class="not"] {
    background-image: url(../img/starGray.jpg);
}
#methodDescription {
     font-family: "NanumSquare";
    font-weight: normal;
    font-size: 10pt;
    color: #696969;
    width: 100%;
    height: 110px;
}
#methodDescription li {
    margin-top: 10px;
}
</style>
<body>
<div id="cardPayment" style="display: none;">
            <div id="cardPaymentTitle">
                	결제수단 관리
            </div>
            <div id="cardIndex">
            	<div></div>
                <div id="cardPing">
                    <img src="../img/1-12.png">
                      <div id="paymentMethod">
                        <button class="select"></button>
                        <button></button>
                      </div>
                </div>
                <div></div>
                <div id="cardPing">
                    <img src="../img/cardToss.png">
                      <div id="paymentMethod">
                        <button class="not"></button>
                        <button></button>
                      </div>
                </div>
                <div></div>
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

	<div id="list"></div>
</body>
</html>