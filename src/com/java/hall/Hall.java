package com.java.hall;

import java.util.ArrayList;

import com.java.wedding.Wedding;

public class Hall {
	private int hall_number;
	private int location_number;
	private String name;
	private String nickname;
	
	private ArrayList<Wedding> weddings;
	
	public int getHall_number() {
		return hall_number;
	}
	public void setHall_number(int hall_number) {
		this.hall_number = hall_number;
	}
	public int getLocation_number() {
		return location_number;
	}
	public void setLocation_number(int location_number) {
		this.location_number = location_number;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public ArrayList<Wedding> getWeddings() {
		return weddings;
	}
	public void setWeddings(ArrayList<Wedding> weddings) {
		this.weddings = weddings;
	}
	
	
}
