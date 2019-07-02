package com.eunhasu.kickvillage.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.eunhasu.kickvillage.DAO.ReserveDAO;
import com.eunhasu.kickvillage.model.Reserve;
import com.mysql.jdbc.StringUtils;

/**
 * 값에대한 예외처리하는곳
 * 
 * @author xofla
 *
 */
@Service
public class ReserveServiceImpl implements ReserveService {

	@Resource
	ReserveDAO dao;

	// 예약 시간 설정
	SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
	String now = today.format(new Date());
	// 새로운 비밀번호 난수 생성

	public static String randamNum() {
		char pwCollection[] = new char[] { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D', 'E',
				'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
				'v', 'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')' };// 배열에 선언
		String randamNum = "";
		for (int i = 0; i < 10; i++) {
			int selectRandomPw = (int) (Math.random() * (pwCollection.length));// Math.rondom()은 0.0이상 1.0미만의 난수를 생성해
																				// 준다.
			randamNum += pwCollection[selectRandomPw];
		}
		return randamNum;
	}

	@Override
	public String add(Reserve reserve) {
		// 값이 비었는지 확인
		if (StringUtils.isNullOrEmpty(reserve.getUserId())) {
			return "noLogin";
		} else if (reserve.getSerialNum() == null) {
			return "noSerialNum";
		} else if (reserve.getRentalStationNum() == null) {
			return "noStationNum";
		} else if (reserve.getCardNum().isEmpty()) {
			return "noCard";
		} else if (reserve.getRentalFee() == null) {
			return "noRentalFee";
		}

		// 대여, 예약이 되있는지 확인하기위한 값 세팅
		HashMap<String, String> map = new HashMap<String, String>();
		String sendRentalStationNum = Integer.toString(reserve.getRentalStationNum());
		String sendSerialNum = Integer.toString(reserve.getSerialNum());
		String sendRentalFee = Integer.toString(reserve.getRentalFee());

		map.put("rentalStationNum", sendRentalStationNum);
		map.put("cardNum", reserve.getCardNum());
		map.put("rentalFee", sendRentalFee);
		map.put("userId", reserve.getUserId());
		map.put("reserveDate", now);

		String re = dao.add(map, sendSerialNum);
		if (re == "reserved") {
			return "reserved";
		} else if (re == null) {
			return null;
		} else {
			return "error";
		}
	}

	// 예약 페이지 리스트
	@Override
	public List<Object> myList(String userId) {
		List<Object> list = dao.myList(userId);
		return list;
	}

	@Override
	public String cancel(Reserve reserve) {
		// 값이 비었는지 확인
		if (reserve.getSerialNum() == null) {
			return "noSerialNum";
		} else if (reserve.getUserId().isEmpty()) {
			return "noUserId";
		}

		return dao.cancel(reserve);
	}

	@Override
	public String rental(Reserve reserve) {
		// 값이 비었는지 확인
		if (reserve.getUserId().isEmpty()) {
			return "noLogin";
		} else if (reserve.getSerialNum() == null) {
			return "noSerialNum";
		}
		reserve.setRentalDate(now);
		String re = dao.rental(reserve);
		if (re == "use") {
			return "use";
		}
		return null;

	}

	@Override
	public String getBack(Map<String, String> hash) {
		
		return dao.getBack(hash);
	}

	@Override
	public String using(HashMap<String, String> map) {
		return dao.using(map);
	}
}
