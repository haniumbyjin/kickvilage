<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="/css/boardAdd.css" />
<script>
			$(document).ready(function() { 
				CKEDITOR.replace('editor1');
				editor = CKEDITOR.instances.editor1;
			
				$('#submit').on('click', function(){
					var boardTitle = $('#boardTitle').val();
					var boardText = CKEDITOR.instances.editor1.getData();
					$.ajax({
						type : 'POST',
						//contentType : "application/json; charset=UTF-8",
						dataType : 'JSON',
						url : '/board/add',
						data : //JSON.stringify({
							{
							"boardText" : boardText,
							"boardTitle": boardTitle
							},
						//}),
						success : function(data) {
							if(data.error=="noLogin"){
								alert('로그인이 필요한 서비스입니다.')
							} else if(data.error=="noBoardTitle"){
								alert('제목을 입력해주세요');
							} else if(data.error=="noBoardText"){
								alert('본문을 입력해주세요.');
							} else{
								alert('등록되었습니다.');
								location.href = "/board/list";
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
<body>
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	<div id="form">
		<div>
			제목 <input type="text" id="boardTitle" name="boardTitle" />
		</div>
		<textarea name="boardText" id="editor1" rows="10" cols="80" style="width:100%;padding: 0 10%;">
        </textarea>
	</div>
	<div id="submitPosition">
		<button id="submit">보내기</button>
	</div>
</body>
</html>