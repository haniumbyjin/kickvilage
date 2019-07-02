package com.eunhasu.kickvillage.DAO;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eunhasu.kickvillage.model.Email;
import com.eunhasu.kickvillage.model.User;

@Repository
public class MypageDAOImpl implements MypageDAO {
	@Autowired
	SqlSession sql;

	@Override
	public void joinuser(User user) throws Exception {
		try {
			sql.insert("Mypage.joinuser", user);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	@Override
	public int checkid(String userId) {
		return sql.selectOne("Mypage.checkid", userId);
	}

	@Override
	public int beforeEntry(User user) {
		return sql.selectOne("Mypage.beforeEntry", user);
	}

	@Override
	public String getSalt(String userId) {
		return sql.selectOne("Mypage.getSalt", userId);
	}

	@Override
	public User getUserInfo(HashMap<String, String> map) {
		return sql.selectOne("Mypage.getUserInfo", map);
	}

	@Override
	public int login(HashMap<String, String> map) {
		return sql.selectOne("Mypage.login", map);
	}

	@Override
	public String findPw(Email email) {

		try {
			sql.update("Mypage.findPw", email);

			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
	}

	/*
	 * 사용자가 입력한 조건에 맞는 아이디가 있는지 검색하고 있다면 조건에 맞는 아이디를 리턴시켜주는 함수
	 */
	@Override
	public String findOutId(Email email) {

		String seleteUserId = sql.selectOne("Mypage.seleteUserId", email);
		if (seleteUserId != null) {
			return seleteUserId;
		}
		return "nonexistent";
	}
	
	@Override
	public String update(User user) {
		try {
			sql.selectOne("Mypage.update", user);
		}catch(Exception e){
			e.printStackTrace();
			return "databaseError";
		}
		return null;
	}

}
