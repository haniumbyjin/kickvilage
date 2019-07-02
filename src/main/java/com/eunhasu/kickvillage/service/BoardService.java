package com.eunhasu.kickvillage.service;

import java.util.List;

import com.eunhasu.kickvillage.model.Answer;
import com.eunhasu.kickvillage.model.Board;
import com.eunhasu.kickvillage.model.PageMaker;

public interface BoardService {

	List<Board> list(PageMaker pagemaker);

	Integer totalCount();

	String add(Board board);

	String update(Board board);

	List<Board> detail(Board board);

	String delete(Board board);

	String answerAdd(Answer answer);

	String answerUpate(Answer answer);

	String answerDelete(Answer answer);

}
