<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/utils.js"></script>
<style>
.hide {
	display : none;
}

#stationInfo {
	width : 300px;
	height : 150px;
}


area[title]::after {
    content: attr(title);
    position: absolute;
    width: 36px;
    height: 42px;
    text-align: center;
    line-height: 35px;
    color: #FFF;
    font-size: 1.2em;
}
area[title]:hover::after {
    color : #2f7ffa;
}
</style>
<script>
//**
//카카오 지도 생성하는 함수
//@params latitude 지도 중심의 위도
//@params longitude 지도 중심의 경도
function createMap(latitude, longitude) {
	// 사용자가 중심점의 위도 경도를 입력하지 않으면 은하수 본사를 중심으로 사용한다.
	if(latitude == undefined && longitude == undefined) {
		latitude = 36.34836837342191;
		longitude = 127.44602483119736;
	}
	
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
	infoWindow = null;
	
	// 정류소 리스트를 띄워줍니다.
	// 단, 정류소 리스트가 없으면 서버에서 가져옵니다.
	var stations = '${stations}';
	if(IsJsonString(stations)) {
		makeMarkers(JSON.parse(stations));
	} else {
		loadStations();
	}
	
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
		
		// 맵을 클릭할때 인포윈도우 객체가 있으면 닫아버리기
		if(infoWindow != null) {
			infoWindow.close();
			infoWindow = null;
			resetMarkers(); // 인포윈도우 닫을때 마커 초기화 하는건 관리자 페이지에서만! 일반 사용자는 마커를 컨트롤할수 없기 때문에 이 기능이 필요 없음.
			return false;
		}
	    
		// 여기서부터 아래까지 관리자 페이지에서만! 
		
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    var imageSrc = '/img/map_station.png', // 마커이미지의 주소입니다    
	    imageSize = new daum.maps.Size(36, 42), // 마커이미지의 크기입니다
	    imageOption = {
	    	spriteOrigin: new daum.maps.Point(0, 0), // 파란 마커
	    	//spriteOrigin: new daum.maps.Point(0, 42), // 호버 마커
	    	//spriteOrigin: new daum.maps.Point(0, 84), // 회색 마커
	    	spriteSize : new daum.maps.Size(36, 126)
	    
	    }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	    
	    // 마커 객체를 생성합니다.
	    var this_marker = new daum.maps.Marker({ 
		    position: latlng, // 마커 위치 설정
		    image: markerImage // 마커이미지 설정 
		});
	    
	 	// 마커 이벤트 등록
	    markerEvent(this_marker);
	    
	 	// 마커 관리 배열에 새로 만든 마커 등록
	    marker.push(this_marker);
	    
	    // 마커 생성하자마자 팝업 생성
	    var station = document.getElementById("stationInfo").cloneNode(true);
    	console.log(this_marker.getPosition());
    	console.log(this_marker.getPosition().getLat());
    	station.querySelector('input[name=locationX]').value = this_marker.getPosition().getLat();
    	station.querySelector('input[name=locationY]').value = this_marker.getPosition().getLng();
    	
    	station = document.importNode(station, true);
    	
    	// 지도에 올릴 장소명 인포윈도우 입니다.
    	infoWindow = new daum.maps.InfoWindow({
    	    position: this_marker.getPosition(), // 클릭한 마커의 위치에 추가
    	    content: station, // 인포윈도우 내부에 들어갈 컨텐츠 입니다.
    	});
    	infoWindow.open(map, this_marker); // 지도에 올리면서, 두번째 인자로 들어간 마커 위에 올라가도록 설정합니다.
	    
	    this_marker.setMap(map);
	    this_marker.data = {};
	    //this_marker.data.stationId = Math.random(); // 마커 객체에 정류장 고유번호 저장
	    
	    
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    
	    console.log(message);
	    
	});
	
	
}

function markerEvent(this_marker) {
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
    
 	// 관리자 페이지 전용 기능
    function patchStationInfoWindow() {
    	var station = document.getElementById("stationInfo_update").cloneNode(true);
    	
    	station.dataset.stationNum = this_marker.data.stationNum
     	station.querySelector('input[name=stationName]').value = this_marker.data.stationName;
     	station.querySelector('input[name=locationX]').value = this_marker.getPosition().getLat();
     	station.querySelector('input[name=locationY]').value = this_marker.getPosition().getLng();
     	
     	station = document.importNode(station, true);
     	
     	if(infoWindow != null) {
			infoWindow.close();
			infoWindow = null;
		}
     	// 지도에 올릴 장소명 인포윈도우 입니다.
     	infoWindow = new daum.maps.InfoWindow({
     	    position: this_marker.getPosition(), // 클릭한 마커의 위치에 추가
     	    content: station, // 인포윈도우 내부에 들어갈 컨텐츠 입니다.
     	});
     	infoWindow.open(map, this_marker); // 지도에 올리면서, 두번째 인자로 들어간 마커 위에 올라가도록 설정합니다.
    }
    
    this_marker.setDraggable(true); // 드래그 가능하도록 설정
    // 마커 드래그 했을때 이벤트
    daum.maps.event.addListener(this_marker, 'dragend', patchStationInfoWindow);
 	// 마커 클릭 했을때 이벤트
    daum.maps.event.addListener(this_marker, 'click', patchStationInfoWindow);
}

</script>

