package com.eunhasu.kickvillage.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eunhasu.kickvillage.model.Station;
import com.eunhasu.kickvillage.service.ApiService;

@Controller
@RequestMapping(value = "/")
public class IndexController {

	@Autowired
	ApiService api;

	@GetMapping(value = "/")
	public String index(Model model) {
		List<Station> stations = api.getStationList();
		model.addAttribute("stations", stations);
		System.out.println(stations);
		return "index";
	}

}
