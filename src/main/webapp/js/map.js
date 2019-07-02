//**
//카카오 지도 생성하는 함수
function createMap() {
	// 기본적으로 은하수 본사를 중심한다.
	latitude = 36.34836837342191;
	longitude = 127.44602483119736;
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new daum.maps.LatLng(latitude, longitude), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	    
	};
	
	map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
	/*
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new daum.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	*/
	
	// 마커를 관리할 배열 생성
	marker = [];
	// 인포윈도우 객체 초기화
	customOverlay = null;
	
	// 정류소 리스트를 띄워줍니다.
	// 단, 정류소 리스트가 없으면 서버에서 가져옵니다.
	//stations = '${stations}';
	if(IsJsonString(stations)) {
		makeMarkers(JSON.parse(stations));
	} else {
		loadStations();
	}
	
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
		
		// 맵을 클릭할때 커스텀 오버레이 객체가 있으면 닫아버리기
		if(customOverlay != null) {
			customOverlay.setMap(null);
			customOverlay = null;
			return false;
		}
	    
	});
	
	// 사용자 현재 위치 가져오기
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			// 현재 사용자의 위치를 지도 중심점으로 넘겨서 중앙에 보여주기
			panTo(position.coords.latitude, position.coords.longitude);
		}, 
		function() {
			// 에러났을 때.
			// 위치를 못구했을 때는 지도 그냥 생성
			
		});
	}
	
}
function markerEvent(this_marker) {
	if(this_marker.data.kickboardCount > 0) {
		// 마커 호버 했을때 이벤트 등록
	    daum.maps.event.addListener(this_marker, 'mouseover', function() {
	    	var imageSrc = '/img/map_station.png',    
		    imageSize = new daum.maps.Size(36, 42),
		    imageOption = {
	        	spriteOrigin: new daum.maps.Point(0, 42), // 호버 마커
		    	spriteSize : new daum.maps.Size(36, 126)
		    };
			var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	        this_marker.setImage(markerImage);
	    });
	    // 마커 호버 아웃 했을때 이벤트 등록
	    daum.maps.event.addListener(this_marker, 'mouseout', function() {
	    	var imageSrc = '/img/map_station.png',    
		    imageSize = new daum.maps.Size(36, 42),
		    imageOption = {
		    	spriteOrigin: new daum.maps.Point(0, 0), // 파란 마커
		    	spriteSize : new daum.maps.Size(36, 126)
		    };
			var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	        this_marker.setImage(markerImage);
	    });
    }
	
	// 클릭했을 때 정류소 정보 보여주기
    daum.maps.event.addListener(this_marker, 'click', function() {
    	// 커스텀 오버레이 객체가 있으면 닫아버리기
		if(customOverlay != null) {
			customOverlay.setMap(null);
			customOverlay = null;
		}
    	
    	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    	var content = '<div class="mark_impo">'
			+'<div class="mark_impo_title">'
			+this_marker.data.stationName
			+'</div>'
			+'<div class="impo_address">'
			+'동규 가양2동 흥룔로'
			+'</div>'
			+'<div class="mark_impo_ping">'
			+'운영시간'
			+'<br />'
			+this_marker.data.open
			+'</div>'
			+'<div class="mark_impo_bottom"></div>';

    	// 커스텀 오버레이가 표시될 위치입니다 
    	var position = this_marker.getPosition();  

    	// 커스텀 오버레이를 생성합니다
    	customOverlay = new daum.maps.CustomOverlay({
    	    map: map,
    	    position: position,
    	    content: content,
    	    yAnchor: 1 
    	});
    	
    	var geocoder = new daum.maps.services.Geocoder();
    	var coord = this_marker.getPosition();
    	var callback = function(result, status) {
    	    if (status === daum.maps.services.Status.OK) {
    	    	var text = result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
    	    	$('.impo_address').text(text);
    	    }
    	};

    	geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    })
}


