package com.java.wedding;

import java.util.ArrayList;

public class Wedding {
	private int wedding_number; // primary key auto_increment
	private int location_number;
	private int hall_number;
	private String work_date;
	private String title;
	
	private ArrayList<WeddingChat> weddingChats;
	private ArrayList<WeddingIssue> weddingIssues;
	private ArrayList<WeddingPhoto> weddingPhotos;

	public Wedding() {
		
	}
	
	public int getWedding_number() {
		return wedding_number;
	}
	public void setWedding_number(int wedding_number) {
		this.wedding_number = wedding_number;
	}
	public int getLocation_number() {
		return location_number;
	}
	public void setLocation_number(int location_number) {
		this.location_number = location_number;
	}
	public int getHall_number() {
		return hall_number;
	}
	public void setHall_number(int hall_number) {
		this.hall_number = hall_number;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWork_date() {
		return work_date;
	}

	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}

	public ArrayList<WeddingChat> getWeddingChats() {
		return weddingChats;
	}

	public void setWeddingChats(ArrayList<WeddingChat> weddingChats) {
		this.weddingChats = weddingChats;
	}

	public ArrayList<WeddingIssue> getWeddingIssues() {
		return weddingIssues;
	}

	public void setWeddingIssues(ArrayList<WeddingIssue> weddingIssues) {
		this.weddingIssues = weddingIssues;
	}

	public ArrayList<WeddingPhoto> getWeddingPhotos() {
		return weddingPhotos;
	}

	public void setWeddingPhotos(ArrayList<WeddingPhoto> weddingPhotos) {
		this.weddingPhotos = weddingPhotos;
	}


	
}
