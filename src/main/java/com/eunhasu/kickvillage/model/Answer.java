package com.eunhasu.kickvillage.model;

public class Answer extends Admin {

	private Integer answerNum;
	private String answerText;
	private String answerDate;
	private Integer boardNum;
	
	public Integer getAnswerNum() {
		return answerNum;
	}
	public void setAnswerNum(Integer answerNum) {
		this.answerNum = answerNum;
	}
	public String getAnswerText() {
		return answerText;
	}
	public void setAnswerText(String answerText) {
		this.answerText = answerText;
	}
	public String getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(String answerDate) {
		this.answerDate = answerDate;
	}

	public Integer getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(Integer boardNum) {
		this.boardNum = boardNum;
	}
	@Override
	public String toString() {
		return "Answer [answerNum=" + answerNum + ", answerText=" + answerText + ", answerDate=" + answerDate
				+ ", board=" + boardNum + "]";
	}
	
	
}
