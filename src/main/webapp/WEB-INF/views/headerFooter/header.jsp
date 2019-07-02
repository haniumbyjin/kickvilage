<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<style>
    html,body {
    margin: 0px;
    height:100%;
    width: 100%;
    display: block;
    overflow-y: hidden;
    overflow-x: hidden;
    min-width: 1200px;
}
a:link {text-decoration: none; color: #333333;}
a:visited {text-decoration: none; color: #333333;}
a:active {text-decoration: none; color: #333333;}
a:hover {text-decoration: none; color: #333333;}

#header_ping {
    width: 100%;
    height: 65px;
    background: linear-gradient( to right, #10a3e6, #6844ff );
    box-shadow: 0px 5px 10px rgba(000, 000, 0, 0.2);
    z-index: 1;
}
#header {
    width: 1200px;
    margin: 0 auto;
    height: 65px;
    position: relative;
    overflow: hidden;
}
#header_menu {
    float: right;
    right: 0px;
    height: 65px;
    width: 600px;
}
#header_logo {
    height: 65px;
    width: 230px;
    background-image: url(/img/logopng.png);
    background-position: center left;
    background-size: 187px;
    background-repeat:no-repeat;
    float: left;
}
.header_menu {
    height: 65px;
    width:200px;  
    float: left;
    position: relative;

}
.header_manu_P {
    font-family: 'NotoSansCJKkr-Regular';
    font-size: 14pt;
    color:#ffffff;
    width: 100%;
    text-align: center;
    position: absolute;
    height:28px; bottom: 50%;
    transform: translate(0,50%);
    
}
.header_hover {
    background-color: white;
    width: 200px;
    height: 3px;
    position: absolute;
    bottom: -3px;
    transition-duration: 0.4s
}
#menu_sevice:hover #meny_sevice_hover {
    bottom:0px;
    transition-duration: 0.4s
}
#menu_center:hover #meny_center_hover{
    bottom:0px;
    transition-duration: 0.4s
}
#menu_login:hover #meny_login_hover{
    bottom:0px;
    transition-duration: 0.4s
}   
    .header_centerMenu {
        width: 200px;
        height: 60px;
    }
    .header_centerMenu div {
        width:200px;
        height: 30px;
    }
    #mobile_menu {
        display: none;
        background-size: 50px 50px;
        background-position: center center;
        cursor: pointer;
    }
    .menu-trigger {
	margin-right: 70px;
	margin-bottom: 50px;
}
.menu-trigger,
.menu-trigger span {
	display: inline-block;
	transition: all .4s;
	box-sizing: border-box;
}

.menu-trigger {
	position: relative;
	width: 50px;
	height: 44px;
}

.menu-trigger span {
	position: absolute;
	left: 0;
	width: 80%;
	height: 3px;
	background-color: #fff;
	border-radius: 4px;
}
#menuScroll {
	display: none;
}
.menu-trigger span:nth-of-type(1) {
	top: 10px;
}

.menu-trigger span:nth-of-type(2) {
	top: 20px;
}

.menu-trigger span:nth-of-type(3) {
	bottom: 10px;
}

/* type-01 */
/* 중앙 라인이 고정된 자리에서 투명하게 사라지며 상하라인 회전하며 엑스자 만들기 */
.menu-trigger.active-1 span:nth-of-type(1) {
	-webkit-transform: translateY (10px) rotate (-45deg);
	transform: translateY(10px) rotate(-45deg);
}

.menu-trigger.active-1 span:nth-of-type(2) {
	opacity: 0;
}

.menu-trigger.active-1 span:nth-of-type(3) {
	-webkit-transform: translateY(-10px) rotate(45deg);
	transform: translateY(-10px) rotate(45deg);
}

@media all and (max-width:1024px) {
    
    #header_menu {
        display: none;
    }
    #header_logo {
        margin-left: 20px;
    }
    #header {
        overflow: visible;
    }
    #mobile_menu {
        display: block;
        width: 50px;
        height: 50px;
        float: right;
        margin: 10px;
    }
    #header_ping {
        width: 100%;
    }
    #header, header {
        width:100%;
    }
    html, body {
    height: 100%;
    width: 100%;
    display: block;
    min-width: 100%;
    }
    #menuScroll {
        position: absolute;
        top:65px;
        width: 100%;
        height: 0px;
        overflow: hidden;
        transition: 0.2s;
        display: block;
        z-index: 1000;
        
    }
    #menuScroll div {
        height: 50px;
        background: #000;
        opacity: 0.4;
        color: #fff;
        font-size: 16pt;
        text-align: center;
        border-bottom: 1px solid #fff;
        line-height: 50px;
        font-family: "NanumSquare";
        
    }
    
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
    $(document).ready(function (){
        var burger = $('.menu-trigger');

        burger.each(function(index){
	    var $this = $(this);
	
	    $this.on('click', function(e){
		e.preventDefault();
		$(this).toggleClass('active-' + (index+1));
	    if ($(".menu-trigger").hasClass("open") == true) {
            $("#menuScroll").css("height","150px");
            $(".menu-trigger").removeClass("open");
        } else if ( $(".menu-trigger").hasClass("open") == false){
            $("#menuScroll").css("height","0px");
            $(".menu-trigger").addClass("open");
        }   
        })
        }) 
        
    })
    
    
    
</script>
<body>
   <div id="header_ping">
      <div id="header">
      	<a href="/">
         <div id="header_logo"></div>
         </a>
         <div id="header_menu">
            <a href="/">
               <div class="header_menu" id="menu_sevice">
                  <div class="header_manu_P">대여하기</div>
                  <div class="header_hover" id="meny_sevice_hover"></div>
               </div>
            </a> <a href="/board/list">
               <div class="header_menu" id="menu_center">
                  <div class="header_manu_P">고객센터</div>
                  <div class="header_hover" id="meny_center_hover"></div>
               </div>
            </a>
            <c:choose>
               <c:when test="${sessionScope.userId eq null}">
                  <a href="/mypage/login">
                     <div class="header_menu" id="menu_login">
                        <div class="header_manu_P">로그인</div>
                        <div class="header_hover" id="meny_login_hover"></div>
                     </div>
                  </a>
               </c:when>
               <c:when test="${sessionScope.reUserPw eq null }">
                  <a href="/mypage/check" id="mypage">
                     <div class="header_menu" id="menu_login">
                        <div class="header_manu_P">마이페이지</div>
                        <div class="header_hover" id="meny_login_hover"></div>
                     </div>
                  </a>
               </c:when>
               <c:otherwise>
                  <a href="/mypage/info" id="mypage">
                     <div class="header_menu" id="menu_login">
                        <div class="header_manu_P">마이페이지</div>
                        <div class="header_hover" id="meny_login_hover"></div>
                     </div>
                  </a>
                  <a href="/mypage/info" id="mypage">
                     <div class="header_menu" id="menu_logout">
                        <div class="header_manu_P">마이페이지</div>
                        <div class="header_hover" id="meny_logout_hover"></div>
                     </div>
                  </a>
               </c:otherwise>
            </c:choose>
         </div>
         <div id="mobile_menu">
            <a class="menu-trigger open" href="#">
	            <span></span>
	            <span></span>
	            <span></span>
            </a>

        </div> 
        <div id="menuScroll">
           <a href="/reserve/">
            <div>대여하기</div>
            </a>
            <a href="/mypage/check">
            <div>고객센터</div>
            </a>
            <a href="/mypage/info">
            <div>로그인</div>
            </a>
        </div>
      </div>
   </div>
</body>
</html>