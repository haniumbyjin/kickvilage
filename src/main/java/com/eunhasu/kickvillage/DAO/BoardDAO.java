package com.eunhasu.kickvillage.DAO;

import java.util.List;

import com.eunhasu.kickvillage.model.Answer;
import com.eunhasu.kickvillage.model.Board;
import com.eunhasu.kickvillage.model.PageMaker;

public interface BoardDAO {

	List<Board> list(PageMaker pagemaker);

	Integer totalCount();

	void add(Board board);

	void update(Board board);

	List<Board> detail(Board board);

	String delete(Board board);

	void answerAdd(Answer answer);

	void answerUpdate(Answer answer);

	String answerDelete(Answer answer);

}
