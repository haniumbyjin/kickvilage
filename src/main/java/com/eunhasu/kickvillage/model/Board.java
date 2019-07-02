package com.eunhasu.kickvillage.model;

import java.util.ArrayList;

public class Board extends User{
	private String boardNum;
	private String boardTitle;
	private String boardText;
	private String boardDate;
	private ArrayList<Answer> answerList;

	public ArrayList<Answer> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(ArrayList<Answer> answerList) {
		this.answerList = answerList;
	}
	public String getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(String boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardText() {
		return boardText;
	}
	public void setBoardText(String boardText) {
		this.boardText = boardText;
	}
	public String getBoardDate() {
		return boardDate;
	}
	
	public void setBoardDate(String now) {
		this.boardDate = now;
	}
	
	@Override
	public String toString() {
		return "Board [boardNum=" + boardNum + ", boardTitle=" + boardTitle + ", boardText=" + boardText
				+ ", boardDate=" + boardDate + ", answerList=" + answerList + "]";
	}
	
}
