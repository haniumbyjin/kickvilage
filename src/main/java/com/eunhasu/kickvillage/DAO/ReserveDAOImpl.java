package com.eunhasu.kickvillage.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eunhasu.kickvillage.Utils.RedisConfig;
import com.eunhasu.kickvillage.model.Reserve;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * redis, mysql에 접근하는 기능
 * 
 * @author xofla db에 접근하는 대여 관련 명령어들
 */
//redis 참고할 만한 사이트
//https://redis.io/
//https://bcho.tistory.com/654
@Repository
public class ReserveDAOImpl implements ReserveDAO {

	@Autowired
	SqlSession sql;

	@Override
	public String add(HashMap<String, String> map, String sendSerialNum) { // 고유번호를 key로해서 들어갈 정보들 map

		// redis 설정 가져오기 레디스 설정을 따로따로 써주는 이유는 쓰레드 문제 떄문이다.
		RedisConfig redisconfig = new RedisConfig();
		JedisPool pool = redisconfig.createRedis();
		Jedis jedis = pool.getResource();

		int serialNum = Integer.parseInt(sendSerialNum);
		// 데이터베이스에서 대여중인지 검색
		int re = sql.selectOne("Reserve.reservableCheck", serialNum);
		if (re == 1) {
			return "reserved";
		}

		// 제디스에서 예약된지 검색
		if (jedis.exists(sendSerialNum)) {
			return "reserved";
		} else {
			try {
				jedis.hmset(sendSerialNum, map);
				jedis.expire(sendSerialNum, 60 * 30); // 해당 입력하는 값은 초(sec) 단위입니다.
				return null;
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			} finally {
				if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
					jedis.close();
					pool.close();
				}
			}
		}
	}

	@Override
	public List<Object> myList(String userId) {
		// redis 설정 가져오기
		RedisConfig redisconfig = new RedisConfig();
		JedisPool pool = redisconfig.createRedis();
		Jedis jedis = pool.getResource();

		List<Object> reserveList = new ArrayList<Object>(); // 리턴시켜줄 리스트

		try {
			Set<String> keys = jedis.keys("*"); // Set<String> keys = 모든 키 ,jedis.keys("*")= 모든 키검색
			List<String> keyList = new ArrayList(keys); // keyList = jedis.keys("*") 모든 키담아줌
			Map<String, String> reMap = new HashMap<String, String>(); //

			for (int i = 0; i < keyList.size(); i++) { // 키값 만큼
				String strValue = null;
				List<String> valList = null; // 초기화
				strValue = keyList.get(i).toString(); // jedis.hvals에서 사용할 수 있도록 오브젝트인 key값을 string으로 형변환
				valList = jedis.hvals(strValue); // id 검색하게 키의 밸류 들 저장

				if (valList.contains(userId)) { // key로 검색해준것들중 useId와 같은지 비교
					reMap = jedis.hgetAll(strValue); // 키값으로 정보 가져오기
					reMap.put("serialNum", strValue); // 킥보드 고유 정보는 없으니까 넣어주기
					reserveList.add(reMap); // 가져온값들 리턴시킬 list 에 저장
				}
			}
			return reserveList;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedis.close();
				pool.close();
			}
		}
		return null;
	}

	@Override
	public String cancel(Reserve reserve) {
		// redis 설정 가져오기
		RedisConfig redisconfig = new RedisConfig();
		JedisPool pool = redisconfig.createRedis();
		Jedis jedis = pool.getResource();

		String serialNum = Integer.toString(reserve.getSerialNum());
		try {
			List<String> valList = jedis.hvals(serialNum); // redis에 담긴 value 값들만 가져오기
			if (valList.contains(reserve.getUserId())) { // value 값에서 아이디 검색
				jedis.del(serialNum); // 있으면 지우기
				return null;
			}
			return "notMe";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedis.close();
				pool.close();
			}
		}
	}

	@Override
	public String rental(Reserve reserve) {
		// redis 설정 가져오기
		RedisConfig redisconfig = new RedisConfig();
		JedisPool pool = redisconfig.createRedis();
		Jedis jedis = pool.getResource();

		String serialNum = Integer.toString(reserve.getSerialNum());
		try {
			// mysql에서 대여중인지 확인
			int sqlre = sql.selectOne("Reserve.myReserveCk", reserve);
			if (sqlre == 1) {
				return "use";
			}

			List<String> valList = jedis.hvals(serialNum); // 고유번호로 저장된 키값의 value들을 가져온다

			if (valList.contains(reserve.getUserId())) { // 자신의 예약이 맞는지 확인
				Map<String, String> re = jedis.hgetAll(serialNum); // 레디스에 가져온 값들 mysql에 넣어주기
				re.put("rentalDate", reserve.getRentalDate());
				sql.insert("Reserve.rental", re);
				jedis.del(serialNum);
				return null;
			}

			return "use";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedis.close();
				pool.close();
			}
		}

	}

	@Override
	public String getBack(Map<String, String> hash) {
		try {
			//대여했던 값들 저장
			sql.insert("Reserve.getBack", hash);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
	}

	@Override
	public String using(HashMap<String, String> map) {
		try {
			//대여했던 값들 저장
			sql.update("Reserve.using", map);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
	}
}
