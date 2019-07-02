package com.eunhasu.kickvillage.DAO;

import java.util.HashMap;

import com.eunhasu.kickvillage.model.Email;
import com.eunhasu.kickvillage.model.User;

public interface MypageDAO {

	void joinuser(User user) throws Exception;

	int checkid(String userId);

	int beforeEntry(User user);

	String getSalt(String userId);

	User getUserInfo(HashMap<String, String> map);

	int login(HashMap<String, String> map);

	String findPw(Email email);

	/*
	 * 사용자가 입력한 조건에 맞는 아이디가 있는지 검색하고 있다면 조건에 맞는 아이디를 리턴시켜주는 함수
	 */
	String findOutId(Email email);

	/**
	 * 개인정보 수정
	 * @param user
	 * @return
	 */
	String update(User user);
}
