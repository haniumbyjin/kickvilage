package com.eunhasu.kickvillage.model;

public class Email extends User{
	private final String from = "dusrmatnftk17@gmail.com"; 
	private final String subject="Kickvillage";
    private String content;
    private String receiver;
    
	public String getFrom() {
		return from;
	}
	public String getSubject() {
		return subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	@Override
	public String toString() {
		return "Email [from=" + from + ", subject=" + subject + ", content=" + content + ", receiver=" + receiver + "]";
	}
	
	
}
