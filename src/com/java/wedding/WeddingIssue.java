package com.java.wedding;

public class WeddingIssue {
	private int issue_number;
	private int wedding_number; // primary key auto_increment
	
	private String title;
	private String text;
	
	
	public int getWedding_number() {
		return wedding_number;
	}
	public void setWedding_number(int wedding_number) {
		this.wedding_number = wedding_number;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getIssue_number() {
		return issue_number;
	}
	public void setIssue_number(int issue_number) {
		this.issue_number = issue_number;
	}
	
	
	
}
