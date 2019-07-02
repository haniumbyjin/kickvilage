package com.eunhasu.kickvillage.service;

import java.security.SecureRandom;
import java.util.Random;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eunhasu.kickvillage.DAO.AdminDAO;
import com.eunhasu.kickvillage.Utils.AES256Util;
import com.eunhasu.kickvillage.Utils.SHA256Util;
import com.eunhasu.kickvillage.Values.Values;
import com.eunhasu.kickvillage.model.Admin;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO dao;

	@Override
	public boolean join(Admin admin) {
		
		try {
			
			//암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();
			
			//솔트값 생성
			final Random r = new SecureRandom();
			byte[] salt = new byte[32];
			r.nextBytes(salt);
			String encodedSalt = Base64.encodeBase64String(salt);
			
			admin.setAdminId(aes256.aesEncode(admin.getAdminId()));
			admin.setSalt(encodedSalt);
			admin.setAdminPw(sha256.encode(encodedSalt + admin.getAdminPw()));
			
			dao.join(admin);
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		
	}

	@Override
	public boolean login(Admin admin) {
		try {	
			//암호화
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			SHA256Util sha256 = new SHA256Util();
			
			admin.setAdminId(aes256.aesEncode(admin.getAdminId()));
			String salt = this.getSalt(admin.getAdminId());
			admin.setAdminPw(sha256.encode(salt + admin.getAdminPw()));
			
			int rs = dao.login(admin);
			
			if(rs == 1) {
				admin.setAdminId(aes256.aesDecode(admin.getAdminId()));
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Override
	public String getSalt(String adminId) {
		return dao.getSalt(adminId);
	}
}
