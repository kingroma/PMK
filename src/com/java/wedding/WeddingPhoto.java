package com.java.wedding;

public class WeddingPhoto {
	private int photo_number;
	private int wedding_number;
	
	private String title;
	private String imgUrl;
	private String user_id;
	
	
	public int getPhoto_number() {
		return photo_number;
	}
	public void setPhoto_number(int photo_number) {
		this.photo_number = photo_number;
	}
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	
}

