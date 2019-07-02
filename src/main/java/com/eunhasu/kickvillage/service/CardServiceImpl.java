package com.eunhasu.kickvillage.service;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Service;

import com.eunhasu.kickvillage.DAO.CardDAO;
import com.eunhasu.kickvillage.Utils.AES256Util;
import com.eunhasu.kickvillage.Utils.SHA256Util;
import com.eunhasu.kickvillage.Values.Values;
import com.eunhasu.kickvillage.model.Card;

@Service
public class CardServiceImpl implements CardService {
	@Resource
	CardDAO dao;

	// card null check 부분
	public String nullCheck(Card card) {
		if (card.getUserId() == null) {
			return "noLogin";
		}

		if (card.getCardNumFirst() == null || card.getCardNumSecond() == null || card.getCardNumThird() == null
				|| card.getCardNumFourth() == null) {
			return "noCardNum";
		}
		if (card.getCardPw() == null) {
			return "noCardPw";
		}
		if (card.getValidityMonth() == null || card.getValidityYear() == null) {
			return "noDate";
		}
		return "finish";
	}

	// card 패턴 체크부분
	public String patternCheck(Card card) {
		Pattern cardNumP = Pattern.compile("^[0-9]{4,4}$");
		Pattern validityP = Pattern.compile("^[0-9]{2,2}$");

		if (cardNumP.matcher(card.getCardNumFirst()).matches() == false
				|| cardNumP.matcher(card.getCardNumSecond()).matches() == false
				|| cardNumP.matcher(card.getCardNumThird()).matches() == false
				|| cardNumP.matcher(card.getCardNumFourth()).matches() == false
				|| validityP.matcher(card.getValidityMonth()).matches() == false
				|| validityP.matcher(card.getValidityYear()).matches() == false
				|| validityP.matcher(card.getCardPw()).matches() == false) {
			return "lengthLimit";
		}
		return "finish";
	}

	//카드 암호화
	public Card cardEncryption(Card card) {
		try {
			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();

			// 카드 1번쨰 ~3번째 번호 aes256 encoding 사용자에게 보여줄 번도들
			card.setUserId(aes256.aesEncode(card.getUserId()));
			card.setCardNumFirst(aes256.aesEncode(card.getCardNumFirst()));
			card.setCardNumSecond(aes256.aesEncode(card.getCardNumSecond()));
			card.setCardNumThird(aes256.aesEncode(card.getCardNumThird()));

			// 유효기간 aes256 encoding 사용자에게 보여줄 번도들
			card.setValidityMonth(aes256.aesEncode(card.getValidityMonth()));
			card.setValidityYear(aes256.aesEncode(card.getValidityYear()));

			// 솔트값 생성
			final Random r = new SecureRandom();
			byte[] salt = new byte[32];
			r.nextBytes(salt);
			String encodedSalt = Base64.encodeBase64String(salt);

			// 카드 번호 4번쨰 자리, 비밀번호 sha256 encoding
			card.setCardNumFourth(sha256.encode(encodedSalt + card.getCardNumFourth()));
			card.setCardPw(sha256.encode(encodedSalt + card.getCardPw()));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return card;
	}

	@Override
	public String cardAdd(Card card) {

		// null 체크 분리
		// finish 가 뜨지 않으면 null 이 있다 이말이야
		String nullCheckResult = nullCheck(card);
		if (nullCheckResult != "finish") {
			return nullCheckResult;
		}

		// 패턴체크를 따로 분리해서 체크해줌
		String patterResult = patternCheck(card);
		if (patterResult == "lengthLimit") {
			return patterResult;
		}
		System.out.println(card.getCardNumFirst());
		// 암호화 부분
		card = cardEncryption(card);
		String re = dao.cardAdd(card);

		return re;

	}

	@Override
	public List<Card> cardList(Card card) {
		try {
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			card.setUserId(aes256.aesEncode(card.getUserId()));
			
			List<Card> list = dao.cardList(card);
			
			for (int i = 0; list.size() > i; i++) {

				list.get(i).setCardNumFirst((aes256.aesDecode(list.get(i).getCardNumFirst())));
				list.get(i).setCardNumSecond((aes256.aesDecode(list.get(i).getCardNumSecond())));
				list.get(i).setCardNumThird((aes256.aesDecode(list.get(i).getCardNumThird())));
				list.get(i).setValidityMonth((aes256.aesDecode(list.get(i).getValidityMonth())));
				list.get(i).setValidityYear((aes256.aesDecode(list.get(i).getValidityYear())));

			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public String cardUpdate(Card card) {
		if (card.getCardNum() == null) {
			return "noCardNum";
		}
		// null 체크 분리
		// finish 가 뜨지 않으면 null 이 있다 이말이야
		String nullCheckResult = nullCheck(card);
		if (nullCheckResult != "finish") {
			return nullCheckResult;
		}

		// 패턴체크를 따로 분리해서 체크해줌
		String patterResult = patternCheck(card);
		if (patterResult == "lengthLimit") {
			return "lengthLimit";
		}

		// 암호화 부분
		card = cardEncryption(card);

		String re = dao.cardUpdate(card);

		if (re == "success") {
			return "success";
		} else {
			return "databaseError";
		}
	}

	@Override
	public String cardDelete(HashMap<String, Object> map) {
		if (map.get("userId") == null) {
			return "noLogin";
		}
		if (map.get("cardNum") == null) {
			return "cardNum";
		}
		
		try {
			// 암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			String userId = (String) map.get("userId");	
			map.put("userId",aes256.aesEncode(userId));
			String re = dao.cardDelete(map);
			return re;
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
		

		
	}
}
