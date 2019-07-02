package com.eunhasu.kickvillage.model;

public class Card{
	private Integer cardNum;
	private String cardNumFirst;
	private String cardNumSecond;
	private String cardNumThird;
	private String cardNumFourth;
	private String validityMonth;
	private String validityYear;
	private String cardPw;
	private String userId;
	private String bank;
	public Integer getCardNum() {
		return cardNum;
	}
	public void setCardNum(Integer cardNum) {
		this.cardNum = cardNum;
	}
	public String getCardNumFirst() {
		return cardNumFirst;
	}
	public void setCardNumFirst(String cardNumFirst) {
		this.cardNumFirst = cardNumFirst;
	}
	public String getCardNumSecond() {
		return cardNumSecond;
	}
	public void setCardNumSecond(String cardNumSecond) {
		this.cardNumSecond = cardNumSecond;
	}
	public String getCardNumThird() {
		return cardNumThird;
	}
	public void setCardNumThird(String cardNumThird) {
		this.cardNumThird = cardNumThird;
	}
	public String getCardNumFourth() {
		return cardNumFourth;
	}
	public void setCardNumFourth(String cardNumFourth) {
		this.cardNumFourth = cardNumFourth;
	}
	public String getValidityMonth() {
		return validityMonth;
	}
	public void setValidityMonth(String validityMonth) {
		this.validityMonth = validityMonth;
	}
	public String getValidityYear() {
		return validityYear;
	}
	public void setValidityYear(String validityYear) {
		this.validityYear = validityYear;
	}
	public String getCardPw() {
		return cardPw;
	}
	public void setCardPw(String cardPw) {
		this.cardPw = cardPw;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	@Override
	public String toString() {
		return "Card [cardNum=" + cardNum + ", cardNumFirst=" + cardNumFirst + ", cardNumSecond=" + cardNumSecond
				+ ", cardNumThird=" + cardNumThird + ", cardNumFourth=" + cardNumFourth + ", validityMonth="
				+ validityMonth + ", validityYear=" + validityYear + ", cardPw=" + cardPw + ", userId=" + userId
				+ ", bank=" + bank + "]";
	}
}
