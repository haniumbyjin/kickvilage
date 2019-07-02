package com.eunhasu.kickvillage.service;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Random;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.eunhasu.kickvillage.DAO.MypageDAO;
import com.eunhasu.kickvillage.Utils.AES256Util;
import com.eunhasu.kickvillage.Utils.SHA256Util;
import com.eunhasu.kickvillage.Values.Values;
import com.eunhasu.kickvillage.model.Email;
import com.eunhasu.kickvillage.model.User;

@Service
public class MypageServiceImpl implements MypageService {
	@Autowired
	MypageDAO mypagedao;

	@Override
	public String joinuser(User user) throws Exception {

		try {
			if (user.getUserId().isEmpty()) {
				// 아이디가 없음
				return "emptyUserId";
			}

			if (user.getUserPw().isEmpty()) {
				// 비밀번호가 없음
				return "emptyUserPw";
			}

			// 사용자가 비밀번호 다시 확인시 불일치하게 보내는 건 체크하지 않는다.
			// 여기까지 불일치하게 보내는 건 의도적으로 자바스크립트 수정해서 하는건데
			// 틀리게 보내는건 자기 탓이지 뭐.

			if (user.getPhoneNum().isEmpty()) {
				// 폰번호 없음.
				return "emptyPhoneNum";
			}

			/* 비밀번호 정규식 */
			Pattern pwp = Pattern.compile("^[a-zA-Z0-9]{8,20}$");
			if (pwp.matcher(user.getUserPw()).matches() == false) {
				// 비밀번호 정규식 불일치
				return "wrongUserPw";
			}
			/* 아이디 정규식
			특수문자 안되며 영문, 숫자 로만 이루어진 5 ~ 15자 이하*/
			Pattern idp =  Pattern.compile("^[a-zA-Z0-9]{5,15}$");
			if (idp.matcher(user.getUserId()).matches() == false) {
				return "worngId";
			}

			/* 핸드폰 정규식 */
			Pattern phonEp = Pattern.compile("^[0-9]{3}[0-9]{3,4}[0-9]{3,4}$");
			if (phonEp.matcher(user.getPhoneNum()).matches() == false) {
				return "wrongPhone";
			}

			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();

			user.setUserId(aes256.aesEncode(user.getUserId()));
			user.setUserName(aes256.aesEncode(user.getUserName()));
			user.setPhoneNum(aes256.aesEncode(user.getPhoneNum()));

			if (this.checkid(user.getUserId()) == 1) {
				// 아이디가 중복됨
				return "usingId";
			}
			// 솔트값 생성
			final Random r = new SecureRandom();
			byte[] salt = new byte[32];
			r.nextBytes(salt);
			String encodedSalt = Base64.encodeBase64String(salt);

			user.setSalt(encodedSalt);
			user.setUserPw(sha256.encode(encodedSalt + user.getUserPw()));

			mypagedao.joinuser(user);

			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return "ERROR";
		}
	}

