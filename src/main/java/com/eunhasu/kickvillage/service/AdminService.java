package com.eunhasu.kickvillage.service;

import com.eunhasu.kickvillage.model.Admin;

public interface AdminService {

	boolean join(Admin admin);

	boolean login(Admin admin);
	
	/**
	 * 관리자 솔트값 가져오기.
	 * @param userid 암호화되지 않은 관리자 아이디
	 * @return salt 문자열.
	 */
	String getSalt(String adminId);

}
