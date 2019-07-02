package com.eunhasu.kickvillage.DAO;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.eunhasu.kickvillage.model.Answer;
import com.eunhasu.kickvillage.model.Board;
import com.eunhasu.kickvillage.model.PageMaker;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Resource
	SqlSession sql;
	
	@Override
	public List<Board> list(PageMaker pagemaker) {
		
		return sql.selectList("Board.list", pagemaker);
	}

	@Override
	public Integer totalCount() {
		
		return sql.selectOne("Board.totalCount");
	}

	@Override
	public void add(Board board) {
		sql.insert("Board.add",board);
	}

	@Override
	public void update(Board board) {
		
		sql.update("Board.update",board);
		
	}

	@Override
	public List<Board> detail(Board board) {
		
		return sql.selectList("Board.detail",board);
	}

	@Override
	public String delete(Board board) {
		
		int re = sql.delete("Board.delete",board);
		
		if(re == 1) {
			return "success";
		} else {
			return "false";
		}
	
	}

	@Override
	public void answerAdd(Answer answer) {
		sql.insert("Board.answerAdd",answer);		
	}

	@Override
	public void answerUpdate(Answer answer) {
		sql.update("Board.answerUpdate",answer);		
	}

	@Override
	public String answerDelete(Answer answer) {
	
		int re = sql.delete("Board.answerDelete",answer);
		if(re == 1) {
			return "success";
		} else {
			return "false";
		}
	
	}

}
