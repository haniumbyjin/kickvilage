package com.eunhasu.kickvillage.service;

import com.eunhasu.kickvillage.model.Email;
import com.eunhasu.kickvillage.model.User;

public interface MypageService {
	/**
	 * 사용자 아이디, 비밀번호 체크 (로그인)
	 * 
	 * @param userId 암호화되지 않은 사용자 아이디
	 * @param userPw 암호화되지 않은 사용자 비밀번호
	 * @return error 결과값
	 */
	String login(String userId, String userPw);

	/**
	 * 사용자 회원가입
	 * 
	 * @param user 객체. 솔트값 빼고 나머지는 모두 필수
	 * @return String error 객체 내부의 값이 비어있을 때 관련 에러 코드 (세부내용 내부 코드 참조)
	 * @throws Exception
	 */
	String joinuser(User user) throws Exception;

	/**
	 * 아이디 중복체크
	 * 
	 * @param userId
	 * @return
	 */
	int checkid(String userId);

	/**
	 * 마이페이지로 들어가기전에 아이디 비밀번호를 한번더 체크해한다.
	 * 
	 * @param userId
	 * @param userPw
	 * @return
	 */
	String beforeEntry(User user);

	/**
	 * 사용자 솔트값 가져오기
	 * 
	 * @param userid 암호화된 사용자 아이디
	 * @return 솔트값
	 */
	String getSalt(String userid);

	/**
	 * 사용자 정보 가져오는 메소드
	 * 
	 * @param userId 암호화되지 않은 사용자 아이디
	 * @param userPw 암호화되지 않은 사용자 비밀번호
	 * @return User 객체
	 * @throws Exception
	 */
	User getUserInfo(String userId, String userPw);

	/**
	 * 비밀번호 찾는 이메일 보낸다.
	 * 
	 * @param email
	 * @return
	 */
	String findPw(Email email);

	/**
	 * 아이디 찾는 이메일
	 * 
	 * @param email
	 * @return
	 */
	String findId(Email email);

	/**
	 * 개인정보 수정
	 * 
	 * @param user
	 * @return 예외처리, 에러났는지, 성공했는지
	 */
	String update(User user);

}
