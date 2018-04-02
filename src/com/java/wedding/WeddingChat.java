package com.java.wedding;

import com.java.user.User;

public class WeddingChat {
	private int wedding_chat_number;
	private String text;
	private int wedding_number;
	
	private String user_id;

	private User user;
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getWedding_number() {
		return wedding_number;
	}
	public void setWedding_number(int wedding_number) {
		this.wedding_number = wedding_number;
	}
	public int getWedding_chat_number() {
		return wedding_chat_number;
	}
	public void setWedding_chat_number(int wedding_chat_number) {
		this.wedding_chat_number = wedding_chat_number;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	
}
