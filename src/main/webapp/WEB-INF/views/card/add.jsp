<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('#submit').on('click', function() {
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : '/card/add',
				data : $('#form').serialize(),
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
						location.href = "/card/list";
					} else {
						alert('데이터베이스 오류입니다.');
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
	<form id="form">
		<select>
			<option value="농협">농협</option>
			<option value="국민">국민</option>
			<option value="기업">기업</option>
		</select>
		<span> <input name="cardNumFirst" id="cardNumFirst" />
		</span> <span> -<input name="cardNumSecond" id="cardNumSecond" />
		</span> <span> -<input name="cardNumThird" id="cardNumThird" />
		</span> <span> -<input name="cardNumFourth" id="cardNumFourth" />
		</span> <span> 월<input name="validityMonth" id="validityMonth" />
		</span> <span> 년<input name="validityYear" id="validityYear" />
		</span> <span> 비밀번호앞 2자리<input name="cardPw" id="cardPw" />
		</span>
	</form>
	<button id="submit">카드 추가하기</button>
</body>
</html>