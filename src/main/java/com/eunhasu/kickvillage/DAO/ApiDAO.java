package com.eunhasu.kickvillage.DAO;

import java.util.List;

import com.eunhasu.kickvillage.model.Kickboard;
import com.eunhasu.kickvillage.model.Station;

public interface ApiDAO {

	void addStation(Station station);
	
	List<Station> getStationList(String SWX, String SWY, String NEX, String NEY);

	void patchStation(Station station);

	void deleteStation(int stationNum);

	List<Kickboard> getKickboardList(int stationNum);
}
