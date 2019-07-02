package com.eunhasu.kickvillage.controller;

import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eunhasu.kickvillage.Utils.RedisConfig;
import com.eunhasu.kickvillage.service.ReserveService;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * 예약 페이지 add,list,cancle,rental
 * 
 * @author xofla
 */
@Controller
@RequestMapping(value = { "/reserve", "/reserve/" })
public class ReserveController {
	// 지금 날짜 시간 기록하는 함수
	public String date() {
		SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		String now = today.format(new Date());
		return now;
	}

	// 제디스 설정 함수
	public Jedis jedisConfig() {
		RedisConfig redisconfig = new RedisConfig();
		JedisPool pool = redisconfig.createRedis();
		Jedis jedis = pool.getResource();
		return jedis;
	}

	// 램덤 qr코드 짜는 함수
	public String randomNum() {
		final Random r = new SecureRandom();
		byte[] salt = new byte[32];
		r.nextBytes(salt);
		String encodedSalt = Base64.encodeBase64String(salt);
		return encodedSalt;
	}

	// 공통으로 쓸 uri 등록
	String path = "reserve";

	// service 연결
	@Resource
	ReserveService service;

	// 예약 페이지 보여주기, 지도 부분
	@RequestMapping(value = { "", "/" })
	public String reserve() {
		return "index";
	}

	// 예약 추가
	@RequestMapping(value = { "/add", "/add/" }, method = RequestMethod.GET)
	public String addGet(HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/mypage/login";
		}
		return path + "/add";
	}

	/**
	 * 예약 추가
	 * 
	 * @param rentalStationNum 대여할 대여소 번호
	 * @param serialNum        대여할 킥보드 번호
	 * @param cardNum          mysqlDB 에 저장되어있는 결재할 카드 고유번호
	 * @param rentalFee        결재할 비용
	 * @param session          아이디가져올 세션
	 * @return json 성공여부들어갈 제이슨 리턴
	 */
	@ResponseBody
	@RequestMapping(value = { "/add", "/add/" }, method = RequestMethod.POST)
	public JSONObject addPost(@RequestParam(value = "rentalStationNum", required = false) Integer rentalStationNum,
			@RequestParam(value = "serialNum", required = false) Integer serialNum,
			@RequestParam(value = "card", required = false) String cardNum,
			@RequestParam(value = "rentalFee", required = false) Integer rentalFee, HttpSession session) {
		JSONObject json = new JSONObject();
		System.out.println("대여소 번호"+rentalStationNum);
		System.out.println("킥보드 번호 "+serialNum);
		System.out.println("카드 번호 "+cardNum);
		System.out.println("카드 비용"+rentalFee);

		// 예약 기본 정보 세팅
		String userId = (String) session.getAttribute("userId");
		
		// 제디스 쓰레드 생성
		Jedis jedis = jedisConfig();
		
		String key = Integer.toString(serialNum);
		Set<String> re = jedis.keys(key + "*");
		if (re.isEmpty() == false) {
			json.put("result", "reserved");
			return json;
		}

		HashMap<String, String> map = new HashMap<String, String>();
		String sendRentalStationNum = Integer.toString(rentalStationNum);
		String sendSerialNum = Integer.toString(serialNum);
		String sendRentalFee = Integer.toString(rentalFee);

		map.put("serialNum", sendSerialNum);
		map.put("rentalStationNum", sendRentalStationNum);
		map.put("cardNum", cardNum);
		map.put("rentalFee", sendRentalFee);
		map.put("userId", userId);
		map.put("reserveDate", date());
		map.put("using", "n");
		map.put("randomNum", randomNum());

		// 레디스 쓰레드를 낭비를 막기 위한 코드
		try {
			jedis.hmset(key + ":" + userId, map);
			jedis.expire(key + ":" + userId, 60 * 30); // 해당 입력하는 값은 초(sec) 단위입니다.
			String usingResult = service.using(map); //킥보드 사용중 표시
			json.put("result", usingResult);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			json.put("result", "databaseError");
			return json;
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedisConfig().close();
			}
		}
	}

	/**
	 * 예약 리스트 가져오기
	 * 
	 * @param session 아이디 가져올 세션
	 * @param reserve 예약 정보가져올 객체
	 * @param model   뷰에 보여줄 모델 담아주기
	 * @return
	 */
	@RequestMapping(value = { "/list", "/list/" }, method = RequestMethod.GET)
	public String listGet(HttpSession session, Model model) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/mypage/login";
		}

		if (session.getAttribute("reUserPw") == null) {
			return "redirect:/mypage/check";
		}

		String userId = (String) session.getAttribute("userId");
		// 제디스 쓰레드 생성
		Jedis jedis = jedisConfig();

		// 레디스 쓰레드를 낭비를 막기 위한 코드
		try {

			Set<String> set = jedis.keys("*" + userId); // 예약한 키 가져오기

			if (set.isEmpty()) {
				return path + "/list";
			}

			Iterator<String> it = set.iterator(); // Iterator(반복자) 생성 setType 을 반복하기 위해서 생성
			List<Object> list = new ArrayList(); // model 에 담아줄 list 생성
			Map<String, String> map = new HashMap<String, String>();// hgetAll return type에 맞게 값을 저장시켜줄 map

			while (it.hasNext()) { // hasNext() : 데이터가 있으면 true 없으면 false
				map = jedis.hgetAll(it.next());// map 에 저장해 준다음 list 에 add
				System.out.println(map);
				list.add(map);
			}

			model.addAttribute("list", list);
			return path + "/list";
		} catch (Exception e) {
			e.printStackTrace();
			return path + "/list";
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedisConfig().close();
			}
		}

	}

	/**
	 * 예약 취소
	 * 
	 * @param session   아이디값 가져올 세션
	 * @param serialNum 예약 번호
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "/cancel/", "/cancel" }, method = RequestMethod.DELETE)
	public JSONObject cancel(Integer serialNum, HttpSession session, Model model) {
		JSONObject json = new JSONObject();
		json.put("success", false);

		// 아이디, 예약 번호 담기

		String userId = (String) session.getAttribute("userId");

		Jedis jedis = jedisConfig();// 제디스 쓰레드 생성
		try {
			if (jedis.del(userId + ":" + serialNum) == 1) { // 삭제되면 1리턴
				json.put("result", "success");
				return json;
			} else {
				json.put("result", "alreadyCancel"); // 본인이 아니거나, 이미 삭제된 경우
				return json;
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.put("result", "databaseError"); // 데이터 베이스 오류
			return json;
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedisConfig().close();
			}
		}
	}

	/**
	 * 예약 -> 대여 업데이트 or 그냥 대여
	 * 
	 * @param rentalStationNum 대여소 번호
	 * @param serialNum        킥보드 고유 번호
	 * @param rentalFee        대여 비용
	 * @param card             결재할 카드
	 * @param session          아이디 가져올 세션
	 * @return json 오류 및 결과 리턴
	 */

