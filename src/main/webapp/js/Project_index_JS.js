$('#search_controler_butten_close').click(function() {
	$('#all_search_Ping').css('right', '-400px');
	$('#search_controler_butten_close').css('display', 'none');
	$('#search_controler_butten_open').css('display', 'block');
});/* 검색창(컨트롤) 영역 닫기 */
$('#search_controler_butten_open').click(function() {
	$('#all_search_Ping').css('right', '0px');
	$('#search_controler_butten_open').css('display', 'none');
	$('#search_controler_butten_close').css('display', 'block');
});/* 검색창(컨트롤) 영역 열기 */
/*
 * $('.stop_list_open').on('click', function(){ var 자손 = $(' > #asdf', this);
 * 자손.css();
 */
// 대여소 리스트 가져오기, 킥보드 카운트
function kickboardList(stationNum) {
	$('#result_Ping').css('right', '402px');
	$('.stop_ping').css('overflow-y', 'hidden');

	$
			.ajax({
				url : '/api/station/' + stationNum,
				type : 'GET',
				dataType : 'JSON',
				data : {
					stationNum : stationNum
				},
				success : function(data) {
					var html = "";
					var html2 = "";
					if (data.error == "error") {
						html += "<p>데이터베이스 오류입니다. 관리자에게 문의하시게</p>";
					}
	
					if (data.kickboards.length >=0) {
						html2 += "<div id='stop_title_address'>";
						html2 += "<div class='stop_title_P'>"
								+ data.kickboards[0].stationName + "</div>";
						html2 += "<div class='address_title'>주소</div>";
						html2 += "</div>";
					
						for (var i = 0; i < data.kickboards.length; i++) {
						
								html += "<div class='kickbord_list'>";
								html += "<div class='kickbored_ID'>";
								html += "<div class='kickbored_list_ID'>"
										+ data.kickboards[i].serialNum
										+ "전동킥보드</div>";
								html += "<div class='kickbored_list_time_fee'>";
								html += "<div class='kickbored_list_time'>"
										+ data.kickboards[i].batteryCondition
										+ "</div>";
								html += "<div class='kickbored_list_fee'>4000</div>";
								html += "</div>";
								html += "</div>";
								html += "<div class='reservation' onclick='cardList("
										+ data.kickboards[i].serialNum
										+ ","
										+ data.kickboards[i].stationNum
										+ ","
										+ "&#34"
										+ data.kickboards[i].stationName
										+ "&#34" + ")'>예약하기</div>";
								html += "</div>"
						}
					} else {
						html += "<div class='kickbored_ID'>";
						html += "<div class='kickbored_list_ID'>사용가능한 킥보드가 없습니다.</div>";
						html += "</div>";
					}
					$("#stop_title_address").html(html2);
					$("#list_JM").html(html);

				},
				error : function(err) {
					console.log(err);
				}
			});
	var stop = $(' > .stop_title', this).text();
};
$('.back').on('click', function() {
	$('#result_Ping').css('right', '0px');
	$('.stop_ping').css('overflow-y', 'scroll');
});
$('#stop_title_address').on('click', function() {
	$('#result_Ping').css('right', '0px');
	$('.stop_ping').css('overflow-y', 'scroll');
});

/* 정류소 클릭시 정류소 안에 리스트 펼치기 */
$('.stop_list').on('click', function() {
	return false;
});
var length = $(".stop").length;
$("#result").html("검색결과 : " + length).css("background-color", "white");

var reservation;
var list_get;
var cardSelect;

$(".kickbord_list").on("mouseenter", function() {
	var listHover = $(' > .reservation', this);
	listHover.css('background-color', '#2d80f6').css('color', '#fff');
});
$(".kickbord_list").on("mouseleave", function() {
	var listHover = $(' > .reservation', this);
	listHover.css('background-color', '#fff').css('color', '#2d80f6');
});
//카드 선택하고 나서 바귐
function card(cardNum){
	//onclick 속성을 먼저 실행해 줘야 작동함
	$('#cardNum'+cardNum).removeAttr("onclick");
	$('#cardNum'+cardNum).attr("onclick", "selectCard("+cardNum+");");
	
	//클릭시 배경색
	$('#cardNum'+cardNum).css("background-color","#2d80f6");
	$('#cardNum'+cardNum).attr('id',"selectCard"+cardNum);
	
	//카드값 저장시켜둘 공간
	$("#saveNum"+cardNum).attr('id','selectedSaveNum');
	
	
}

//카드 선택하고 취소
function selectCard(cardNum){
	//onclick 속성을 먼저 실행해 줘야 작동함
	$("#selectCard"+cardNum).removeAttr("onclick");
	$("#selectCard"+cardNum).attr("onclick", "card("+cardNum+");");
	
	//클릭시 배경색
	$("#selectCard"+cardNum).css("background-color","#fff");
	$("#selectCard"+cardNum).attr('id','cardNum'+cardNum);
	
	//카드값 저장시켜둘 공간
	$('#selectedSaveNum').attr('id',"saveNum"+cardNum);
	

}

