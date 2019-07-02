$('.JoinSelect').on('click', function(){
        $('.JoinSelect').css('background-color','').css("color","white");
        $(this).css('background-color','#fff').css("color","#10a3e6");
});
    function submitForm(){
        console.log("쨘");
    }
function press(f){ 
		var keycode = event.keyCode;
		if(keycode == 13){ //javascript에서는 13이 enter키를 의미함 
			submitForm(); //formname에 사용자가 지정한 form의 name입력 
			
		} 
		
	}
var foInputSearch = $(" > input", "#customerCenterSearch");
var foInputbutton = $(" > button", "#customerCenterSearch");





 foInputSearch.focus(function () { 
    $("#customerCenterSearch").css('border','1px solid #6844ff'); 
     foInputSearch.css('border-left','1px solid #6844ff');
     foInputbutton.css('border-left','1px solid #6844ff');
});
 foInputSearch.blur(function () { 
    $("#customerCenterSearch").css('border','1px solid #c3c3c3'); 
     foInputSearch.css('border-left','1px solid #c3c3c3');
     foInputbutton.css('border-left','1px solid #c3c3c3');
});

        $('.questionAnswer').on('click', function() {
            var openclose= $('> .questionimg', this);
            if ( openclose.hasClass("open") == true) {
                $(this).css("height","360px");
                openclose.addClass("close").removeClass("open");
            } else {
                $(this).css("height","50px");
                openclose.addClass("open").removeClass("close");
            }
        })


//    $('.questionAnswer').on('click', function() {
//        var Answer = $('> .answer', this);
//        var questionimg = $('> .questionimg', this);
//        $(this).css('height', '300px');
//        Answer.css('height','240px');
//        questionimg.css('background-image','url(../img/qAClose.png)');
//    })
