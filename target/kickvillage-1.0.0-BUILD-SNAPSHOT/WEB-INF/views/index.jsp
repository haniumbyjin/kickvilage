<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="author" content="Alvaro Trigo Lopez" />
<meta name="description" content="fullPage full-screen backgrounds." />
<meta name="Resource-type" content="Document" />


<link rel="stylesheet" type="text/css" href="/css/Project_index_style.css" />
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script type="text/javascript">
	
		$(document).ready(function(){	
		
			var container = document.getElementById('map');
			var options = {
				center: new daum.maps.LatLng(33.450701, 126.570667),
				level: 3
			};
			var map = new daum.maps.Map(container, options);

		});
		function zoomIn() {
			console.log(level())
		    map.setLevel(map.getLevel() - 1);
		};
		

		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
		    map.setLevel(map.getLevel() + 1);
		}


		// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		
	</script>

</head>
<body onselectstart="return false" ondragstart="return false">

<div id="header_ping">
    <div id="header">
      <a href="file:///C:/Users/Student/Desktop/Project0402/Project_index.html">
       <div id="header_logo">
           
       </div>
        </a>
        <div id="header_menu">
           <a href="/reserve/rental">
                <div class="header_menu" id="menu_sevice">
                <div class="header_manu_P">대여하기</div>
                <div class="header_hover" id="meny_sevice_hover"></div>
                </div>
            </a>
            <a href="#">
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
               </c:otherwise>
            </c:choose>
        </div>        
	</div>
</div>
<div id="fullpage" style="width: 100%;height: 100%;">
	<div class="map_wrap">
		<div id="map" style="width:100%;height:100%;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=740c3aa706359cd7ac35245220614ec1"></script>
    <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
    <div class="custom_zoomcontrol radius_border" id="control_Z_I"> 
        <span onclick="zoomIn()" id="zoominner"><img src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        <span onclick="zoomOut()" id="zoomiouter"><img src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
	<div id="all_search_Ping">
            <div id="search_controler">
	            <div id="controler">
                    <button id="search_controler_butten_close" type="button"></button>
                    <button id="search_controler_butten_open" type="button"></button>
	            </div>
	        </div>
          <div id="search_Ping_all">
           <div id="Search_ping">
            <div id="Search"> 
	            <input id="Search_inner" type="text" placeholder="구,동,로 검색" />
                <input id="search_button" type="button" />
            </div>
               <div id="search_line"></div>
                <div id="result_Ping" class="result_Ping">
                     
                      <div class="stop_list">
                          <div class="stop_ping"> 
                          <div class="search_result">
	                        <div id="result">검색결과</div><div id="result_number"></div>
                            </div>
                          <div class="stop"> 
                              <div class="stop_title">
                                      은하수 본사
                                  </div>
                                  <div class="stop_amount">
                                      구매 가능 전동킥보드 수 02
                                  </div>
                          </div>
                          <div class="stop"> 
                              <div class="stop_title">
                                      동구 가양로 흥룡로 정류소
                                  </div>
                                  <div class="stop_amount">
                                      구매 가능 전동킥보드 수 02
                                  </div>
                          </div>
                          <div class="stop"> 
                              <div class="stop_title">
                                      동구 가양로 비래동 석천고등학교
                                  </div>
                                  <div class="stop_amount">
                                      구매 가능 전동킥보드 수 02
                                  </div>
                          </div>
                          <div id="null"></div>
                          </div>
                          <div id="kick_stop_LIST">
                             <div class="search_result">
                                <div id="stop_list_back" class="back"> 뒤로가기 </div>
                              </div>
                              <div id="stop_title_address">
                                  <div class="stop_title_P">
                                      은하수 본사
                                  </div>
                                  <div class="address_title">
                                      동구 가양로 흥룡로 19-1
                                  </div>
                              </div>
                              <div id="list_JM">
                              <div class="kickbord_list">
	                                     <div class="kickbored_ID">
	                                     <div class="kickbored_list_ID">342-177 전동퀵보드</div>
	                                     <div class="kickbored_list_time_fee">
	                                         <div class="kickbored_list_time">
	                                             2시간
	                                         </div>
	                                         <div class="kickbored_list_fee">
	                                             4000
	                                         </div>
                                             </div>
	                                     </div> 
	                                     <div class="reservation">
	                                         예약하기
	                                     </div>
                                   </div>
                            <div class="kickbord_list">
	                                     <div class="kickbored_ID">
	                                     <div class="kickbored_list_ID">342-177 전동퀵보드</div>
	                                     <div class="kickbored_list_time_fee">
	                                         <div class="kickbored_list_time">
	                                             2시간
	                                         </div>
	                                         <div class="kickbored_list_fee">
	                                             4000
	                                         </div>
                                             </div>
	                                     </div> 
	                                     <div class="reservation">
	                                         예약하기
	                                     </div>
                                   </div>
                            <div class="kickbord_list">
	                                     <div class="kickbored_ID">
	                                     <div class="kickbored_list_ID">342-177 전동퀵보드</div>
	                                     <div class="kickbored_list_time_fee">
	                                         <div class="kickbored_list_time">
	                                             2시간
	                                         </div>
	                                         <div class="kickbored_list_fee">
	                                             4000
	                                         </div>
                                             </div>
	                                     </div> 
	                                     <div class="reservation">
	                                         예약하기
	                                     </div>
                              </div>
                              </div>
                          </div>
                          </div>
                
                </div>
	        </div>
        </div>
	    </div>
    </div>
    </div>
<div id="lay_pop"><a href="javascript:;" onclick="layerClose('lay_pop','all_body')">닫기</a></div>
<div id="all_body"></div>
<script type="text/javascript" src="/js/Project_index_JS.js"></script>
	<script type="text/javascript">

	</script>

</body>
</html>