<!-- 우리 프로젝트에서 만든 함수들 -->
<script>
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
		var len = stations.length;
		for(var i=0; i<len; i++) {
			var station = stations[i];
			
			
			var imageSrc = '/img/map_station.png', // 마커이미지의 주소입니다    
		    imageSize = new daum.maps.Size(36, 42), // 마커이미지의 크기입니다
		    imageOption = {
		    	spriteOrigin: new daum.maps.Point(0, 0), // 파란 마커
		    	//spriteOrigin: new daum.maps.Point(0, 42), // 호버 마커
		    	//spriteOrigin: new daum.maps.Point(0, 84), // 회색 마커
		    	spriteSize : new daum.maps.Size(36, 126)
		    
		    }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		      
			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
		    
		    // 마커 객체를 생성합니다.
		    var this_marker = new daum.maps.Marker({ 
			    position: new daum.maps.LatLng(station.locationX, station.locationY), // 마커 위치 설정
			    image: markerImage // 마커이미지 설정 
			});
		    // 마커 이벤트 등록
		    markerEvent(this_marker);
		    
		    this_marker.setTitle(station.kickboardCount);

		    this_marker.setMap(map);
		    this_marker.data = {};
		    this_marker.data.stationNum 	= station.stationNum; // 마커 객체에 정류장 고유번호 저장
		    this_marker.data.stationName 	= station.stationName; // 마커 객체에 정류장 이름 저장
		    
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
</script>

<!-- 관리자 페이지에서만 사용하는 함수들 -->
<script>
	function addStation(_this) {
		var infoDom = $(_this).parent();
		
		var stationName = $(' input[name=stationName]', infoDom).val();
		var open 		= $(' input[name=open]', infoDom).val();
		var locationX 	= $(' input[name=locationX]', infoDom).val();
		var locationY 	= $(' input[name=locationY]', infoDom).val();
		
		if(stationName == "") {
			alert('정류장 이름이 비었습니다.');
			return false;
		}
		if(open == "") {
			alert('운영시간이 비었습니다.');
			return false;
		}
		if(locationX == "") {
			alert('위도가 비었습니다.');
			return false;
		}
		if(locationY == "") {
			alert('경도가 비었습니다.');
			return false;
		}
		
		if(infoWindow != null) {
			infoWindow.close();
			infoWindow = null;
		}
		
		$.ajax({
			url : '/api/station',
			type : 'post',
			dataType : 'json',
			data : {
				stationName : stationName,
				open : open,
				locationX : locationX,
				locationY : locationY,
			},
			success : function(data) {
				if(data.success) {
					alert('정류소 등록에 성공했습니다.');
					resetMarkers();
				} else {
					alert('정류소 등록에 실패했습니다.');
				}
				
			},
			error : function(err) {
				
			}
		})
	}
	
	function patchStation(_this) {
		var infoDom = $(_this).parent();
		
		var stationName = $(' input[name=stationName]', infoDom).val();
		var open 		= $(' input[name=open]', infoDom).val();
		var locationX 	= $(' input[name=locationX]', infoDom).val();
		var locationY 	= $(' input[name=locationY]', infoDom).val();
		
		if(stationName == "") {
			alert('정류장 이름이 비었습니다.');
			return false;
		}
		if(open == "") {
			alert('운영시간이 비었습니다.');
			return false;
		}
		if(locationX == "") {
			alert('위도가 비었습니다.');
			return false;
		}
		if(locationY == "") {
			alert('경도가 비었습니다.');
			return false;
		}
		
		if(infoWindow != null) {
			infoWindow.close();
			infoWindow = null;
		}
		
		$.ajax({
			url : '/api/station/'+infoDom.data('stationNum'),
			type : 'patch',
			dataType : 'json',
			data : {
				stationName : stationName,
				open : open,
				locationX : locationX,
				locationY : locationY,
			},
			success : function(data) {
				if(data.success) {
					alert('정류소 수정에 성공했습니다.');
					resetMarkers();
				} else {
					alert('정류소 수정에 실패했습니다.');
					resetMarkers();
				}
				
			},
			error : function(err) {
				
			}
		})
	}
</script>
</head>
<body>

<div id="map" style="width:100%;height:700px;"></div>

<!-- 어떤 커밋 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=740c3aa706359cd7ac35245220614ec1"></script>

<script>

// 사용자 현재 위치 가져오기
if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(function(position) {
		// 현재 사용자의 위치를 지도 중심점으로 넘겨서 중앙에 보여주기
		createMap(position.coords.latitude, position.coords.longitude);
	}, 
	function() {
		// 에러났을 때.
		// 위치를 못구했을 때는 지도 그냥 생성
		createMap();
	});
}
</script>
<div class="hide">
	<div id="stationInfo">
		<div>
			<span>정류장 이름</span>
			<input type="text" name="stationName" />
		</div>
		<div>
			<span>영업 시간</span>
			<input type="text" name="open" value="평일(24시), 주말(24시), 공휴일(24시)" />
		</div>
		<div>
			<span>위도</span>
			<input type="text" name="locationX" />
		</div>
		<div>
			<span>경도</span>
			<input type="text" name="locationY" />
		</div>
		<button data-action="submit" onclick="addStation(this)">정류장 저장</button>
	</div>
	<div id="stationInfo_update">
		<div>
			<span>정류장 이름</span>
			<input type="text" name="stationName" />
		</div>
		<div>
			<span>영업 시간</span>
			<input type="text" name="open" value="평일(24시), 주말(24시), 공휴일(24시)" />
		</div>
		<div>
			<span>위도</span>
			<input type="text" name="locationX" />
		</div>
		<div>
			<span>경도</span>
			<input type="text" name="locationY" />
		</div>
		<button data-action="submit" onclick="patchStation(this)">정류장 수정</button>
	</div>
	
</div>

</body>
</html>