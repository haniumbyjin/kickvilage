package com.eunhasu.kickvillage.DAO;

import com.eunhasu.kickvillage.model.Admin;

public interface AdminDAO {

	void join(Admin admin);

	String getSalt(String userid);

	int login(Admin admin);

}
