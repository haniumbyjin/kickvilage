# API Document

kickvillage 서버에서 지원하는 API 목록이다.

- 정류소
	- [정류소 리스트](#정류소-리스트)
	- [정류소 추가](#정류소-추가)
	- [정류소 수정](#정류소-수정)
	- [정류소 삭제](#정류소-삭제)
- 킥보드
	- [킥보드 리스트](#킥보드-리스트)


- - -

### 정류소 리스트
```
GET /api/station
GET /api/stations
GET /api/station/list
```
정류소를 추가하는 api입니다.

아래와 같은 값들을 파라매터로 전달해야 합니다.

특정 영역 안에 있는 정류소 리스트만 가져오고 싶으면 해당 영역의 북서 지점과 남동 지점의 GPS 좌표 값(SWX, SWY, NEX, NEY 값)을 전달하면 됩니다.
 
하나라도 전달되지 않을 경우 모든 정류소 리스트가 리턴됩니다.

**[Request]**

키|타입|필수 여부|설명
:--- | :---: | :---: | :---
SWX|String|N|북서 지점 GPS 위도 값
SWY|String|N|북서 지점 GPS 경도 값
NEX|String|N|남동 지점 GPS 위도 값
NEY|String|N|남동 지점 GPS 경도 값

**[Response]**

키|타입|설명
:---|:---:|:---
success|bealoon|성공 여부
stations|Array|정류소 리스트를 포함하고 있는 배열입니다.
 ┕ stationNum|int|정류소 번호
 ┕ stationName|String|정류소 이름
 ┕ locationX|String|정류소 위도 값
 ┕ locationY|String|정류소 경도 값
 ┕ open|String|정류소 운영시간
 ┕ kickboardCount|int|정류소에 주차된 킥보드 개수
- - -


### 정류소 추가
```
POST /api/station
```
정류소를 추가하는 api입니다.
관리자 권한이 필요한 api입니다. 관리자 로그인 후 호출해주세요.

아래와 같은 값들을 파라매터로 전달해야 합니다.

**[Request]**

키|타입|필수 여부|설명
:---|:---:|:---:|:---
stationName|String|Y|정류소 이름
open|String|Y|정류소 운영 시간
locationX|String|Y|정류소 위도 값
locationY|String|Y|정류소 경도 값

**[Response]**

키|타입|설명
:---|:---:|:---
success|bealoon|성공 여부
message|String|API 실패시 실패 사유를 사람이 읽을 수 있는 문자열로 리턴합니다.
- - -


### 정류소 수정
```
PATCH /api/station/{stationNum}
```
정류소를 수정하는 api입니다.
관리자 권한이 필요한 api입니다. 관리자 로그인 후 호출해주세요.

아래와 같은 값들을 파라매터로 전달해야 합니다.

**[Request]**

키|타입|필수 여부|설명
:---|:---:|:---:|:---
stationNum|String|Y|정류소 번호 **(URL로 전달해야 함.)**
stationName|String|Y|정류소 이름
open|String|Y|정류소 운영 시간
locationX|String|Y|정류소 위도 값
locationY|String|Y|정류소 경도 값

**[Response]**

키|타입|설명
:---|:---:|:---
success|bealoon|성공 여부
message|String|API 실패시 실패 사유를 사람이 읽을 수 있는 문자열로 리턴합니다.
- - -


### 정류소 삭제
```
DELETE /api/station/{stationNum}
```
정류소를 삭제하는 api입니다.
관리자 권한이 필요한 api입니다. 관리자 로그인 후 호출해주세요.

아래와 같은 값들을 파라매터로 전달해야 합니다.

**[Request]**

키|타입|필수 여부|설명
:---|:---:|:---:|:---
stationNum|String|Y|정류소 번호 **(URL로 전달해야 함.)**

**[Response]**

키|타입|설명
:---|:---:|:---
success|bealoon|성공 여부
message|String|API 실패시 실패 사유를 사람이 읽을 수 있는 문자열로 리턴합니다.
- - -


### 킥보드 리스트
```
GET /api/station/{stationNum}
```
특정 정류소에 주차된 킥보드 리스트를 가져오는 API입니다.

아래와 같은 값들을 파라매터로 전달해야 합니다.

**[Request]**

키|타입|필수 여부|설명
:---|:---:|:---:|:---
stationNum|String|Y|정류소 번호 **(URL로 전달해야 함.)**

**[Response]**

키|타입|설명
:---|:---:|:---
success|bealoon|성공 여부
kickboards|Array|킥보드 리스트를 포함하고 있는 배열입니다.
 ┕ serialNum|int|킥보드 고유번호
 ┕ stationNum|int|정류소 번호