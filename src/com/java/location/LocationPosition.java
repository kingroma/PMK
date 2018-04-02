package com.java.location;

import com.java.user.User;

public class LocationPosition {
	private int location_number;
	private int hall_number;
	private String title;
	private String user_id;
	private String work_date;
	
	private User user;
	
	public int getLocation_number() {
		return location_number;
	}
	public void setLocation_number(int location_number) {
		this.location_number = location_number;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getHall_number() {
		return hall_number;
	}
	public void setHall_number(int hall_number) {
		this.hall_number = hall_number;
	}
	
	
	
}