// 정류장 배열 가져오는 ajax 함수. 
// 마커 만드는 함수까지 호출함.
function loadStations() {
	$.ajax({
		url : '/api/stations',
		type : 'GET',
		dataType : 'json',
		success : function(data) {
			if(data.success) {
				
				var stations = data.stations;
				makeMarkers(stations);
				
			} else {
				alert('정류소 리스트를 가져오지 못했습니다.');
			}
			
		},
		error : function(err) {
			
		}
	})
}
// 배열로 지도에 마커 만들어주는 함수
function makeMarkers(stations) {
	
	var imageSrc = '/img/map_station.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(36, 42); // 마커이미지의 크기입니다
      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var blueMarker = new daum.maps.MarkerImage(imageSrc, imageSize, {
		// 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    	spriteOrigin: new daum.maps.Point(0, 0), // 파란 마커
    	//spriteOrigin: new daum.maps.Point(0, 42), // 호버 마커
    	//spriteOrigin: new daum.maps.Point(0, 84), // 회색 마커
    	spriteSize : new daum.maps.Size(36, 126)
    
    });
	var hoverMarker = new daum.maps.MarkerImage(imageSrc, imageSize, {
		// 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    	//spriteOrigin: new daum.maps.Point(0, 0), // 파란 마커
    	spriteOrigin: new daum.maps.Point(0, 42), // 호버 마커
    	//spriteOrigin: new daum.maps.Point(0, 84), // 회색 마커
    	spriteSize : new daum.maps.Size(36, 126)
    
    });
	var grayMarker = new daum.maps.MarkerImage(imageSrc, imageSize, {
		// 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    	//spriteOrigin: new daum.maps.Point(0, 0), // 파란 마커
    	//spriteOrigin: new daum.maps.Point(0, 42), // 호버 마커
    	spriteOrigin: new daum.maps.Point(0, 84), // 회색 마커
    	spriteSize : new daum.maps.Size(36, 126)
    });
	
	var len = stations.length;
	for(var i=0; i<len; i++) {
		var station = stations[i];
	    
	    // 마커 객체를 생성합니다.
	    var this_marker = new daum.maps.Marker({ 
		    position: new daum.maps.LatLng(station.locationX, station.locationY), // 마커 위치 설정
		    image: (station.kickboardCount > 0 ? blueMarker : grayMarker) // 마커이미지 설정 
		});
	    // 정류소에 킥보드가 있을 때만 마커 이벤트 등록
	    if(station.kickboardCount > 0) {
	    	
	    }
	    
	    
	    this_marker.setTitle(station.kickboardCount);

	    this_marker.setMap(map);
	    this_marker.data = {};
	    this_marker.data.stationNum 	= station.stationNum; // 마커 객체에 정류장 고유번호 저장
	    this_marker.data.stationName 	= station.stationName; // 마커 객체에 정류장 이름 저장
	    this_marker.data.kickboardCount = station.kickboardCount; // 마커 객체에 킥보드 개수 저장
	    this_marker.data.address 		= station.kickboardCount; // 마커 객체에 킥보드 개수 저장
	    this_marker.data.open 			= station.open; // 마커 객체에 정류소 운영시간
	    
	    markerEvent(this_marker);
	    
	    marker.push(this_marker);   
	}
}
// 지도에 올라와있는 마커 지우고 다시 생성
function resetMarkers() {
	for(var i = 0; i<marker.length;i++) {
		marker[i].setMap(null)
	}
	marker = [];
	loadStations();
}

//지도 확대

function zoomIn() {
	map.setLevel(map.getLevel() - 1);//레벨을 낮춤, 레벨이 작을 수로 화면이 확대 됨니다.
};
//지도 축소
function zoomOut() {
	map.setLevel(map.getLevel() + 1);//레벨을 높힘니다. 레벨이 높을 수록 확인이 축소되서 최종적으로 13레벨까지 됩니다.
};
// 현재 위치로 지도 이동
function currentPosition() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			// 현재 사용자의 위치를 지도 중심점으로 넘겨서 중앙에 보여주기
			panTo(position.coords.latitude, position.coords.longitude);
		}, 
		function() {
			// 에러났을 때.
			// 아무것도 안함.
		});
	}
}

function panTo(vertical, horizontal) {
	var moveLatLon = new daum.maps.LatLng(vertical, horizontal);// 이동할 위도 경도 위치를
																// 생성합니다
	map.panTo(moveLatLon);// 지도 중심을 부드럽게 이동시킵니다.
	// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다.
}