// 카드 리스트
function cardList(serialNum, stationNum, stationName) {
	$.ajax({
				url : "/card/ajaxList",
				type : "GET",
				success : function(data) {
					if (data.error == "noLogin") {
						alert('로그인이 필요한 서비스입니다.');
					} else {
						// 카드 리스트 부분
						var cardList = "";
						for (var i = 0; data.list.length > i; i++) {
							// 카드 정보 리스트 부분
							cardList += "<div class='card' id='cardNum"+data.list[i].cardNum+"' onclick='card("+data.list[i].cardNum+")'>";
							cardList += "<div class='card_bank' id='saveNum"+data.list[i].cardNum+"'>"+data.list[i].cardNum+"</div>";
							cardList += "<div class='card_bank'></div>";
							cardList += "<div class='Account_Number'>" // 카드 번호
							// 를 표시
									+ data.list[i].cardNumFirst + "&#32;"
									+ data.list[i].cardNumSecond + "&#32;"
									+ data.list[i].cardNumThird + "&#32;"
									+ "****" + "</div>";
							cardList += "</div>";
						}

						// 창 띄우기
						list_get = $(this);
						reservation = $(' > .reservation', this);
						var $width = parseInt($("#lay_pop").css("width"));
						var $height = parseInt($("#lay_pop").css("height"));

						var sctop = $(window).scrollTop() * 2;
						var top = ($(window).height() - $height + sctop) / 2;
						var height = document.getElementsByTagName("body")[0].scrollHeight;

						var length = $(".stop_title_P").text();
						var kickID = $('.kickbored_list_ID', this).text();
						/* ---------------------------------------------- */

						// 상단에 대여소 이름, 주소 보이는 곳
						var html = "";
						html += "<span id='POP_address_1' class='POP_address_all' >킥보드   </span>";
						html += "<span	id='serialNum' class='POP_address_all' >"
								+ serialNum + "</span>";
						html += "<span id='POP_address_2' class='POP_address_all' >  정류소   </span>";
						html += "<span id='stationNum' class='POP_address_all' id='stationNum' >"
								+ stationNum + "</span>";
						html += "<span id='stationName' class='POP_address_all' id='stationName' >&#32;"
								+ stationName + "</span>";

						$("#POP_address").html(html);
						/*-----------------------------------------------------------------------------------------------*/

						$("#lay_pop").css("top", top);
						$("#lay_pop").css("display", "block");
						$("#lay_pop").css("z-index", "555");
						$("#all_body").css("display", "block");

						$('#price_1ho').css('background-image',
								'url(/img/check02.png)');
						$('#price_2ho').css('background-image',
								'url(/img/check02.png)');
						$('#price_result').html("결제 방식과 대여 시간을 선택해주세요.");

					}

					if (data.list.length >= 2) {
						$("#card_Ping").html(cardList);
					} else {
						var addbutton = "";
						// 카드 추가 버튼 부분 : 카드 번호등 입력하는 팝업창 하나 생성
						cardList += "<div id='card_none_plus' onclick='popCard()' class='card'>";
						cardList += "<div id='card_plus'></div>";
						cardList += "<div id='card_plus_title'>카드추가</div>";
						cardList += "</div>";

						// 카드 추가 설명 하는 부분
						cardList += "<div id='card_Explanation'>";
						cardList += "<span style='color:#cd1b1b;'>*</span><span> 카드는 2개까지</span><br /><span style='margin-left: 10px;'>추가 할 수 있습니다.</span>";
						cardList += "</div>";
						$("#card_Ping").html(cardList);
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
}

var value;
$('#payment').on('click',function(){
	var cardNum = $('#selectedSaveNum').text();
	
	var serialNum =$('#serialNum').text();

	var stationNum =$('#stationNum').text();

	var rentalFee = $('#rentalFee').val();


			$.ajax({
				url : '/reserve/add',
				type : 'POST',
				dataType : 'JSON',
				data : {
					"rentalStationNum" : stationNum,
					"serialNum" : serialNum,
					"card" : cardNum,
					"rentalFee" : rentalFee
					
				},
				success : function(data) {
					if (data.result == "reserved") {
						alert('이미 예약된 킥보드입니다.');
					}else if (data.result =="success") {
						alert('예약되었습니다.');
						location.href = "/";
					} else{
						alert('데이터베이스 오류입니다.');
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
			
		});

function layerClose(lay1, lay2) {
	$("#" + lay1).css("display", "none");
	$("#" + lay2).css("display", "none");
	reservation.addClass("reservation_on").removeClass("reservation");
	$('#price_1ho').css('background-image', 'url(/img/check02.png)')
			.removeClass("on").addClass("off");
	$('#price_2ho').css('background-image', 'url(/img/check02.png)')
			.removeClass("on").addClass("off");
	reservation.addClass("reservation").removeClass("reservation_on");
	reservation.css('background-color', '#fff').css('color', '#2d80f6');
}
$('#price_1ho').on(
		'click',
		function() {
			var html ="";
			$('#price_2ho').css('background-image', 'url(/img/check02.png)')
					.removeClass("on").addClass("off");
			$('#price_1ho').css('background-image', 'url(/img/check01.png)')
					.addClass("on").removeClass("off");
			html += "<span>1시간 대여 </span>";
			html += "<input id='rentalFee' readonly value='5000'></sapan>";
			html += "<span>원 결제합니다.</span>";
			$('#price_result').html(html);
		});
$('#price_2ho').on(
		'click',
		function() {
			var html ="";
			$('#price_1ho').css('background-image', 'url(/img/check02.png)')
					.removeClass("on").addClass("off");
			$('#price_2ho').css('background-image', 'url(/img/check01.png)')
					.addClass("on").removeClass("off");
			html += "<span>2시간 대여 </span>";
			html += "<input id='rentalFee' readonly value='10000'></sapan>";
			html += "<span>원 결제합니다.</span>";
			$('#price_result').html(html);
		});

// 카드 추가하는 부분 팝업
function popCard() {
	$("#lay_pop_card_plus").css("display", "block");
	$("#lay_pop_card_body").css("display", "block");
}

$('#lay_pop_card_close').on("click", function() {
	$("#lay_pop_card_plus").css("display", "none");
	$("#lay_pop_card_body").css("display", "none");
});
// 카드 등록하는 부분
$('#card_shot').on(
		"click",
		function() {
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : '/card/add',
				data : {
					bank : $('#bank').val(),
					cardNumFirst : $('#cardNumFirst').val(),
					cardNumSecond : $('#cardNumSecond').val(),
					cardNumThird : $('#cardNumThird').val(),
					cardNumFourth : $('#cardNumFourth').val(),
					validityMonth : $('#validityMonth').val(),
					validityYear : $('#validityYear').val(),
					cardPw : $('#cardPw').val()
				},
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
						cardList($("#serialNum").text(), $("#stationNum")
								.text(), $("#stationName").text());
						$("#lay_pop_card_plus").css("display", "none");
						$("#lay_pop_card_body").css("display", "none");
					} else {
						alert('데이터베이스 오류입니다.');
					}
				},
				error : function(error) {
					console.log(error);
				}
			});

		});
$("#mobibleControll, #controler > button").on('click', function() {
	var list = $("#all_search_Ping");
	if (list.hasClass("open")) {
		list.removeClass("open");
	} else {
		list.addClass("open");
	}
});
$('.kickbord_list').on('click', function() {

	list_get = $(this);
	reservation = $(' > .reservation', this);

	var $width = parseInt($("#lay_pop").css("width"));
	var $height = parseInt($("#lay_pop").css("height"));

	var sctop = $(window).scrollTop() * 2;
	var top = ($(window).height() - $height + sctop) / 2;
	var height = document.getElementsByTagName("body")[0].scrollHeight;

	var length = $(".stop_title_P").text();
	var kickID = $('.kickbored_list_ID', this).text();
	if (reservation.css('background-color') == 'rgb(45, 128, 246)') {
		console.log("<<<");

		$("#lay_pop").css("top", top);
		$("#lay_pop").css("display", "block");
		$("#lay_pop").css("z-index", "555");
		$("#all_body").css("display", "block");

		reservation.addClass("reservation_on").removeClass("reservation");
		$('#price_1ho').css('background-image', 'url(/img/check02.png)');
		$('#price_2ho').css('background-image', 'url(/img/check02.png)');
		$('#price_result').html("결제 방식과 대여 시간을 선택해주세요.");
		cardSelect.addClass("card_select").removeClass("card_select_on");
	} else {
		window.alert("선택하신 킥보드는 이미 예약이 완료된 상태입니다.");
	}
});

var value;
function layerClose(lay1, lay2) {
	$("#" + lay1).css("display", "none");
	$("#" + lay2).css("display", "none");
	reservation.addClass("reservation_on").removeClass("reservation");
	$('#price_1ho').css('background-image', 'url(/img/check02.png)')
			.removeClass("on").addClass("off");
	$('#price_2ho').css('background-image', 'url(/img/check02.png)')
			.removeClass("on").addClass("off");
	reservation.addClass("reservation").removeClass("reservation_on");
	reservation.css('background-color', '#fff').css('color', '#2d80f6');
}
$("#card_none_plus").on("click", function() {
	console.log("test");
	$("#lay_pop_card_plus").css("display", "block");
	$("#lay_pop_card_body").css("display", "block");

})
$('#lay_pop_card_close').on("click", function() {
	$("#lay_pop_card_plus").css("display", "none");
	$("#lay_pop_card_body").css("display", "none");
});
$('#card_shot').on("click", function() {
	$("#lay_pop_card_plus").css("display", "none");
	$("#lay_pop_card_body").css("display", "none");
})

function isMoblie() {
	return $('body').width() <= 1024 ? true : false; 
}

// 처음 한번만 실행하는 코드
$(function() {
	
	if(!isMoblie()) {
		$("#all_search_Ping").addClass("open");
	}
})
