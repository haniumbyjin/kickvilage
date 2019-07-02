package com.eunhasu.kickvillage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eunhasu.kickvillage.DAO.ApiDAO;
import com.eunhasu.kickvillage.model.Kickboard;
import com.eunhasu.kickvillage.model.Station;

@Service
public class ApiServiceImpl implements ApiService {
	
	@Autowired
	ApiDAO dao;

	@Override
	public boolean addStation(String stationName, String open, String locationX, String locationY) {
		
		try {
			
			Station station = new Station();
			station.setStationName(stationName);
			station.setOpen(open);
			station.setLocationX(locationX);
			station.setLocationY(locationY);
			
			dao.addStation(station);
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<Station> getStationList() {
		return dao.getStationList(null, null, null, null);
	}
	
	@Override
	public List<Station> getStationList(String SWX, String SWY, String NEX, String NEY) {
		return dao.getStationList(SWX, SWY, NEX, NEY);
	}

	@Override
	public boolean patchStation(int stationNum, String stationName, String open, String locationX, String locationY) {
		try {	
			Station station = new Station();
			station.setStationNum(stationNum);
			station.setStationName(stationName);
			station.setOpen(open);
			station.setLocationX(locationX);
			station.setLocationY(locationY);
			
			dao.patchStation(station);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean deleteStation(int stationNum) {
		try {
			dao.deleteStation(stationNum);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<Kickboard> getKickboardList(int stationNum) {
		return dao.getKickboardList(stationNum);
	}
}
