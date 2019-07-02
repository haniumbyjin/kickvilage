package com.eunhasu.kickvillage.DAO;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eunhasu.kickvillage.model.Kickboard;
import com.eunhasu.kickvillage.model.Station;

@Repository
public class ApiDAOImpl implements ApiDAO {
	
	@Autowired
	SqlSession sql;

	@Override
	public void addStation(Station station) {
		sql.insert("Station.addStation", station);
	}
	
	@Override
	public List<Station> getStationList(String SWX, String SWY, String NEX, String NEY) {
		
		if(SWX != null && SWY != null && NEX != null && NEY != null) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("SWX", SWX);
			map.put("SWY", SWY);
			map.put("NEX", NEX);
			map.put("NEY", NEY);
			
			return sql.selectList("Station.getStationList", map);
		} else {
			return sql.selectList("Station.getStationList");
		}
	}

	@Override
	public void patchStation(Station station) {
		sql.update("Station.patchStation", station);
	}

	@Override
	public void deleteStation(int stationNum) {
		sql.delete("Station.deleteStation", stationNum);
	}

	@Override
	public List<Kickboard> getKickboardList(int stationNum) {
		return sql.selectList("Station.getKickboardList", stationNum);
	}

	
}
