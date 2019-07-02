    $('#search_controler_butten_close').click(function(){
    	$('#all_search_Ping').css('right','-400px');
        $('#search_controler_butten_close').css('display','none');

        $('#search_controler_butten_open').css('display','block');});/*검색창(컨트롤) 영역 닫기*/
    $('#search_controler_butten_open').click(function(){
    	$('#all_search_Ping').css('right','0px');
        $('#search_controler_butten_open').css('display','none');
        $('#search_controler_butten_close').css('display','block');});/*검색창(컨트롤) 영역 열기*/
    

        $('.stop').on('click', function () {
                $('#result_Ping').css('right','402px');
                $('.stop_ping').css('overflow-y','hidden');
                var stop = $(' > .stop_title', this).text();
            $('.stop_title_P').html(stop);
        });
        $('.back').on('click', function () {
                $('#result_Ping').css('right','0px');
                $('.stop_ping').css('overflow-y','scroll');
        });
        $('#stop_title_address').on('click', function () {
                $('#result_Ping').css('right','0px');
                $('.stop_ping').css('overflow-y','scroll');
        });

        $('.kickbord_list').on('click',function(){
           $(); 
        });
 /*정류소 클릭시 정류소 안에 리스트 펼치기*/ 
        $('.stop_list').on('click', function(){
           return false;
        });
    var length = $(".stop").length;
    $("#result").html("검색결과 : "+ length).css("background-color","white");


    $('.kickbord_list').on('click', function (){
        var reservation = $(' > .reservation', this);
        var kickID = $('.kickbored_list_ID',this).text();
        var $width=parseInt($("#lay_pop").css("width"));
		var $height=parseInt($("#lay_pop").css("height"));
		var left=($(window).width()-$width)/2;
		var sctop=$(window).scrollTop()*2;
		var top=($(window).height()-$height+sctop)/2;
		var height=document.getElementsByTagName("body")[0].scrollHeight;
		var length = $(".stop_title_P").text();
        $("#lay_pop").css("left",'50%');
		$("#lay_pop").css("top",top);
		$("#lay_pop").css("display","block");
		$("#lay_pop").css("z-index","555");
		$("#all_body").css("display","block");
		$("#all_body").css("width",$(window).width());
		$("#all_body").css("height",height);
        
        
        $(reservation).css('background-color','#2d80f6');
        $(reservation).css('color','white');
        $('#PO_title').html(length +" : "+ kickID);
	});
    
	function layerClose(lay1,lay2){
		$("#"+lay1).css("display","none");
		$("#"+lay2).css("display","none");
        $('.reservation').css('background-color','#fff');
        $('.reservation').css('color','#2b80f6')
	}
	



