package com.eunhasu.kickvillage.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eunhasu.kickvillage.model.Kickboard;
import com.eunhasu.kickvillage.model.Station;
import com.eunhasu.kickvillage.service.ApiService;

@Controller
@RequestMapping(value = "/api")
public class ApiContoller {
	//
	@Autowired
	ApiService service;

	//
	// 정류소 추가하는 API
	@RequestMapping(value = "/station", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject addStation(HttpSession session, @RequestParam(required = false) String stationName,
			@RequestParam(required = false) String open, @RequestParam(required = false) String locationX,
			@RequestParam(required = false) String locationY) {

		JSONObject json = new JSONObject();
		json.put("success", false);

		if (session.getAttribute("admin") != null) {

			if (stationName.isEmpty() || open.isEmpty() || locationX.isEmpty() || locationY.isEmpty()) {
				json.put("message", "Required parameter is empty");
				return json;
			}

			if (service.addStation(stationName, open, locationX, locationY)) {
				json.put("success", true);
			} else {
				json.put("success", false);
			}

		} else {
			json.put("message", "Permission denied");
		}

		return json;
	}

	// 정류소 수정하는 API
	@RequestMapping(value = "/station/{stationNum}", method = RequestMethod.PATCH)
	@ResponseBody
	public JSONObject patchStation(HttpSession session, @PathVariable int stationNum,
			@RequestBody MultiValueMap<String, String> formParams) {

		JSONObject json = new JSONObject();
		json.put("success", false);

		if (session.getAttribute("admin") != null) {

			// PATCH 등 get, post가 아닌 메소드의 값은 이렇게 가져와야 한다.
			// 참고 링크 :
			// https://stackoverflow.com/questions/22163397/spring-how-to-get-parameters-from-post-body
			// 2019-04-07 11:59 Hawon Kim
			String stationName = formParams.getFirst("stationName");
			String open = formParams.getFirst("open");
			String locationX = formParams.getFirst("locationX");
			String locationY = formParams.getFirst("locationY");

			if (stationName.isEmpty() || open.isEmpty() || locationX.isEmpty() || locationY.isEmpty()
					|| stationNum <= 0) {
				json.put("message", "Required parameter is empty");
				return json;
			}

			if (service.patchStation(stationNum, stationName, open, locationX, locationY)) {
				json.put("success", true);
			} else {
				json.put("success", false);
			}

		} else {
			json.put("message", "Permission denied");
		}

		return json;
	}

	// 정류소 삭제하는 API
	@RequestMapping(value = "/station/{stationNum}", method = RequestMethod.DELETE)
	@ResponseBody
	public JSONObject deleteStation(HttpSession session, @PathVariable int stationNum) {

		JSONObject json = new JSONObject();
		json.put("success", false);

		if (session.getAttribute("admin") != null) {

			if (stationNum <= 0) {
				json.put("message", "Required parameter is empty");
				return json;
			}

			if (service.deleteStation(stationNum)) {
				json.put("success", true);
			} else {
				json.put("success", false);
			}

		} else {
			json.put("message", "Permission denied");
		}

		return json;
	}

	// 정류소 리스트 가져오는 API
	// ##########################################
	// 성능 이슈가 있는 SQL문 사용 중. 개선 바람
	@RequestMapping(value = { "/station", "/stations", "/station/list" }, method = RequestMethod.GET)
	@ResponseBody
	public JSONObject station(HttpSession session, @RequestParam(required = false, defaultValue = "") String SWX,
			@RequestParam(required = false, defaultValue = "") String SWY,
			@RequestParam(required = false, defaultValue = "") String NEX,
			@RequestParam(required = false, defaultValue = "") String NEY) {

		JSONObject json = new JSONObject();
		json.put("success", false);

		List<Station> stations = null;

		if (!SWX.isEmpty() && !SWY.isEmpty() && !NEX.isEmpty() && !NEY.isEmpty()) {
			// 남서, 북동 지점의 GPS 값이 모두 있을 경우에만
			stations = service.getStationList(SWX, SWY, NEX, NEY);
		} else {
			stations = service.getStationList();
		}

		json.put("stations", stations);
		if (stations.size() > 0) {
			json.put("success", true);
		}

		return json;
	}

	// 한 정류소에 어떤 킥보드가 있는지 가져오는 API
	@RequestMapping(value = "/station/{stationNum}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getKickboard(HttpSession session, @PathVariable int stationNum) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);

		List<Kickboard> kickboards = service.getKickboardList(stationNum);
		map.put("kickboards", kickboards);
		map.put("success", true);
		return new JSONObject(map);
	}
}
