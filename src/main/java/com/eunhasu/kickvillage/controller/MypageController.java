package com.eunhasu.kickvillage.controller;


import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eunhasu.kickvillage.model.Email;
import com.eunhasu.kickvillage.model.User;
import com.eunhasu.kickvillage.service.MypageService;

/**
 * 유저 정보 컨트롤
 * @author xofla
 *
 */
@Controller
@RequestMapping(value ="/mypage")
public class MypageController {
	@Autowired
	MypageService mypageservice;
	
	
	final String mypagePath = "/mypage";
	
	/**
	 * 회원가입 페이지 띄워줌
	 * @return
	 */
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String userjoinGet() {
		return mypagePath + "/join";
	}

	/** 회원가입
	 *  
	 * @param userId
	 * @param userPw
	 * @param reUserPw
	 * @param userName
	 * @param phoneNum
	 * @param driverLisence
	 * @return
	 */
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject join(@RequestParam(required = false) String userId,
			@RequestParam(required = false) String userPw, @RequestParam(required = false) String reUserPw,
			@RequestParam(required = false) String userName, @RequestParam(required = false) String phoneNum,
			@RequestParam(required = false) String driverLisence) {
		JSONObject json = new JSONObject();
		json.put("success", false);
		
		//사용자 정보를 User vo에 담고있음
		User user = new User();
		user.setUserId(userId);
		user.setUserPw(userPw);
		user.setUserName(userName);
		user.setPhoneNum(phoneNum);
		user.setDriverLisence(driverLisence);

		try {
			String error = mypageservice.joinuser(user);
			
			if(error == null) {
				json.put("success", true);
				json.put("url", "/");
			} else {
				json.put("success", false);
				json.put("error", error);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return json;
	}

	/* mypage 입장전 비밀번호확인 페이지 */
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public String mypageCheckGet(HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/mypage/login";
		}
		if(session.getAttribute("reUserPw") != null) {
			return "redirect:/mypage/info";
		}
		return mypagePath+"/check";
	}
	
	/**
	 * 입력된 비밀번호와 세션 아이디 가지고 비밀번호 체크
	 * @param userPw
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value ="/check", method = RequestMethod.POST)
	public JSONObject mypageCheckPost(@ModelAttribute User user, HttpSession session) {
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		user.setUserId(userId);
		String re = mypageservice.beforeEntry(user);	
			/* reUserPw 세션을 등록함으로써
			 * 중복 비밀번호 체크 방지
			 */
			if(re == "success") {
				session.setAttribute("reUserPw","reUserPw"); 
				json.put("result","success");
				return json;
			} else {
				json.put("result", re);
				return json;
			}
	}
	
	/* 정보수정 */
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String userInfoGet(HttpSession session) throws Exception {
		if(session.getAttribute("userId") == null) {
			return "redirect:/mypage/login";
		}
		if(session.getAttribute("reUserPw") == null) {
			return "redirect:/mypage/check";
		}
		return mypagePath + "/info";
	}
	
	@RequestMapping(value = "/info", method = RequestMethod.POST)
	public JSONObject userInfoPost(HttpSession session, @ModelAttribute User user) {
		JSONObject json = new JSONObject();
		String userId = (String) session.getAttribute("userId");
		user.setUserId(userId);
		String re = mypageservice.update(user);
		json.put("result",re);
		return json;
	}

	/* 회원탈퇴 */
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String userdeleteGet(HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/mypage/login";
		}
		return "/userdelete";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String userdeletePost() {

		return "/";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET )
	public String loginGet() {
		return mypagePath + "/login";
	}
	/** 
 	 * 보안상 아이디와 비밀번호 한번에 대조
	 * @param userId
	 * @param userPw
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/login",method=RequestMethod.POST )
	public JSONObject loginPost(
			@RequestParam( required=false) String userId,
			@RequestParam( required=false) String userPw, 
			HttpSession session) {
		
		
		JSONObject json = new JSONObject();
		json.put("success", false);
		
		String error = mypageservice.login(userId, userPw);
		
		//로그인 성공시 사용자 정보 가져온다. 아니면 에러 메세지 보냄
		if(error == null) {
			User user = mypageservice.getUserInfo(userId, userPw);
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("userName", user.getUserName());
			session.setAttribute("DriverLisence", user.getDriverLisence());
			json.put("success", true);
			json.put("url", "/");
		} else {
			json.put("error", error);
		}
		
		return json;
	}
			
	@RequestMapping(value="/logout")
	public String logoutGet(HttpSession session) {
		session.invalidate(); 
		return "redirect:/";
	}
	

	// mailForm
	@GetMapping(value = "/find")
	public String mailForm() {
		return mypagePath + "/find";
	}
	
	@ResponseBody
	@PostMapping(value = "/findPw")
	public JSONObject findPw(@ModelAttribute Email email) {
		JSONObject json = new JSONObject();
		String re = mypageservice.findPw(email);
		json.put("result",re);
	return json;
	 
	  }
	
	@ResponseBody
	@PostMapping(value = "/findId")
	public JSONObject findId(@ModelAttribute Email email) {
		JSONObject json = new JSONObject();
		String re = mypageservice.findId(email);
		json.put("result",re);
	return json;
	 
	  }
	
}


