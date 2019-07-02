
	$(document).ready(function(){
		$(function(){
			  $('#submit').click(function (){
				  $.ajax({
					  	url : '/mypage/join',
						type : 'POST',
						data : $('#form').serialize(),
						dataType : 'JSON',
						success : function(data) {
							if (data.success != true) {
								if (data.error == "emptyUserId")  {
									alert('아이디가없습니다.');
								} else if (data.error == "usingId") {
									alert("이미 사용중이 아이디입니다.") ;
								} else if (data.error == "emptyUserPw") {
									alert("비밀번호를 입력해주세요") ;
								} else if (data.error == "wrongUserPw") {
									alert("비밀번호형식에 맞게 입력해주세요") ;
								} else if (data.error == "ReUserPw") {
									alert("비밀번호를 똑같이 다시 입력해주세요.") ;
								} else if (data.error == "emptyPhoneNum") {
									alert("전화번호를 입력해주세요.") ;
								} else if (data.error == "wrongPhoneNum") {
									alert("전화번호 형식에 맞게 입력해주세요.") ;
								} else if (data.error == "emptydriverLisence") {
									alert("운전면허 유무를 선택해주세요.") ;
								}
							} else {
								
								alert('회원가입을 환영합니다.');
								location.href = "/";
							}
						},
						error : function(err) {
							console.log(err);
						}
				  });
			  });
			  
			});
	});
	
	/* 아이디 중복 검사 */
	$(document).ready(function(){
		$(function(){
			  $('#userId').blur(function (){
				  $.ajax({
					  	url : '/mypage/join',
						type : 'POST',
						data : $('#form').serialize(),
						dataType : 'JSON',
						success : function(data) {
							if (data.success != true) {
								if (data.error == "emptyUserId")  {
									$('.userIdCk').text("아이디를 입력해주세요.");
									  $('.userIdCk').css("color", "red");
								} else if (data.error == "usingId") {
									$('.userIdCk').text("이미사용중인사이디입니다.");
									$('.userIdCk').css("color", "red");
								} else {
									$('.userIdCk').text("사용가능한 아이디입니다.");
									$('.userIdCk').css("color", "green");
								}	
							}	
							
						},
						error : function(err) {
							console.log(err);
						}
				  });
			  });
			  
			});
	});
	
	$(document).ready(function(){
		$('#userPw').blur(function(){
			var userPw = $('#userPw').val();
			  var pattern = /^[a-zA-Z0-9]{8,20}$/;
			  if(userPw == ""){
				  $('.userPwCk').text("비밀번호를 입력해주세요.");
				  $('.userPwCk').css("color", "red");
			  }  else if( !pattern.test(userPw)){
				  $('.userPwCk').text("비밀번호가 형식에 맞지 않습니다.");
				  $('.userPwCk').css("color", "red");
			  } else{
				  $('.userPwCk').text("사용가능한 비밀번호입니다.");
				  $('.userPwCk').css("color", "green");
				}					
			 
			  
			});
	});
	$(document).ready(function(){
		var reUserPw = $('reUserPw').val();
		$('#reUserPw').blur(function(){
			  if(reUserPw == ""){
				  $('.reUserPwCk').text("비밀번호를 입력해주세요.");
				  $('.reUserPwCk').css("color", "red");
			  }  else if(reUserPw != $('#userPw').val() ){
				  $('.reUserPwCk').text("비밀번호를 똑같이 입력해주세요.");
				  $('.reUserPwCk').css("color", "red");
			  } else{
				  $('.reUserPwCk').text("사용가능한 비밀번호입니다.");
			      $('.reUserPwCk').css("color", "green");
			  }
			 
			  
			});
	});
	
	$(document).ready(function(){
		$('#userName').blur(function(){
		
			var userName = $('#userName').val();
			  if(userName == ""){
				  $('.userNameCk').text("이름을 입력해주세요.");
				  $('.userNameCk').css("color", "red");
			  } else{
				  $('.userNameCk').text("멋진이름이네요!");
			      $('.userNameCk').css("color", "green");
			  }
			 
			  
			});
	});
	
	$(document).ready(function(){
		$('#phoneNum').blur(function(){
			var phoneNum = $('#phoneNum').val();
			  var pattern = /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/ ;
			  if(phoneNum == ""){
				  $('.phoneNumCk').text("전화번호를 입력해주세요.");
				  $('.phoneNumCk').css("color", "red");
			  }  else if( !pattern.test(phoneNum)){
				  $('.phoneNumCk').text("전화번호가 형식에 맞지 않습니다.");
				  $('.phoneNumCk').css("color", "red");
			  } else{
				  $('.phoneNumCk').text("사용가능한 전화번호입니다.");
			      $('.phoneNumCk').css("color", "green");
			  }
			 
			  
			});
	});
	
	