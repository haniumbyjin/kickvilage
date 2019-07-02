<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"  href="/js/jquery-3.3.1.min.js"></script>
<script>
	$('document').read(function(){
		$('#submit').click(function(){
			$.ajax({
				url : '/card/add',
				data : $('#form').serialize(),
				dataType : 'JSON',
				success : function(data){
					if(data.error == "noCardNum"){
						alert('카드번호를 입력해주세요');
					} else {
						alert('등록되었습니다.');
						location.href = "/card/info";
					}
				}, error : function(err){
					console.log(err);
				}
			});
		});
	});
</script>
</head>
<body>
<div>
	<span>
		<input name="cardNumFirst" id="cardNumFirst" />
	</span>
	<span>
		-<input name="cardNumSecond" id="cardNumSecond" />
	</span>
	<span>
		-<input name="cardNumThird" id="cardNumThird" />
	</span>
	<span>
		-<input name="cardNumFourth" id="cardNumFourth" />
	</span>
</div>
<span>
	월<input  name="validityMonth" id="validityMonth" />
</span>
<span>
	년<input  name="validityYear" id="validityYear" />
</span>
<div>
	비밀번호앞 2자리<input  name="cardPw" id="cardPw" />
</div>
</body>
</html>