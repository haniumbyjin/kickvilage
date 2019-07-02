package com.eunhasu.kickvillage.service;

import java.util.HashMap;
import java.util.List;

import com.eunhasu.kickvillage.model.Kickboard;
import com.eunhasu.kickvillage.model.Station;

public interface ApiService {
	
	/**
	 * 정류소 추가하는 메소드
	 * @param stationName 필수 정류장 이름
	 * @param open 필수 정류장 운영시간
	 * @param locationX 필수 정류장 위도
	 * @param locationY 필수 정류장 경도
	 * @return Boolean 성공 여부
	 */
	boolean addStation(String stationName, String open, String locationX, String locationY);
	
	/**
	 * 정류소 리스트 가져오는 메소드
	 * @return List<Station> 정류소 리스트
	 */
	List<Station> getStationList();
	
	/**
	 * 특정 영역 안에 포함되어 있는 정류소의 리스트를 가져오는 메소드
	 * 남동 지점, 북서 지점의 두 좌표를 기준으로 그 안에 있는 정류소만 가져온다.
	 * @param SWX 남동 지점 위도 값
	 * @param SWY 남동 지점 경도 값
	 * @param NEX 북서 지점 위도 값
	 * @param NEY 북서 지점 경도 값
	 * @return List<Station> 정류소 리스트
	 */
	List<Station> getStationList(String SWX, String SWY, String NEX, String NEY);

	/**
	 * 정류소 수정하는 메소드
	 * @param stationNum 필수 정류장 번호
	 * @param stationName 필수 정류장 이름
	 * @param open 필수 정류장 운영시간
	 * @param locationX 필수 정류장 위도
	 * @param locationY 필수 정류장 경도
	 * @return Boolean 성공 여부
	 */
	boolean patchStation(int stationNum, String stationName, String open, String locationX, String locationY);
	
	/**
	 * 정류소 삭제하는 메소드
	 * @param stationNum 필수 정류장 번호
	 * @return Boolean 성공 여부
	 */
	boolean deleteStation(int stationNum);
	
	/**
	 * 정류소에 속한 킥보드 리스트 가져오는 메소드
	 * @param stationNum
	 * @return List<Kickboard>
	 */
	List<Kickboard> getKickboardList(int stationNum);

	
}
