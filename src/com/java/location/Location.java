package com.java.location;

import java.util.ArrayList;

import com.java.hall.Hall;
import com.java.user.UserLocation;
import com.java.wedding.Wedding;

public class Location {
	private int location_number;
	private String name;
	private String imgUrl;
	
	private ArrayList<Hall> halls;
	private ArrayList<Wedding> weddings ;
	private ArrayList<LocationIssue> locationIssues;
	private ArrayList<LocationChat> locationChats;
	private ArrayList<LocationPosition> locationPositions;
	private ArrayList<UserLocation> userLocations;
	
	
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
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public ArrayList<Hall> getHalls() {
		return halls;
	}
	public void setHalls(ArrayList<Hall> halls) {
		this.halls = halls;
	}
	public ArrayList<Wedding> getWeddings() {
		return weddings;
	}
	public void setWeddings(ArrayList<Wedding> weddings) {
		this.weddings = weddings;
	}
	public ArrayList<LocationIssue> getLocationIssues() {
		return locationIssues;
	}
	public void setLocationIssues(ArrayList<LocationIssue> locationIssues) {
		this.locationIssues = locationIssues;
	}
	public ArrayList<LocationChat> getLocationChats() {
		return locationChats;
	}
	public void setLocationChats(ArrayList<LocationChat> locationChats) {
		this.locationChats = locationChats;
	}
	public ArrayList<LocationPosition> getLocationPositions() {
		return locationPositions;
	}
	public void setLocationPositions(ArrayList<LocationPosition> locationPositions) {
		this.locationPositions = locationPositions;
	}
	public ArrayList<UserLocation> getUserLocations() {
		return userLocations;
	}
	public void setUserLocations(ArrayList<UserLocation> userLocations) {
		this.userLocations = userLocations;
	}
	
	
	
	
}
