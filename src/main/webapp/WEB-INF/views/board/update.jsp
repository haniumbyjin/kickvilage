<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/ckeditor/ckeditor.js"></script>
<script>
			$(document).ready(function() { 
				CKEDITOR.replace('editor1');
				editor = CKEDITOR.instances.editor1;
				
				
				
			}); 	
			
			
			
			$(document).ready(function() {
				$('#submit').on('click', function(){
					const urlParams = new URLSearchParams(window.location.search);
					var boardTitle = $('#boardTitle').val();
					
					$.ajax({
						processData : true , 
			  			contentType : "application/json; charset=UTF-8",
						type : 'PATCH',
						dataType : 'JSON',
						url : '/board/' + urlParams.get('boardNum'),
						data : JSON.stringify({
							"boardNum" : urlParams.get('boardNum'),
							"boardTitle" : boardTitle,
							"boardText" : CKEDITOR.instances.editor1.getData()
						}),
						success : function(data) {
							if(data.error=="noLogin"){
								alert('로그인이 필요한 서비스입니다.');
							} else if(data.error=="noBoardTitle"){
								alert('제목을 입력해주세요');
							} else if(data.error=="noBordText"){
								alert('본문을 입력해주세요.');
							} else{
								alert('등록되었습니다.');
								location.href = "/board/list";
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
<style type="text/css">
#form {
	width:1200px;
	margin: 0 auto;
	padding-top: 100px; 
}
#boardTitle {
	padding: 5px 20px;
	width:500px;
	margin-bottom: 50px;
	margin-left: 20px;
}
#cke_1_contents {
	height: 400px !important;
}
#submitPosition {
	width:1200px;
	margin: 0 auto;
	position: relative;
}
#submitPosition button {
	width:400px;
	margin:30px;
	height: 40px;
	color: #fff;
	background: #10a3e6;
	border: 0px;
	position: absolute;
	left:50%;
	transform: translate(-50%, 0);
}
#submitPosition button:hover {
	background: #6844ff;
	transition: 0.4s;
}
@media all and (max-width:1024px) {
	#form {
		width:90%;
		margin: 0 5%;
	}
	form div:nth-child(1) {
		width:100%;
	}
	#boardTitle {
		width:70%
	}
	#cke_editor1 {
		width:100%;
	}
	#submitPosition {
		width:100%;
	}
	#submitPosition button {
		width:90%;
		margin: 0px;
		margin-top:20px;
		padding: 0 5%;
	}
}
</style>
<body>
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>
	<div id="form">
		<div>
			제목<input type="text" id="boardTitle" name="boardTitle" />
		</div>
		<textarea name="boardText" id="editor1" rows="10" cols="80">
        </textarea>
	</div>
	<div id="submitPosition">
	<button id="submit">수정완료</button>
	</div>
</body>
<!--  -->
</html>