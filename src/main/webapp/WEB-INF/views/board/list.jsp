<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<title>list</title>
<link rel="stylesheet" type="text/css" href="/css/boardList.css" />
<script>
</script>
</head>
<body style="overflow:scroll;">
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
    <div id="contentJoinSelect" class="container">
    	<a href="/board/list">
        <div class="JoinSelect" style="background: #fff;color:#10a3e6;" id="question">
            	불만 사항 접수
        </div>
        </a>
        <a href="#">
        	<div class="JoinSelect" id="dissatisfaction">
            	자주하는 질문
        	</div>
        	<script type="text/javascript">

        	$('#dissatisfaction').click(function(){
        		location.href = "/board/question";
            });	

        	</script>
        </a>
    </div>
    <div id="complaint">
       <div id="complaintIn">
 		<table class="complaintTable">
	<tbody>
		<c:choose>
		<c:when test="${list.size() > 0}">
			<c:forEach var="list" items="${list}">
			<tr>
				<td>
					<a href="/board/detail/${list.boardNum}">
						<div>
							${list.boardNum}
						</div>
					</a>
				</td>
				<td>
					<a href="/board/detail/${list.boardNum}">
						<div>
							${list.boardTitle}
						</div>
					</a>
				</td>
				<td>
					<a href="/board/detail/${list.boardNum}">
						<div>
							${list.boardDate}
						</div>
					</a>
				</td>
				<c:if test="${sessionScope.admin ne null}">
					<td>${list.userId}</td>
				</c:if>
			</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<h1>등록된 게시판이 없습니다.</h1>
			</c:otherwise>
		</c:choose>
	
</table>
<div id="nextBottomPageControl">
           <div id="nextPageLayer">
           <c:if test="${page.prev}">
            	<span>
            		<a href="/board/list?pageNum=${page.startPage-1}&contentNum=10">
            			<img src="/img/prev.png">
            		</a>
            	</span>
            </c:if>
            <c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
            	<span>
            		<a href="/board/list?pageNum=${idx}&contentNum=10">
            			<div>
            				${idx}
            			</div>
           		 	</a>
            	</span>
			</c:forEach>
			<c:if test="${page.next}">
            	<span>
            		<a href="/board/list?pageNum=${page.endPage+1}&contentNum=10">
            			<img src="/img/next.png">
            		</a>
            	</span>
            </c:if>
            </div>
        </div>
	<div>
	<c:if test="${sessionScope.userId ne null}">
		<a href="/board/add">
			<div id="addText">글쓰기</div>
		</a>
	</c:if>
	</div>
	        </div>
    </div>
    <jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
<script>
$(document).ready(function() {
		var listDate = $(".complaintTable");
		var listDateText = listDate.substring(1, 10);
		console.log(listDate);
	});
</script>
</body>
</html>