package com.java.location;

import com.java.user.User;

public class LocationChat {
	private int location_chat_number;
	private String text;
	private int location_number;
	private String work_date;
	
	private String user_id;
	
	private User user;
	
	public int getLocation_chat_number() {
		return location_chat_number;
	}
	public void setLocation_chat_number(int location_chat_number) {
		this.location_chat_number = location_chat_number;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getLocation_number() {
		return location_number;
	}
	public void setLocation_number(int location_number) {
		this.location_number = location_number;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
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
