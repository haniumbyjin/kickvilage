$(document).ready(function() {
	$('#submit').click(function() {
		$.ajax({
			url : '/mypage/check',
			type : 'POST',
			data : {
				"userPw" : $('#userPw').val()
			},
			dataType : 'JSON',
			success : function(data) {
				if(data.result == "differentPw"){
					alert('맞지 않은 비밀번호입니다.');
				} else if(data.result == "noUserPw"){
					alert('비밀번호를 입력해주세여');
				}else if(data.result == "success"){
					alert('오케');
					location.href = "/mypage/info";
				}else {
					alert('데이터베이스 오류입니다.');
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	});
});