//	// QRcode의 일회성을 위해서 일정 시간후 랜덤 키를 지우는 메서드
//	public void timer(final Integer serialNum, final String userId) {
//		TimerTask task = new TimerTask() {
//			@Override
//			public void run() {
//				Jedis jedis = jedisConfig();// 제디스 쓰레드 생성
//				try {
//					jedis.hdel(serialNum + ":" + userId, "randomNum");
//				} catch (Exception e) {
//					e.printStackTrace();
//				} finally {
//					if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
//						jedisConfig().close();
//					}
//				}
//
//			}
//		};
//		Timer timer = new Timer();
//		timer.schedule(task, 5 * 60 * 1000);// 1000= 1초
//	}
	
	//킥보드에 부착되어있는 기계에 QRcode 띄우기
	//버튼아니면 로딩되는 페이지 하나 만들기
	@ResponseBody
	@RequestMapping(value = { "/qrcode", "/qrcode/" }, method = RequestMethod.POST)
	public JSONObject QRcode(@RequestParam(value = "serialNum", required = false) Integer serialNum,
			HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		JSONObject json = new JSONObject();
		Jedis jedis = jedisConfig();// 제디스 쓰레드 생성
		try {
			String re = jedis.hget(serialNum + ":" + userId, "randomNum");
			json.put("result", re);
			return json;
		}catch(Exception e){
			e.printStackTrace();
			json.put("result", "databaseError"); // 데이터 베이스 오류
			return json;
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedisConfig().close();
			}		
		}
	}

	
	@RequestMapping(value = { "/rental", "/rental/" }, method = RequestMethod.GET)
	public String rentalPost(
			@RequestParam(value = "serialNum", required = false) Integer serialNum,
			@RequestParam(value = "randomNum", required = false) Object randomNum,
			HttpSession session) {

		String userId = (String) session.getAttribute("userId");
		Jedis jedis = jedisConfig();// 제디스 쓰레드 생성
		try {

			String re = jedis.hget(serialNum + ":" + userId, "randomNum");
			if (re.equals(randomNum)) {
				Map<String, String> hash = new HashMap<String, String>();
				hash.put("using", "y");
				hash.put("rentalDate", date());
				jedis.hmset(serialNum + ":" + userId, hash);
				jedis.persist(serialNum + ":" + userId); 
				return "redirect:/reserve/list";
			}else {
				return "redirect:/reserve/list";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedisConfig().close();
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value = { "/getback", "/getback/" }, method = RequestMethod.POST)
	public JSONObject returnGet(
			@RequestParam(value = "serialNum", required = false) Integer serialNum,
			@RequestParam(value = "returnStationNum", required = false) Integer returnStationNum,
			HttpSession session){
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		Jedis jedis = jedisConfig();// 제디스 쓰레드 생성
		try {
			Map<String, String> hash = new HashMap<String, String>();
			hash.put("returnDate", date());
			jedis.hmset(serialNum + ":" + userId, hash);//여기까지 현재
			hash = null;//재사용 ㅎ
			hash = jedis.hgetAll(serialNum + ":" + userId); //모든 값 가져오기
			String re = service.getBack(hash);
			//데이터베이스에 저장이 성공하면 예약 내역지움
			if(re=="success") {
				jedis.hdel(serialNum + ":" + userId, "randomNum");
			}
			json.put("result", re);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			json.put("result", "databaseError"); // 데이터 베이스 오류
			return json;
		} finally {
			if (jedis != null) { // 자원 닫아줘야 쓰레드 낭비가 생기지 않음
				jedisConfig().close();
			}
		}
	}
}
