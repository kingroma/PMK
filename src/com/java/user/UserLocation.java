package com.java.user;

public class UserLocation {
	private int location_number;
	private String user_id;
	
	private User user ;
	
	public int getLocation_number() {
		return location_number;
	}
	public void setLocation_number(int location_number) {
		this.location_number = location_number;
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