	@Override
	public int checkid(String userId) {

		try {
			Values values = new Values();
			AES256Util aes256;
			aes256 = new AES256Util(values.getKey());
			return mypagedao.checkid(aes256.aesEncode(userId));
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}
	@Override
	public String beforeEntry(User user) {

		try {
			if (user.getUserPw().isEmpty()) {
				return "noUserPw";
			}
			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();
			user.setUserId(aes256.aesEncode(user.getUserId()));
			
			String salt = mypagedao.getSalt(user.getUserId());
			user.setUserPw(sha256.encode(salt + user.getUserPw()));
			int re = mypagedao.beforeEntry(user);
			if (re == 1) {
				return "success";
			} else{
				return "differentPw";
			}
		} catch (Exception e) { 
			e.printStackTrace();
			return "databaseError";
		}

	}

	@Override
	public String getSalt(String userid) {
		return mypagedao.getSalt(userid);
	}

	@Override
	public User getUserInfo(String userId, String userPw) {
		try {
			if (userId.isEmpty() || userPw.isEmpty()) {
				// 사용자 아이디 혹은 사용자 비밀번호가 없으면 null 리턴
				return null;
			}

			// 암호화
			Values values = new Values();
			// 복호화가능
			AES256Util aes256 = new AES256Util(values.getKey());
			// 복호화불가능
			SHA256Util sha256 = new SHA256Util();

			userId = aes256.aesEncode(userId);
			String salt = this.getSalt(userId);

			userPw = sha256.encode(salt + userPw);

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userId", userId);
			map.put("userPw", userPw);

			User user = mypagedao.getUserInfo(map);

			// 가져온 사용자 정보 복호화
			user.setUserId(aes256.aesDecode(user.getUserId()));
			user.setUserName(aes256.aesDecode(user.getUserName()));
			// user.setPhoneNum(aes256.aesDecode(user.getPhoneNum()));

			return user;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public String login(String userId, String userPw) {

		try {
			if (userId.isEmpty()) {
				return "noUserId";
			}

			if (userPw.isEmpty()) {
				return "noUserPw";
			}

			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();

			userId = aes256.aesEncode(userId);
			String salt = mypagedao.getSalt(userId);

			userPw = sha256.encode(salt + userPw);

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userId", userId);
			map.put("userPw", userPw);

			int rs = mypagedao.login(map);

			if (rs == 1) {
				// 로그인 성공했을 떄
				return null;
			} else {
				// 로그인 실패했을 때
				return "loginError";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loginError";
	}

	// 새로운 비밀번호 난수 생성
	public static String randomPw() {
		char pwCollection[] = new char[] { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D', 'E',
				'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
				'v', 'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')' };// 배열에 선언
		String ranPw = "";
		for (int i = 0; i < 15; i++) {
			int selectRandomPw = (int) (Math.random() * (pwCollection.length));// Math.rondom()은 0.0이상 1.0미만의 난수를 생성해
																				// 준다.
			ranPw += pwCollection[selectRandomPw];
		}
		return ranPw;
	}

	@Resource
	private JavaMailSender mailSender;

	// 비밀번호 보내는 이메일 메서드
	public String sendPw(Email email) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(email.getFrom()); // 보내는사람 생략하거나 하면 정상작동을 안함

			messageHelper.setTo(email.getReceiver()); // 받는사람 이메일

			messageHelper.setSubject(email.getSubject()); // 메일제목은 생략이 가능하다

			messageHelper.setText("kickvillage 에서 요청된 비밀번호입니다. 비밀번호: " + email.getUserPw()); // 메일 내용

			mailSender.send(message);
			return "success";

		} catch (Exception e) {
			e.printStackTrace();
			return "eamilError";
		}

	}

	// 아이디 보내주는 메서드
	public String sendId(Email email) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(email.getFrom()); // 보내는사람 생략하거나 하면 정상작동을 안함

			messageHelper.setTo(email.getReceiver()); // 받는사람 이메일

			messageHelper.setSubject(email.getSubject()); // 메일제목은 생략이 가능하다

			messageHelper.setText("kickvillage 에서 요청된 아이디입니다. 아이디: " + email.getUserId()); // 메일 내용

			mailSender.send(message);
			return "success";

		} catch (Exception e) {
			e.printStackTrace();
			return "eamilError";
		}

	}

	@Override
	public String findPw(Email email) {
		try {
			if (email.getReceiver().isEmpty()) {
				return "noEmail";
			}
			if (email.getUserId().isEmpty()) {
				return "noUserId";
			}
			Pattern pwp = Pattern.compile("^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
			if (pwp.matcher(email.getReceiver()).matches() == false) {
				return "worngEmail";
			}


			String newUserPw = randomPw();
			System.out.println("난수 비밀번호: " + newUserPw);

			email.setUserPw(newUserPw);

			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();

			email.setUserId(aes256.aesEncode(email.getUserId()));
			
			int checkId = mypagedao.checkid(email.getUserId());
			if(checkId == 0) {
				return "noSearchId";
			}
			//이메일 보내기
			String emailRe = sendPw(email);
			
			// 솔트값 생성
			final Random r = new SecureRandom();
			byte[] salt = new byte[32];
			r.nextBytes(salt);
			String encodedSalt = Base64.encodeBase64String(salt);

			email.setSalt(encodedSalt);
			email.setUserPw(sha256.encode(encodedSalt + email.getUserPw()));

			String re = mypagedao.findPw(email);
			return re;

		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
	}

	@Override
	public String findId(Email email) {
		if (email.getUserName().isEmpty()) {
			return "noUserName";
		}
		if (email.getPhoneNum().isEmpty()) {
			return "noPhoneNum";
		}
		if (email.getReceiver().isEmpty()) {
			return "noEmail";
		}
		
		Pattern pwp = Pattern.compile("^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
		if (pwp.matcher(email.getReceiver()).matches() == false) {
			return "worngEmail";
		}
		
		Pattern phonEp = Pattern.compile("^[0-9]{3}[0-9]{3,4}[0-9]{3,4}$");
		if (phonEp.matcher(email.getPhoneNum()).matches() == false) {
			return "wrongPhone";
		}
		
	try {
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			email.setUserName(aes256.aesEncode(email.getUserName()));
			email.setPhoneNum(aes256.aesEncode(email.getPhoneNum()));
			
			//사용자가 입력한 정보에 맞는 아이디가 있는지 검색
			String re = mypagedao.findOutId(email);
			
			//검색 결과가 있다면 이메일 발송
			if(re != "nonexistent") {
				email.setUserId(aes256.aesDecode(re));
				System.out.println("복호화한 아이디"+email.getUserId());
				String emailRe= sendId(email);
				return emailRe;
			}
			return "nonexistent";
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}

		
	}

	@Override
	public String update(User user) {
		try {

			if (user.getUserPw().isEmpty()) {
				// 비밀번호가 없음
				return "emptyUserPw";
			}

			// 사용자가 비밀번호 다시 확인시 불일치하게 보내는 건 체크하지 않는다.
			// 여기까지 불일치하게 보내는 건 의도적으로 자바스크립트 수정해서 하는건데
			// 틀리게 보내는건 자기 탓이지 뭐.

			if (user.getPhoneNum().isEmpty()) {
				// 폰번호 없음.
				return "emptyPhoneNum";
			}
			if (user.getDriverLisence().isEmpty()) {
				// 운전면허 유무에대한 정보없음
				return "emptyDriverLisence";
			}

			/* 비밀번호 정규식 */
			Pattern pwp = Pattern.compile("^[a-zA-Z0-9]{8,20}$");
			if (pwp.matcher(user.getUserPw()).matches() == false) {
				// 비밀번호 정규식 불일치
				return "wrongUserPw";
			}

			/* 핸드폰 정규식 */
			Pattern phonEp = Pattern.compile("^[0-9]{3}[0-9]{3,4}[0-9]{3,4}$");
			if (phonEp.matcher(user.getPhoneNum()).matches() == false) {
				return "wrongPhone";
			}

			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();

			user.setUserName(aes256.aesEncode(user.getUserName()));
			user.setPhoneNum(aes256.aesEncode(user.getPhoneNum()));
			int findUserId = mypagedao.checkid(user.getUserId());
			if(findUserId == 0) {
				return "noId";
			}
			// 솔트값 생성
			final Random r = new SecureRandom();
			byte[] salt = new byte[32];
			r.nextBytes(salt);
			String encodedSalt = Base64.encodeBase64String(salt);

			user.setSalt(encodedSalt);
			user.setUserPw(sha256.encode(encodedSalt + user.getUserPw()));

			String updateRuseult = mypagedao.update(user);

			return updateRuseult;
		} catch (Exception e) {
			e.printStackTrace();
			return "ERROR";
		}
	}

	
}
