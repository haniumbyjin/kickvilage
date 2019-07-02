package com.eunhasu.kickvillage.model;

public class User {
	private String userId;
	private String userPw;
	private String userName;
	private String phoneNum;
	private String driverLisence;
	private String salt;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getDriverLisence() {
		return driverLisence;
	}
	public void setDriverLisence(String driverLisence) {
		this.driverLisence = driverLisence;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
}
