//var markerPosition; // 마커의 배열 배열
//var vertical; // 위도
//var horizontal; // 경도
//var map; //맵을 답기 위한 변수 입니다.
//
//
//	if(navigator.geolocation){  // if 문을 사용하지 않으면 GPS 인식부분이 멋대로 작동됨. 그래서 그 부분을 제어해주기 위해 if문 사용
//
//			navigator.geolocation.getCurrentPosition(function(position) {
//				//네비게이터가 작동되는 확인 , 확인 후 이벤트 발동
//				
//				vertical = position.coords.latitude;	// 위도 값을 vertical에 저장
//				horizontal = position.coords.longitude; // 경도 값을 horizontal에 저장
//				mapload(vertical,horizontal); //function mapload를 호출
//				
//				
//			});
//				}
//	
//
//		
//function mapload(vertical,horizontal){
//		//console.log로 확인 결과 따로 이벤트를 걸지 않으면 코드의 순서가 엉킴
//	
//	markerPosition = [ //이 부분이 마커의 배열 불러오는 부분
//		{	
//			content: '<div class="mark_impo">'
//					+'<div class="mark_impo_title">'
//					+'11'
//					+'</div>'
//					+'<div class="impo_address">'
//					+'동규 가양2동 흥룔로'
//					+'</div>'
//					+'<div class="mark_impo_ping">'
//					+'운영시간'
//					+'</div>'
//					+'<div class="mark_impo_bottom"></div>'
//					,
//			latlng: new daum.maps.LatLng(36.34836837342191, 127.44602483119736)
//		},
//		{
//			content:'<div class="mark_impo"><div class="mark_impo_title">22</div></div>',
//			latlng: new daum.maps.LatLng(35.34836837332180, 127.44602483119736)	
//		}
//		 ],
//		selectedMarker = null;
//
//var mapContainer = document.getElementById('map'), // 지도를 표시할 div
//		mapOption = {
//						center : new daum.maps.LatLng(vertical,horizontal), // 지도의
//						level : 3// 지도의 확대 레벨
//					};
//
//var nImg, cImg, oImg; //이미지 경로 및 설정 저장 변수
//
//
//imageSrc = '/img/mark_3.png'; //이미지 경로 지정
//imageSize = new daum.maps.Size(36, 42); // 마커이미지의
//imageOption = {
//	offset : new daum.maps.Point(18, 41)
//}; // 크기입니다
//cImg = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
////변수 안에 설정값 대입
//
//imageSrc = '/img/mark_0.png';
//imageSize = new daum.maps.Size(36, 42); // 마커이미지의
//imageOption = {
//	offset : new daum.maps.Point(18, 41)
//}; // 크기입니다
//markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
//
//nImg = markerImage;
//
//
//imageSrc = '/img/mark_1.png';
//imageSize = new daum.maps.Size(36, 42); // 마커이미지의
//imageOption = {
//	offset : new daum.maps.Point(18, 41)
//}; // 크기입니다
//oImg = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
//
//
//
//
//
//
//var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
//
//// 지도 위에 마커를 표시합니다
//for (var i = 0, len = markerPosition.length; i < len; i++) {
//	
//	var marker = new daum.maps.Marker({
//		map : map,
//		position : markerPosition[i].latlng,
//		image : nImg
//	});
//	
//	overlay = new daum.maps.CustomOverlay({
//		position : markerPosition[i].latlng, //
//		content : markerPosition[i].content
//	});
//	
//	console.log(markerPosition[i]);
//	// 마커를 생성하고 지도위에 표시합니다
////	addMarker(markerPosition[i]);
//	  daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker, overlay));
//	  daum.maps.event.addListener(map, 'click', mapClickListener(marker,overlay));
////	  daum.maps.event.addListener(marker, 'mouseover', makeOverListener(marker));
////	  daum.maps.event.addListener(marker, 'mouseout', makeOutListener(marker));
//
//}
//
////인포윈도우를 표시하는 클로저를 만드는 함수입니다 
//function makeClickListener(map, marker, overlay) {
//	
//    return function() {
//    	overlay.setMap(null);
//    	 overlay.setMap(map);
//    	 marker.setImage(cImg);
//    };
//}
//
//// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
//function mapClickListener(marker,overlay) {
//    return function() {
//    	 overlay.setMap(null);
//    	 marker.setImage(nImg);
//    };
//}
//
////인포윈도우를 표시하는 클로저를 만드는 함수입니다 
//function makeOverListener(marker) {
//    return function() {
//    	marker.setImage(oImg);
//    };
//}
//
//// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
//function makeOutListener(marker) {
//    return function() {
//    	marker.setImage(nImg);
//    };
//}
//
//}
//
//

