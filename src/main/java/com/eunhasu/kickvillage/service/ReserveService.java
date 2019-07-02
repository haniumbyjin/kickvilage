package com.eunhasu.kickvillage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eunhasu.kickvillage.model.Reserve;

public interface ReserveService {
	
	/**
	 * 예약 추가, 30분 후 예약 취소 
	 * @param reserve 예약 날짜, 사용자아이디, 대여소 번호, 킥보드번호, 예약 유무 
	 * @return 성공여부
	 */
	String add(Reserve reserve);
	
	/**
	 * 예약 리스트 가져오기, 30분 후 예약 취소
	 * @param userId 
	 * @return List<Reserve> list2 변경된 예약 리스트 리턴
	 */
	List<Object> myList(String userId);
	
	/**
	 * 예약 취소
	 * 예약한 기록은 남겨둔 체로 예약 유무만 바꿔준다.
	 * @param reserve 예약 유무 변경
	 * @return dao 값 리턴 
	 */
	String cancel(Reserve reserve);
	
	/**
	 * 대여하기 
	 * @param reserve insert(예약없이 바로 대여) or update(예약 후 대여) 두가지 경우를 대비 다 넣어줌
	 * @return	error 값 리턴
	 */
	String rental(Reserve reserve);

	String getBack(Map<String, String> hash);

	String using(HashMap<String, String> map);

}
