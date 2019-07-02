package com.eunhasu.kickvillage.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.eunhasu.kickvillage.DAO.BoardDAO;
import com.eunhasu.kickvillage.Utils.AES256Util;
import com.eunhasu.kickvillage.Values.Values;
import com.eunhasu.kickvillage.model.Answer;
import com.eunhasu.kickvillage.model.Board;
import com.eunhasu.kickvillage.model.PageMaker;


@Service
public class BoardServiceImpl implements BoardService {

	@Resource
	BoardDAO dao;
	
	@Override
	public List<Board> list(PageMaker pagemaker) {
		try {
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			List<Board> list = dao.list(pagemaker);

			for (int i = 0; list.size() > i; i++) {
				list.get(i).setUserId(aes256.aesDecode(list.get(i).getUserId()));
			}
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Integer totalCount() {

		return dao.totalCount();
	}

	@Override
	public String add(Board board) {
		try {
		// 예약 시간 설정
		SimpleDateFormat today = new SimpleDateFormat("yyMMddHHmmss", Locale.KOREA);
		String now = today.format(new Date());
		if (board.getBoardTitle() == null) {
			return "noBoardTitle";
		}
		if (board.getBoardText() == null) {
			return "noBoardText";
		}
		Values values = new Values();
		AES256Util aes256 = new AES256Util(values.getKey());
		board.setUserId(aes256.aesEncode(board.getUserId()));
		
		board.setBoardDate(now);

		dao.add(board);
		return null;
		
		}catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
	}

	@Override
	public String update(Board board) {
		// 예약 시간 설정
		try {
			SimpleDateFormat today = new SimpleDateFormat("yyMMddHHmmss", Locale.KOREA);
			String now = today.format(new Date());
			if (board.getUserId() == null) {
				return "noLogin";
			}
			if (board.getBoardTitle() == null) {
				return "noBoardTitle";
			}
			if (board.getBoardText() == null) {
				return "noBoardText";
			}
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			board.setUserId(aes256.aesEncode(board.getUserId()));
			
			board.setBoardDate(now);

			dao.update(board);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	@Override
	public List<Board> detail(Board board) {
		return dao.detail(board);
	}

	@Override
	public String delete(Board board) {
		try {
			if (board.getUserId() == null) {
				return "noLogin";
			}
			if (board.getBoardNum()==null) {
				return "noBoardNum";
			}
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			board.setUserId(aes256.aesEncode(board.getUserId()));

			String re = dao.delete(board);

			if (re == "false") {
				return "alreayDelete";
			}
			return "success";
		}  catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	@Override
	public String answerAdd(Answer answer) {
		// 예약 시간 설정
		SimpleDateFormat today = new SimpleDateFormat("yyMMddHHmmss", Locale.KOREA);
		String now = today.format(new Date());
		try {
			if(answer.getBoardNum() == null) {
				return "noBoardNum";
			} else if (answer.getAdminId() == null) {
				return "noAdmin";
			} else if (answer.getAnswerText() == null) {
				return "noAnswerText";
			}
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			answer.setAdminId(aes256.aesEncode(answer.getAdminId()));
			answer.setAnswerDate(now);
			
			dao.answerAdd(answer);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	@Override
	public String answerUpate(Answer answer) {
		try {
			// 예약 시간 설정
			SimpleDateFormat today = new SimpleDateFormat("yyMMddHHmmss", Locale.KOREA);
			String now = today.format(new Date());
			if(answer.getBoardNum() == null) {	
				return "noBoardNum";
			} else if (answer.getAdminId() == null) {
				return "noAdmin";
			} else if (answer.getAnswerText() == null) {
				return "noAnswerText";
			} 
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			answer.setAdminId(aes256.aesEncode(answer.getAdminId()));
			
			answer.setAnswerDate(now);
			dao.answerUpdate(answer);
			return "success";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}

	@Override
	public String answerDelete(Answer answer) {
		try {
			if(answer.getAdminId()==null) {
				return "noAdmin";	
			}if(answer.getAnswerNum()==null){
				return "noAnswerNum";
			}if(answer.getBoardNum()==null){
				return "noBoardNum";
			}
			Values values = new Values();
			AES256Util aes256 = new AES256Util(values.getKey());
			answer.setAdminId(aes256.aesEncode(answer.getAdminId()));
			String re = dao.answerDelete(answer);
			if (re == "false") {
				return "alreayDelete";
			}
			return "success";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
		}
		

}
