package com.eunhasu.kickvillage.model;





public class Reserve {
	private String userId;
	private Integer reserveNum;
	private Integer rentalStationNum;
	private Integer returnStationNum;
	private String reserveDate;
	private String rentalDate;
	private String returnDate;
	private Integer rentalFee;
	private String cardNum;
	private Integer serialNum;
	private String availability;
	private String QRcodeNum;

	
	public Integer getReserveNum() {
		return reserveNum;
	}
	public void setReserveNum(Integer reserveNum) {
		this.reserveNum = reserveNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Integer getRentalStationNum() {
		return rentalStationNum;
	}
	public void setRentalStationNum(Integer rentalStationNum) {
		this.rentalStationNum = rentalStationNum;
	}
	public Integer getReturnStationNum() {
		return returnStationNum;
	}
	public void setReturnStationNum(Integer returnStationNum) {
		this.returnStationNum = returnStationNum;
	}
	public String getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getRentalDate() {
		return rentalDate;
	}
	public void setRentalDate(String rentalDate) {
		this.rentalDate = rentalDate;
	}
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public Integer getRentalFee() {
		return rentalFee;
	}
	public void setRentalFee(Integer rentalFee) {
		this.rentalFee = rentalFee;
	}
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public Integer getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(Integer serialNum) {
		this.serialNum = serialNum;
	}
	public String getAvailability() {
		return availability;
	}
	public void setAvailability(String availability) {
		this.availability = availability;
	}
	public String getQRcodeNum() {
		return QRcodeNum;
	}
	public void setQRcodeNum(String qRcodeNum) {
		QRcodeNum = qRcodeNum;
	}
	
	@Override
	public String toString() {
		return "Reserve [userId=" + userId + ", reserveNum=" + reserveNum + ", rentalStationNum=" + rentalStationNum
				+ ", returnStationNum=" + returnStationNum + ", reserveDate=" + reserveDate + ", rentalDate="
				+ rentalDate + ", returnDate=" + returnDate + ", rentalFee=" + rentalFee + ", cardNum=" + cardNum
				+ ", serialNum=" + serialNum + ", availability=" + availability + ", QRcodeNum=" + QRcodeNum + "]";
	}
	
}
