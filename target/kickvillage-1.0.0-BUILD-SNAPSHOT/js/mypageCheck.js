	$(document).ready(function() {
		$(function() {
			$('#submit').click(function() {
				$.ajax({
					url : '/mypage/check',
					type : 'POST',
					data : $('#form').serialize(),
					dataType : 'JSON',
					success : function(data) {
						if (data.success != true) {
							if(data.error == "noUserId"){
								alert('다시로그인해주세요')
							} else if (data.error == "noUserPw") {
								alert('비밀번호오를 입력해주세요');
								/* 아이디가 중복일떄 */
							} else if (data.error == "differentPw") {
								alert('맞지 않는 비밀번호입니다.');
							} 		
						}else {
							alert('오케');
							location.href = "/mypage/info";
						}			
					},
					error : function(err) {
						console.log(err);
					}
				});

			});
		});
	});