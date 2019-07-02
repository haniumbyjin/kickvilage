package com.eunhasu.kickvillage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eunhasu.kickvillage.model.Admin;
import com.eunhasu.kickvillage.model.Station;
import com.eunhasu.kickvillage.service.AdminService;
import com.eunhasu.kickvillage.service.ApiService;
import com.google.gson.Gson;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	@Autowired
	AdminService service;
	
	@Autowired
	ApiService api;
	
	String path = "admin/";
	
	@RequestMapping(value= {"/", ""})
	public String index(HttpSession session) {
		
		if(session.getAttribute("admin") == null) {
			return "redirect:/admin/login";
		}
		
		return path+"index";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(HttpSession session) {
		if(session.getAttribute("admin") != null) {
			return "redirect:/admin/";
		}
		return path+"login";
	}
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public JSONObject login(HttpSession session, Admin admin) {
		JSONObject json = new JSONObject();
		json.put("success", false);
		
		if(session.getAttribute("admin") != null) {
			// 예외처리 안 함.
			return json;
		}
		
		if(service.login(admin)) {
			json.put("success", true);
			json.put("url", "/admin");
			session.setAttribute("admin", admin.getAdminId());
		} else {
			json.put("success", false);
			json.put("error", "loginError");
		}
		return json;
	}
	
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join(HttpSession session) {
		if(session.getAttribute("admin") != null) {
			return "redirect:/admin/";
		}
		return path+"join";
	}
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(HttpSession session, Admin admin) {
		if(session.getAttribute("admin") != null) {
			return "redirect:/admin/";
		}
		
		if(service.join(admin)) {
			return "redirect:/admin/login";
		}
		
		return "redirect:";
	}
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		if(session.getAttribute("admin") == null) {
			return "redirect:/admin/login";
		}
		session.removeAttribute("admin");
		return "redirect:/admin/login";
	}
	
	
	@RequestMapping(value="/station")
	public String station(HttpSession session, Model model) {
		if(session.getAttribute("admin") == null) {
			return "redirect:/admin/login";
		}
		
		List<Station> stations = api.getStationList();
		model.addAttribute("stations", new Gson().toJson(stations ));
		
		return path + "station";
	}
}
