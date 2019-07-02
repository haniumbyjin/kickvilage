package com.eunhasu.kickvillage.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eunhasu.kickvillage.model.Answer;
import com.eunhasu.kickvillage.model.Board;
import com.eunhasu.kickvillage.model.PageMaker;
import com.eunhasu.kickvillage.service.BoardService;

/**
 * 
 * @author xofla
 * 게시판 처리하는 페이지
 */

@Controller
@RequestMapping(value="board/")
public class BoardController {
	String path = "/board";
	
	@Resource
	BoardService service;
	
	@RequestMapping(value="/question", method = RequestMethod.GET)
	public String question() {
		return path + "/question";
	}
	
	@GetMapping(value="/add")
	public String addGet() {
		
		return path + "/add";
	}
	
	@ResponseBody
	@PostMapping(value="/add")
	public JSONObject addPost(@ModelAttribute Board board, HttpSession session) {
		JSONObject json = new JSONObject();
		json.put("success", false);

		String userId = (String) session.getAttribute("userId");

		board.setUserId(userId);
		if (userId == null) {
			json.put("error","noLogin");
		}
		
		String re = service.add(board);
		if(re == null) {
			json.put("success", true);
			json.put("url", "/board/list");
		} else {
			json.put("error", re);
		}
		return json;
	}
	
	//list 불러와주는 페이지
	//참고 영상
	//https://www.youtube.com/watch?v=aLBemo4oo60
	@GetMapping(value="/list")
	public String listPage(Model model, @ModelAttribute("pagemaker") PageMaker pagemaker) throws Exception {
		
		//전체 게시글
		pagemaker.setTotalCount(service.totalCount());
		
		//현재 블록 구하기
		pagemaker.setCurrentBlock(pagemaker.getPageNum());
		
		//마지막 블록 구하기
		pagemaker.setLastBlock(pagemaker.getTotalCount());
		
		//다음 , 이전 화살표 계산
		pagemaker.prevnext(pagemaker.getPageNum());
		
		//현재블록으로 지금 페이지 구하기
		pagemaker.setStartPage(pagemaker.getCurrentBlock());
		
		//마지막 페이지 구하기
		pagemaker.setEndPage(pagemaker.getLastBlock(), pagemaker.getCurrentBlock());
		
		pagemaker.setPageNum(pagemaker.getPageNum()-1);
		List<Board> list = service.list(pagemaker);
		
		model.addAttribute("list",list);
		model.addAttribute("page",pagemaker);
		return path + "/list";
	}
	
	/*
	 * 게시글 삭제
	 */
	@ResponseBody
	@DeleteMapping(value="/{boardNum}")
	public JSONObject deletePost(@PathVariable Integer boardNum ,@ModelAttribute Board board, HttpSession session) {
		JSONObject json = new JSONObject();
		
		String userId = (String)session.getAttribute("userId");
		board.setUserId(userId);
		String re = service.delete(board);		
		
		return json;
	}
	
	/*
	 * 게시물 수정
	 */
	@GetMapping(value="/update")
	public String updateGet() {
		
		return path + "/update";
	}
	
	@ResponseBody
	@PatchMapping(value="/{boardNum}")
	public JSONObject updatePatch( @PathVariable("boardNum") Integer boardNum,@RequestBody Board board,HttpSession session) {
		
		JSONObject json = new JSONObject();
		
		String userId = (String) session.getAttribute("userId");
		
		json.put("success",false);
		
		board.setUserId(userId);
		
		String re = service.update(board);
		
		json.put("error",re);
		 
		switch (re) {
		case "noLogin":
			json.put("error","noLogin");
			return json; 
		case "noBoardTitle":
			json.put("error","noBoardTitle");
			return json; 
		case "noBoardText":
			json.put("error","noBoardText");
			return json; 
		default:
			json.put("success",true);
			return json;
		}
	}
	
	/*
	 * 게시판 특정 게시물의 자세한정보, 댓글 리스트 가져온다.
	 * boardNum 리스트를 가져올 게시판 번호
	 * board 게시판 정보를 답아올 VO
	 */
	@GetMapping(value="/detail/{boardNum}")
	public String detailGet(@PathVariable Integer boardNum,@ModelAttribute Board board,Model model) {
		List<Board> re = service.detail(board);
		model.addAttribute("list",re);
		return path + "/detail";
	} 
	
	/*
	 * 댓글 추가.
	 */
	@ResponseBody
	@PostMapping(value="/detail/{boardNum}")
	public JSONObject detailCommentPost(@PathVariable Integer boardNum,@ModelAttribute Answer answer ,HttpSession session) {
		JSONObject json = new JSONObject();
		json.put("success", false);
		
		String adminId = (String)session.getAttribute("admin");
		
		answer.setAdminId(adminId);
		
		String re = service.answerAdd(answer);
		
		switch (re) {
		case "noAdmin":
			json.put("error","noAdmin");
			return json;
		case "noAnswerText":
			json.put("error","noAnswerText");
			return json;  
		default:
			json.put("success",true);
			return json;
		}
	}
	
	@ResponseBody
	@PatchMapping(value="/detail/{answerNum}")
	public JSONObject detailAnswerPatch(@PathVariable("answerNum") Integer answerNum,@RequestBody Answer answer,HttpSession session) {
		JSONObject json = new JSONObject();
		
		String adminId = (String)session.getAttribute("admin");
		answer.setAdminId(adminId);
		String re = service.answerUpate(answer);
		
		switch (re) {
		case "noAdmin":
			json.put("error","noAdmin");
			return json;
		case "noAnswerText":
			json.put("error","noAnswerText");
			return json;  
		case "noBoardNum":
			json.put("error","noBoardNum");
			return json;  
		default:
			json.put("success",true);
			return json;
		}
	}
	@ResponseBody
	@DeleteMapping(value="/detail/{answerNum}")
	public JSONObject detailConmmentDelete(@PathVariable Integer answerNum, @RequestBody Answer answer,HttpSession session) {
		JSONObject json = new JSONObject();
	
		String adminId =(String)session.getAttribute("admin"); 
		System.out.println(adminId);
		System.out.println(answer.getBoardNum());
		
		answer.setAdminId(adminId);
		String re = service.answerDelete(answer);
		
		switch (re) {
		case "noAdmin":
			json.put("error","noAdmin");
			return json;
		case "noAnswerText":
			json.put("error","noAnswerText");
			return json;  
		case "noBoardNum":
			json.put("error","noBoardNum");
			return json;  
		case "alreayDelete":
			json.put("error","alreayDelete");
			return json;  
		case "false":
			json.put("error","false");
			return json;  
		default:
			json.put("success",true);
			return json;
		}
	}
}
