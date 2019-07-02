<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KICK Village</title>
<meta name="author" content="은하수 테크놀로지" />
<meta name="description" content="[한이음 프로젝트] 전동킥보드 공유 플랫폼 및 시스템" />
<!-- <meta name="Resource-type" content="Document" /> -->

<link rel="stylesheet" type="text/css"
	href="/css/Project_index_style.css" />
<link rel="stylesheet" href="/css/map.css" />

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</head>
<body onselectstart="return false" ondragstart="return false">
	<jsp:include page="headerFooter/header.jsp" flush="false"></jsp:include>

	<div id="fullpage" style="width: 100%; height: 100%;">



		<div class="map_wrap">
			<div id="map" style="width: 100%; height: 100%;"></div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bf7e305fd71b5a431fd6f60a61cdf1c3&libraries=services"></script>
			<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
			<div id="mid_control">
				<div id="mid_move" onclick="currentPosition()"></div>
				<div class="custom_zoomcontrol radius_border" id="control_Z_I">
					<span onclick="zoomIn()" id="zoominner"> <img
						src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
						alt="확대">
					</span> <span onclick="zoomOut()" id="zoomiouter"> <img
						src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
						alt="축소">
					</span>
				</div>
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
							<input id="Search_inner" type="text" placeholder="구,동,로 검색" /> <input
								id="search_button" type="button" />
						</div>
						<div id="search_line"></div>
						<div id="result_Ping" class="result_Ping">

							<div class="stop_list">
								<div class="stop_ping">
									<div class="search_result">
										<div id="result">검색결과</div>
										<div id="result_number"></div>
									</div>
									<c:choose>
										<c:when test="${stations.size() >0}">

											<c:forEach var="stations" items="${stations}">
												<div class="stop"
													onclick="kickboardList(${stations.stationNum})">
													<div class="stop_title">${stations.stationName}</div>
													<div class="stop_amount">구매 가능 전동킥보드 수
														${stations.kickboardCount}</div>
												</div>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<div class="stop">
												<div class="stop_title">정류소가 없습니다.</div>
												<div class="stop_amount">구매 가능 전동킥보드 수 0</div>
											</div>
										</c:otherwise>
									</c:choose>


									<div id="null"></div>
								</div>

								<div id="kick_stop_LIST">
									<div class="search_result">
										<div id="stop_list_back" class="back">뒤로가기</div>
									</div>
									<div id="stop_title_address">
										<div class="stop_title_P">은하수 본사</div>
										<div class="address_title">동구 가양로 흥룡로 19-1</div>
									</div>
									<div id="list_JM">
										<div class="kickbord_list">
											<div class="kickbored_ID">
												<div class="kickbored_list_ID">342-177 전동퀵보드</div>
												<div class="kickbored_list_time_fee">
													<div class="kickbored_list_time">2시간</div>
													<div class="kickbored_list_fee">4000</div>
												</div>
											</div>
											<div class="reservation">예약하기</div>
										</div>
										<div class="kickbord_list">
											<div class="kickbored_ID">
												<div class="kickbored_list_ID">342-177 전동퀵보드</div>
												<div class="kickbored_list_time_fee">
													<div class="kickbored_list_time">2시간</div>
													<div class="kickbored_list_fee">4000</div>
												</div>
											</div>
											<div class="reservation">예약하기</div>
										</div>
										<div class="kickbord_list">
											<div class="kickbored_ID">
												<div class="kickbored_list_ID">342-177 전동퀵보드</div>
												<div class="kickbored_list_time_fee">
													<div class="kickbored_list_time">2시간</div>
													<div class="kickbored_list_fee">4000</div>
												</div>
											</div>
											<div class="reservation">예약하기</div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="controlMedia"></div>
	</div>
	<div id="lay_pop" style="display: none;">
		<div id="PO_title">
			<div id="pop_s">결제수단 선택</div>
			<div id="PO_close" onclick="layerClose('lay_pop','all_body')"></div>
		</div>
		<div id="POP_address">
			<div id="POP_address_ping">
				<span id="POP_address_1" class="POP_address_all">은하수 본사 </span> <span
					id="POP_address_2" class="POP_address_all">동구 가양동 흥룡로 19-1 |
				</span> <span id="POP_address_3" class="POP_address_all">342-117</span>
			</div>
		</div>
		<div id="Pop_card_reservation_all_ping">
			<div id="card_Ping">
				<div class="card">
					<div class="card_select"></div>
					<div class="card_bank"></div>
					<div class="Account_Number">3012 06** **** 3381</div>
				</div>
				<div id="card_none_plus" class="card">
					<div id="card_plus"></div>
					<div id="card_plus_title">카드추가</div>
				</div>
				<div id="card_Explanation">
					<span style="color: #cd1b1b;">*</span><span> 카드는 2개까지</span><br />
					<span style="margin-left: 10px;">추가 할 수 있습니다.</span>
				</div>

			</div>
			<div id="price_ping">
				<div class="price off" id="price_1ho">
					<span id="price_1h_time">1시간</span> <span>|</span> <span
						id="price_1h_price">\5000</span>

				</div>
				<div class="price off" id="price_2ho">
					<span id="price_2h_time">2시간</span> <span>|</span> <span
						id="price_2h_price">\10000</span>
				</div>
			</div>
			<div id="price_result">결제 방식과 대여 시간을 선택해주세요.</div>
			<div id="payment">결제</div>
		</div>

	</div>
	<div id="lay_pop_card_body"></div>
	<div id="lay_pop_card_plus">
		<div id="lay_pop_card_plus_title">
			<p style="margin-top: 5px; float: left;">카드추가</p>
			<div id="lay_pop_card_close"></div>
		</div>
		<div id="lay_pop_card_plus_input">
			<div id="lay_pop_card_com" class="lay_pop_card_impo_input">
				<p>카드사</p>
				<select name="bank" id="card_select" align="center" id="bank">
					<option value="국민">국민</option>
					<option value="농협">농협</option>
					<option value="기업">기업</option>
				</select>
			</div>
			<div id="lay_pop_card_num" class="lay_pop_card_impo_input">
				<p>카드번호</p>
				<div id="lay_pop_card_num_in_ping">
					<div>
						<input type="text" class="card_num_input" id="cardNumFirst"
							onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength="4" placeholder="1234">
					</div>
					<div class="card_num_input_-">-</div>
					<div>
						<input type="text" class="card_num_input" id="cardNumSecond"
							onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength="4" placeholder="1234">
					</div>
					<div class="card_num_input_-">-</div>
					<div>
						<input type="text" class="card_num_input" id="cardNumThird"
							onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength="4" placeholder="1234">
					</div>
					<div class="card_num_input_-">-</div>
					<div>
						<input type="text" class="card_num_input" id="cardNumFourth"
							onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength="4" placeholder="1234">
					</div>
				</div>
			</div>
			<div id="lay_pop_card_day" class="lay_pop_card_impo_input">
				<p>유효기간</p>
				<div ID="lay_pop_card_day_PING">
					<div class="lay_pop_card_day_PING_width">
						<input type="text" class="card_num_input dayday"
							id="validityMonth"
							onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength="2" placeholder="월(MM)">
					</div>
					<div class="card_num_input_sl">/</div>
					<div class="lay_pop_card_day_PING_width">
						<input type="text" class="card_num_input dayday" id="validityYear"
							onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength="2" placeholder="년(YY)">
					</div>
				</div>
			</div>
			<div id="lay_pop_card_pass" class="lay_pop_card_impo_input">
				<p>비밀번호</p>
				<div id="passwaor_card">
					<input type="password" class="card_num_input" id="cardPw"
						onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
						maxlength="2" placeholder="12">
				</div>
			</div>
		</div>
		<div id="card_shot">등록</div>
	</div>
	<div id="all_body"></div>
	<form id="qrcode">
		<input id="qrButton" type="submit" value="대여하기">
	</form>
	<script type="text/javascript" src="/js/Project_index_JS.js"></script>
	<!-- <script type="text/javascript" src="/js/index_js2.js"></script> -->
	<script type="text/javascript">
		/*    mapOption = {
		 center : new daum.maps.LatLng(vertical, horizontal), // 지도의 중심좌표
		 level : 3
		 };
		 map = new daum.maps.Map(mapContainer, mapOption);
		 */
	</script>
<script type="text/javascript" src="/js/QRcode.js"></script>
	<script src="/js/utils.js"></script>
	<script src="/js/map.js"></script>
	<script>
		stations = '${stations}';
		createMap();
	</script>

</body>
</html>