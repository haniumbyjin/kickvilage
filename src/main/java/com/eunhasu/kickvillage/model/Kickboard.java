package com.eunhasu.kickvillage.model;

public class Kickboard {
	private int serialNum;
	private int stationNum;
	private int batteryCondition;
	private String stationName;
	public int getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(int serialNum) {
		this.serialNum = serialNum;
	}
	public int getStationNum() {
		return stationNum;
	}
	public void setStationNum(int stationNum) {
		this.stationNum = stationNum;
	}
	public int getBatteryCondition() {
		return batteryCondition;
	}
	public void setBatteryCondition(int batteryCondition) {
		this.batteryCondition = batteryCondition;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	@Override
	public String toString() {
		return "Kickboard [serialNum=" + serialNum + ", stationNum=" + stationNum + ", batteryCondition="
				+ batteryCondition + ", stationName=" + stationName + "]";
	}
	
	
	
}
