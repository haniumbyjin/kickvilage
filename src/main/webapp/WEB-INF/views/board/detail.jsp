<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<title>list</title>
<link rel="stylesheet" type="text/css" href="/css/boarddetail.css" />
<script>
function answerAdd(boardNum){
	$.ajax({
			url :  boardNum,
			type : 'POST',
			dataType : 'JSON',
			data :{
				boardNum : boardNum,
				answerText : $('#answerAdd').val()
			},
			success : function(data){
				if(data.error =="noBoardNum"){
						alert('게시판 번호가 없습니다.');
					} else if(data.error =="noAdmin"){
						alert('관리자만 댓글을 작성할 수 있습니다.');
					} else if(data.error =="noAnswerText"){
						alert('댓글 내용을 작성해주세요.');
					}else{
						$("#body").load("/board/detail/"+boardNum);
					}
				
			},
			error : function(data){
			}
	});
}
	  function removeCheck(boardNum) {
			var result = confirm('정말 삭제하시겠습니까? 데이터는 복구되지 않습니다.');
			if (result == true) {
				remove(boardNum);
			}
		}
		
	function remove(boardNum) {
		$.ajax({
			contentType : "application/json; charset=UTF-8",
			url : '/board/' + boardNum,
			type : 'DELETE',
			dataType : 'JSON',
			data : {
				'boardNum' : boardNum
			},
			success : function(data) {
				if (data.error == "noLogin") {
					alert('로그인이 필요한 서비스입니다.');
				} else if (data.error == "noPrincipal") {
					alert('본인이 작성한 글만 삭제 가능합니다.');
				} else if (data.error == "alreadyDelete") {
					alert('이미 삭제된 글입니다.');
				} else {
					alert('삭제되었습니다.');
					$("#clist").load("/board/list");
				}
			},
			error : function(data) {

			}
		});
	}
	
	function answerUpdate(answerNum,boardNum){
		
		$("#answerText"+answerNum).html(
				'<td><textarea id='+"'"+"answerRe"+answerNum+"'"+'></textarea></td>'
				+"<td><button onclick="+"answerPatch("+answerNum+","+boardNum+")>글수정</button></td>"
				+"<td><button onclick="+"answerUpdateCancel("+answerNum+")>글수정취소</button></td>");
	}

	function answerPatch(answerNum,boardNum){
		var answerText = $('#answerRe'+answerNum).val(); 
		$.ajax({
			processData : true , 
  			contentType : "application/json; charset=UTF-8",
			type : 'PATCH',
			dataType : 'JSON',
			url : '/board/detail/' + answerNum ,
			data : JSON.stringify({
				boardNum : boardNum,
				answerNum : answerNum,
				answerText : answerText
			}),
			success : function(data){
				if(data.error == "noAdmin"){
					alert('관리자만이 댓글작성 가능합니다.');
				} else if(data.error =="noAnswerText"){
					alert('댓글내용이없습니다.');
				} else if(data.error =="noBoardNum"){
					alert('게시판 번호가 없습니다..');
				} else{
					alert('수정되었습니다.');
					$("#body").load("/board/detail/" + boardNum);
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	function answerRemove(answerNum,boardNum) {
		$.ajax({
			processData : true , 
  			contentType : "application/json; charset=UTF-8",
			url : '/board/detail/' + answerNum,
			type : 'DELETE',
			dataType : 'JSON',
			data : JSON.stringify({
				'answerNum' : answerNum,
				'boardNum' : boardNum 
			}),
			success : function(data) {
				if (data.error == "noAdmin") {
					alert('관리자 관한이 없습니다.');
				} else if (data.error == "noBoardNum") {
					alert('게시판 번호가 없습니다.');
				} else if (data.error == "alreayDelete") {
					alert('이미 삭제된 글이거나 본인이 아닙니다.');
				} else if (data.error == "false") {
					alert('데이터베이스 오류입니다.');
				}else {
					alert('삭제되었습니다.');
					$("#body").load("/board/detail/" + boardNum);
				}
			},
			error : function(data) {

			}
		});
	}
</script>
</head>
<body id="body" >
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	<c:forEach var="list" items="${list}">
	<div id="detailcontent">
				<div id="detailtitle">
					<div>${list.boardNum}</div>
					<div>${list.boardTitle}</div>
				    <div>${list.boardDate}</div>
				</div>	
				<div id="detailText">
					${list.boardText}
				</div>
				<div id="detaliDaytId">
				    
				    <c:if test="${sessionScope.admin ne null}">
					    <div>${list.userId}</div>
				    </c:if>
				
				<div id="update">
				<div></div>
				<c:if test="${sessionScope.userId eq list.userId}">
				    <div id="detailbutton">
					    <div><a href="/board/update?boardNum=${list.boardNum}"><button>글수정</button></a></div>
					    <div></div>
					    <div><button id="delete" onclick='removeCheck(${list.boardNum})'>글삭제</button></div>
			    	</div>
				</c:if>
				</div>
				</div>
				<div id="comment">
					<div></div>
					<div><textarea id="answerAdd" rows="" cols=""></textarea></div>
					<div><button onclick='answerAdd(${list.boardNum})' id="anserGet">댓글작성</button></div>
				<div></div>
				</div>
		
			<c:if test="${list.answerList.size() > 0}">
				<c:forEach var="answerList" items="${list.answerList}">
					<div id="answerText${answerList.answerNum}" class="answerText">
						<div></div>
				    <div style="border-bottom: 1px solid #666;margin-bottom: 20px;">
                    <div id="anwserText">
						<div>${answerList.answerNum}</div>
					    <div style="text-align:right;">${answerList.answerDate}</div>
					</div>
						<div style="padding: 10px 0">${answerList.answerText}</div>
						<div style="text-align: right;padding: 10px 0">${answerList.adminId}</div>
						<c:if test="${sessionScope.admin ne null}">
							<div></div>
							<div style="padding: 10px 0;height: 30px;">
							    <div class="UpdateButton"><button onclick="answerRemove(${answerList.answerNum},${list.boardNum})">글삭제</button></div>
							<div class="UpdateButton"><button onclick="answerUpdate(${answerList.answerNum},${list.boardNum})">글수정</button></div>
						</div>
						<div></div>
						</c:if>
                    </div>
						<div></div>
					</div>
				</c:forEach>
			</c:if>
	</div>
		</c:forEach>
		
</body>
</html>