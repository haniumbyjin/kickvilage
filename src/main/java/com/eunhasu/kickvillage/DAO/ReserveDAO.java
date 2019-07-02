package com.eunhasu.kickvillage.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eunhasu.kickvillage.model.Reserve;

public interface ReserveDAO {

	/**
	 * 에약 하기, 예약된 킥보드인지 체크하는 기능
	 * 
	 * @param map           key 값안에 들어갈 정보들
	 * @param sendSerialNum 예약할때 넣어줄 key값
	 * @param userId
	 * @return 의도한 값이 맞는지에 대한 예외 리턴
	 */
	String add(HashMap<String, String> map, String sendSerialNum);

	/**
	 * 예약, 대여중, 반납한 킥보드 리스트 가져오는 기능
	 * 
	 * @param userId 나의 리스트만 가져오기위한 아이디값
	 * @return 리스트 리턴
	 */
	List<Object> myList(String userId);

	/**
	 * 예약한 킥보드 리스트 취소할수있는 기능
	 * 
	 * @param reserve userId, serialNum 등이 들어가있음
	 * @return 의도한 값이 맞는지에 대한 예외 리턴
	 */
	String cancel(Reserve reserve);

	/**
	 * 대여 시작할 수 있는 기능
	 * 
	 * @param reserve userId, serialNum 등이 들어가있음
	 * @return 의도한 값이 맞는지에 대한 예외 리턴
	 */
	String rental(Reserve reserve);

	/**
	 * 바납하면서 데이터베이스에 내역저장
	 * @param hash
	 * @return
	 */
	String getBack(Map<String, String> hash);

	String using(HashMap<String, String> map);

}
