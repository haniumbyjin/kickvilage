$('.JoinSelect').on('click', function(){
        $('.JoinSelect').css('background-color','').css("color","white");
        $(this).css('background-color','#fff').css("color","#10a3e6");
    
        if( $(this).attr("id") == "updateSelect") {
            $("#reservationTab").css("display","none");
            $("#cardPayment").css("display","none");
            $("#JoinSelectOne").css("display","block");
            console.log($("#JoinSelectOne"))
        } else if( $(this).attr("id") == "reservationcheck" ) {
            $("#JoinSelectOne").css("display","none");
            $("#cardPayment").css("display","none");
            $("#reservationTab").css("display","block");
            $("#reservePosition").load("/reserve/list");
        } else {
            $("#JoinSelectOne").css("display","none");
            $("#cardPayment").css("display","block");
            $("#reservationTab").css("display","none");
        }
    })


$("#password").change(function(){
    checkPassword($('#password').val(),$('id').val());
});

var userPw;
		$('#password').blur(function(){
			userPw = $('#password').val();
			  var pattern = /^[a-zA-Z0-9]{8,20}$/;
			  if(userPw == ""){
				  $("#passwordContents").text("비밀번호는 영어와 숫자를 섞어주세요..");
			  }  else if( !pattern.test(userPw)){
                  $('#password').css("background-image","url('../noNotPass.png')");
                  $("#passwordContents").text("정상적인 비밀번호 형식이 아닙니다.");
			  } else{
				  $('#password').css("background-image","url('../okPass.png')");
				  $('#passwordContents').text("사용가능한 비밀번호입니다.");
			      return true;	
              }					
			 
			  
			});


	$('#passwordCheck').blur(function(){
		reUserPw = $('#passwordCheck').val();
		$('#passwordCheck').blur(function(){
			  if(reUserPw == $('#password').val() ){
				  $('#repasswordContents').text("비밀번호가 일치합니다.");
			      $('#passwordCheck').css("background-image","url('../okPass.png')");
              } else{
				  $('#repasswordContents').text("비밀번호를 똑같이 입력해주세요.");
                  $('#passwordCheck').css("background-image","url('../noNotPass.png')");
                  
			  }
			 
			  
			});
	});
$("#password").on("mouseenter", function() {
            $("#passwordPassAlert").css("display","block").css("left","640px").css("top","170px");
    });
$("#password").on("mouseleave", function() {
            $('#passwordPassAlert').css('display','none').css("left","640px").css("top","170px");
        });
$("#passwordCheck").on("mouseenter", function() {
                if(userPw == null) {
                    $("#repasswordPassAlert").css("display","none").css("left","640px").css("top","235px");
                } else {
                    $("#repasswordPassAlert").css("display","block").css("left","640px").css("top","235px");
                }
    });
$("#passwordCheck").on("mouseleave", function() {
            $('#repasswordPassAlert').css('display','none');
    
        });


