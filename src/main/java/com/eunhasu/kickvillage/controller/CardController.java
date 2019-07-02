package com.eunhasu.kickvillage.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eunhasu.kickvillage.model.Card;
import com.eunhasu.kickvillage.service.CardService;
/**
 * 
 * @author xofla
 * 카드 추가부분
 */
@Controller
@RequestMapping(value = "/card")
public class CardController {
	String path = "/card";

	@Resource
	CardService service;
	
	@GetMapping(value = "/test")
	public String test() {	
		return path + "/test";
	}
	
	@GetMapping(value = "/add")
	public String addGet(HttpSession session) {
		//로그인 안했을시 추방
		String userId = (String) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/mypage/login";
		}
		return path + "/add";
	}
	
	//카드 추가
	@ResponseBody
	@PostMapping(value = "/add")
	public JSONObject addPost(@ModelAttribute Card card, HttpSession session) {
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		card.setUserId(userId);
		String re = service.cardAdd(card);
		
		switch (re) {
		case "noLogin":
			json.put("error", "noLogin");
			return json;
		case "noCardNum":
			json.put("error", "noCardNum");
			return json;
		case "noCardPw":
			json.put("error", "noCardPw");
			return json;
		case "noDate":
			json.put("error", "noDate");
			return json;
		case "lengthLimit":
			json.put("error", "lengthLimit");
			return json;
		case "success":
			json.put("error", "success");
			return json;
		default:
			json.put("error", "databaseError");
			return json;
		}
	}
	//list 보여줄 기본 페이지
	@GetMapping(value="/list")
	public String cardList(HttpSession session) {
		//로그인 안했을시 추방
		String userId = (String) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/mypage/login";
		}
		return path + "/list";
	}
	
	//list ajax 실행
	@ResponseBody
	@GetMapping(value="/ajaxList")
	public JSONObject cardAjaxList(HttpSession session) {
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		if(userId == null) {
			json.put("error", "noLogin");
			return json;
		}
		Card card = new Card();
		card.setUserId(userId);
		
		List<Card> list = service.cardList(card);
		System.out.println(list);
		json.put("list",list); 
		return json;
	}
	
	//카드 수정
	@ResponseBody
	@PatchMapping(value = "/{cardNum}")
	public JSONObject updatePatch(@PathVariable Integer cardNum,@RequestBody Card card, HttpSession session) {
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		card.setCardNum(cardNum);
		card.setUserId(userId);

		String re = service.cardUpdate(card);
	
		switch (re) {
		case "noLogin":
			json.put("error", "noLogin");
			return json;
		case "noCardNum":
			json.put("error", "noCardNum");
			return json;
		case "noCardPw":
			json.put("error", "noCardPw");
			return json;
		case "noDate":
			json.put("error", "noDate");
			return json;
		case "lengthLimit":
			json.put("error", "lengthLimit");
			return json;
		case "success":
			json.put("error", "success");
			return json;
		default:
			json.put("error", "databaseError");
			return json;
		}
	}
	@ResponseBody
	@DeleteMapping(value = "/{cardNum}")
	public JSONObject cardDelete(@PathVariable Integer cardNum, HttpSession session) {
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("userId",userId);
		map.put("cardNum",cardNum);
		String re = service.cardDelete(map);
		
		switch(re) {
		case "noLogin":
			json.put("error", "noLogin");
			return json;
		case "noCardNum":
			json.put("error", "noCardNum");
			return json;
		case "noIdentity":
			json.put("error", "noIdentity");
			return json;
		case "success":
			json.put("success", "success");
			return json;
		default:
			json.put("error", "databaseError");
			return json;
		}
	}
}