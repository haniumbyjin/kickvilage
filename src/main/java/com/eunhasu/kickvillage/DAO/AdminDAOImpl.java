package com.eunhasu.kickvillage.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eunhasu.kickvillage.model.Admin;

@Repository
public class AdminDAOImpl implements AdminDAO {
	
	@Autowired
	SqlSession sql;

	@Override
	public void join(Admin admin) {
		sql.insert("Admin.join", admin);
	}

	@Override
	public String getSalt(String adminId) {
		return sql.selectOne("Admin.getSalt", adminId);
	}

	@Override
	public int login(Admin admin) {
		return sql.selectOne("Admin.login", admin);
	}
}
