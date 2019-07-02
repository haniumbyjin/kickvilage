package com.eunhasu.kickvillage.model;

public class Station {

	private int stationNum;
	private String stationName;
	private String locationX;
	private String locationY;
	private String open;	
	private	int kickboardCount;
	
	public int getStationNum() {
		return stationNum;
	}
	public void setStationNum(int stationNum) {
		this.stationNum = stationNum;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getLocationX() {
		return locationX;
	}
	public void setLocationX(String locationX) {
		this.locationX = locationX;
	}
	public String getLocationY() {
		return locationY;
	}
	public void setLocationY(String locationY) {
		this.locationY = locationY;
	}
	public String getOpen() {
		return open;
	}
	public void setOpen(String open) {
		this.open = open;
	}
	public int getKickboardCount() {
		return kickboardCount;
	}
	public void setKickboardCount(int kickboardCount) {
		this.kickboardCount = kickboardCount;
	}
	@Override
	public String toString() {
		return "Station [stationNum=" + stationNum + ", stationName=" + stationName + ", locationX=" + locationX
				+ ", locationY=" + locationY + ", open=" + open + ", kickboardCount=" + kickboardCount + "]";
	}
	
}
