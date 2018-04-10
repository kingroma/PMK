package com.java.controller;

import java.util.ArrayList;
import java.util.Date;

import com.java.hall.Hall;
import com.java.location.Location;
import com.java.location.LocationChat;
import com.java.location.LocationIssue;
import com.java.location.LocationPosition;
import com.java.user.User;
import com.java.user.UserLocation;
import com.java.user.UserWorkDate;
import com.java.util.MyDate;
import com.java.wedding.Wedding;
import com.java.wedding.WeddingChat;
import com.java.wedding.WeddingIssue;
import com.java.wedding.WeddingPhoto;

import server.db.mybatis.DBManager;

public class Controller {
	
	DBManager manager = null;
	
	/**
	 * db start
	 */
	public void start() {
		if(manager == null) {
			manager = new DBManager();
			manager.start();
		}
	}
	
	/**
	 * db end
	 */
	public void end() {
		if(manager != null){
			manager.end();
			manager = null;
		}
	}
	/**
	 * login check
	 * if cant find user_id == 1
	 * else if does not collect the user_pw == 2
	 * else success == 0
	 */
	public int login(String user_id , String user_pw) {
		this.start();
		User user = manager.getUser(user_id);
		this.end();
		
		int result = 0;
		if(user==null) {
			result = 1;
		}else{
			if(!user.getUser_pw().equals(user_pw)) {
				result = 2;
			}
		}
		return result;
	}
	
	/**
	 * is not id >> true
	 * is exist >> false
	 */
	public boolean isUserId(String user_id) {
		this.start();
		User user = manager.getUser(user_id);
		this.end();
		
		boolean result = true;
		
		if(user!=null) {
			result = false;
		}
		
		
		return result;
	}
	
	/**
	 * Sign up 
	 */
	public boolean addUser(User user) {
		
		this.start();
		int dbResult = manager.addUser(user);
		this.end();
		
		boolean result = false;
		
		if(dbResult==1) {
			result = true;
		}
		
		return result;
	}
	
	/**
	 * User
	 */
	public User getUser(String user_id) {
		this.start();
		
		User user = manager.getUser(user_id);
		
		this.end();
		
		return user;
	}
	
	public ArrayList<String> getUserWorkDatesAndGetOnlyWorkDateStringList(int location_number , String user_id){
		this.start();
		
		ArrayList<UserWorkDate> userWorkDates = manager.getUserWorkDates(location_number, user_id);
		
		ArrayList<String> stringDateList = new ArrayList<String>();
		
		if(userWorkDates!=null) {
			for(UserWorkDate workDate : userWorkDates) {
				String date = workDate.getWork_date();
				Date dateTemp = MyDate.changeStringToDate(date);
				stringDateList.add(dateTemp.getYear()+"/"+dateTemp.getMonth()+"/"+dateTemp.getDate());
			}
		}
		
		this.end();
		
		return stringDateList;
	}
	
	public ArrayList<String> getUserWorkDatesAndGetOnlyWorkDateStringList(String location_number , String user_id){
		this.start();
		
		int location_num = Integer.parseInt(location_number);
		
		ArrayList<UserWorkDate> userWorkDates = manager.getUserWorkDates(location_num, user_id);
		
		ArrayList<String> stringDateList = new ArrayList<String>();
		
		if(userWorkDates!=null) {
			for(UserWorkDate workDate : userWorkDates) {
				String date = workDate.getWork_date();
				Date dateTemp = MyDate.changeStringToDate(date);
				stringDateList.add(dateTemp.getYear()+"/"+dateTemp.getMonth()+"/"+dateTemp.getDate());
			}
		}
		this.end();
		
		return stringDateList;
	}
	
	public ArrayList<UserWorkDate> getUserWorkDatesLocationNumberWorkDate(Object location_number , String work_date){
		this.start();
		
		int location_num = -1;
		
		if(location_number.getClass()==String.class) {
			location_num = Integer.parseInt((String)location_number);
		}else {
			location_num = (int)location_number ;
		}
		
		ArrayList<UserWorkDate> userWorkDates = manager.getUserWorkDatesLocationNumberWorkDate(location_num, work_date);
		for(UserWorkDate userWorkDate : userWorkDates) {
			userWorkDate.setUser(manager.getUser(userWorkDate.getUser_id()));
		}
		this.end();
		return userWorkDates;
	}
	
	public int addUserWorkDate(UserWorkDate userWorkDate) {
		this.start();
		
		int result = manager.addUserWorkDate(userWorkDate); 
				
		this.end();
		
		return result;
	}
	
	public int deleteUserWorkDate(UserWorkDate userWorkDate) {
		
		this.start();
		
		int result = manager.deleteUserWorkDate(userWorkDate);
		
		this.end();
		
		return result;
	}
	
	/**
	 * Location
	 */
	
	public ArrayList<UserLocation> getUserLocations(String user_id){
		this.start();
		ArrayList<UserLocation> userLocations = manager.getUserLocations(user_id);
		for (UserLocation userLocation : userLocations) {
			userLocation.setLocation(manager.getLocation(userLocation.getLocation_number()));
		}
		
		this.end();
		
		return userLocations;
	}
	
	public ArrayList<UserLocation> getUserLocationsLocationNumber(Object location_number){
		this.start();
		
		int location_num = -1;
		
		if(location_number.getClass()==String.class) {
			location_num = Integer.parseInt((String)location_number);
		}else {
			location_num = (int)location_number;
		}
		
		ArrayList<UserLocation> userLocations = manager.getUserLocationLocationNumber(location_num);
		for(UserLocation userLocation : userLocations) {
			userLocation.setUser(manager.getUser(userLocation.getUser_id()));
		}
		this.end();
		
		return userLocations;
	}
	
	public int addUserLocations(UserLocation userLocation) {
		this.start();
		int result = manager.addUserLocation(userLocation);
		this.end();
		return result;
	}
	
	public ArrayList<UserLocation> getUserMembers(String user_id){
		this.start();
		ArrayList<UserLocation> userLocations = manager.getUserLocations(user_id);
		this.end();
		
		return userLocations;
	}
	
	/**
	 * Location
	 */
	public int addLocation(Location location) {
		this.start();
		
		int result = manager.addLocation(location);
		
		this.end();
		
		return result;
	}
	
	public Location getLocation(int location_number) {
		this.start();
		
		Location location = manager.getLocation(location_number);
		location.setHalls(manager.getHalls(location.getLocation_number()));
		location.setUserLocations(manager.getUserLocationLocationNumber(location_number));
		for(UserLocation userLocation : location.getUserLocations()) {
			userLocation.setUser(manager.getUser(userLocation.getUser_id()));
		}
		
		this.end();
		
		return location;
	}
	
	/**
	 * add All Parameter (Location)
	 */
	public Location getLocationAdmin (int location_number) {
		Location location = null ;
		
		this.start();
		
		//location , hall , location issue , location position , usermemeber
		location = manager.getLocation(location_number);
		ArrayList<Hall> halls = manager.getHalls(location_number);
		for(Hall hall : halls) {
			hall.setWeddings(manager.getWeddingLoationNumberHallNumber(location_number, hall.getHall_number()));
		}
		location.setHalls(halls);
		ArrayList<UserLocation> userLocations = manager.getUserLocationLocationNumber(location_number);
		for(UserLocation userLocation : userLocations) {
			userLocation.setUser(manager.getUser(userLocation.getUser_id()));
		}
		location.setUserLocations(userLocations);
		location.setLocationIssues(manager.getLocationIssues(location_number));
		location.setLocationPositions(manager.getLocationPositions(location_number));
		location.setWeddings(manager.getWeddings(location_number));
		
		
		this.end();
		
		return location;
	}
	
	public Location getLocationAdmin (String location_num) {
		Location location = null ;
		
		this.start();
		
		int location_number = Integer.parseInt(location_num);
		
		//location , hall , location issue , location position , usermemeber
		location = manager.getLocation(location_number);
		ArrayList<Hall> halls = manager.getHalls(location_number);
		for(Hall hall : halls) {
			hall.setWeddings(manager.getWeddingLoationNumberHallNumber(location_number, hall.getHall_number()));
		}
		location.setHalls(halls);
		ArrayList<UserLocation> userLocations = manager.getUserLocationLocationNumber(location_number);
		for(UserLocation userLocation : userLocations) {
			userLocation.setUser(manager.getUser(userLocation.getUser_id()));
		}
		location.setUserLocations(userLocations);
		location.setLocationIssues(manager.getLocationIssues(location_number));
		location.setLocationPositions(manager.getLocationPositions(location_number));
		location.setWeddings(manager.getWeddings(location_number));
		
		
		this.end();
		
		return location;
	}
	
	public Location getLocation(String location_number) {
		this.start();
		
		int location_num = Integer.parseInt(location_number);
		
		Location location = manager.getLocation(location_num);
		location.setHalls(manager.getHalls(location.getLocation_number()));
		location.setUserLocations(manager.getUserLocationLocationNumber(location_num));
		for(UserLocation userLocation : location.getUserLocations()) {
			userLocation.setUser(manager.getUser(userLocation.getUser_id()));
		}
		
		this.end();
		
		return location;
	}
	
	public int addLocationIssue(LocationIssue locationIssue) {
		this.start();
		
		int result = manager.addLocationIssues(locationIssue);
		
		this.end();
		
		return result;
	}
	
	public int deleteLocationIssue(int issue_number) {
		this.start();
		
		int result = manager.deleteLocationIssue(issue_number);
		
		this.end();
		
		return result;
	}
	
	public ArrayList<LocationIssue> getLocationIssueWithLocationNumberDate(int location_number , String work_date){
		this.start();
		
		ArrayList<LocationIssue> locatinoIssues = manager.getLocationIssuesWithDate(location_number, work_date);
		
		this.end();
		
		return locatinoIssues;
	}
	
	public ArrayList<LocationIssue> getLocationIssueWithLocationNumberDate(String location_number , String work_date){
		this.start();
		
		ArrayList<LocationIssue> locatinoIssues = manager.getLocationIssuesWithDate(location_number, work_date);
		
		this.end();
		
		return locatinoIssues;
	}
	
	public ArrayList<LocationChat> getLocationChat(int location_number , String work_date){
		this.start();
		
		ArrayList<LocationChat> locationChats = manager.getLocationChats(location_number, work_date);
		for(LocationChat locationChat : locationChats) {
			locationChat.setUser(manager.getUser(locationChat.getUser_id()));
		}
		this.end();
		
		return locationChats;
	}
	
	public int addLocationChat(LocationChat locationChat) {
		this.start();
		
		int result = manager.addLocationChat(locationChat);
		
		this.end();
		
		return result;
	}
	
	public ArrayList<LocationPosition> getLocationPosition (int location_number){
		this.start();
		
		ArrayList<LocationPosition> locationPositions = manager.getLocationPositions(location_number);
		
		this.end();
		
		return locationPositions;
	}
	
	public ArrayList<LocationPosition> getLocationPositions (String location_number){
		this.start();
		
		int location_num = Integer.parseInt(location_number);
		
		ArrayList<LocationPosition> locationPositions = manager.getLocationPositions(location_num);
		
		this.end();
		
		return locationPositions;
	}
	
	public ArrayList<LocationPosition> getLocationPositionsWithDate(String location_number,String work_date){
		this.start();
		
		int location_num = Integer.parseInt(location_number);
		
		ArrayList<LocationPosition> locationPositions = 	manager.getLocationPositionWithDate(location_num, work_date);
		
		for(LocationPosition locationPosition : locationPositions) {
			locationPosition.setUser(manager.getUser(locationPosition.getUser_id()));
		}
		
		this.end();
		
		return locationPositions;
	}
	
	public int addLocationPosition (LocationPosition locationPosition) {
		this.start();
		
		int result = manager.addLocationPosition(locationPosition);
		
		this.end();
		
		return result;
	}
	
	public int deleteLocationPosition (LocationPosition locationPosition) {
		this.start();
		
		int result = manager.deleteLocationPosition(locationPosition);
		
		this.end();
		
		return result;
	}
	
	
	/**
	 * Wedding
	 */
	public Wedding getWedding(String wedding_number) {
		this.start();

		int wedding_num = Integer.parseInt(wedding_number);
		
		Wedding wedding = manager.getWedding(wedding_num);
		
		this.end();
		
		return wedding;
	}
	
	public int addWedding(Wedding wedding) {
		this.start();
		
		int result = manager.addWedding(wedding);
		
		this.end();
		
		return result;
	}
	
	public ArrayList<Wedding> getWeddings(int location_number){
		this.start();
		
		ArrayList<Wedding> weddings = manager.getWeddings(location_number);
		
		this.end();
		return weddings;
	}
	
	public ArrayList<Wedding> getWeddingsWithLocationNumberDate(int location_number,String work_date){
		this.start();
		
		ArrayList<Wedding> weddings = manager.getWeddingsWithLocationNumberDate(location_number, work_date);
		
		this.end();
		return weddings;
	}
	
	public ArrayList<Wedding> getWeddingsWithLocationNumberDate(String location_number,String work_date){
		this.start();
		
		ArrayList<Wedding> weddings = manager.getWeddingsWithLocationNumberDate(location_number, work_date);
		
		  
		
		this.end();
		return weddings;
	}
	
	public ArrayList<WeddingChat> getWeddingChats(String wedding_number){
		this.start();
		
		int wedding_num = Integer.parseInt(wedding_number);
		
		ArrayList<WeddingChat> weddingChats = manager.getWeddingChats(wedding_num);
		
		for(WeddingChat weddingChat : weddingChats) {
			weddingChat.setUser(manager.getUser(weddingChat.getUser_id()));
		}
		
		this.end();
		
		return weddingChats;
	}
	
	public int addWeddingChat(WeddingChat weddingChat) {
		this.start();
		
		int result = manager.addWeddingChat(weddingChat);
		
		this.end();
		
		return result;
	}
	
	public ArrayList<WeddingIssue> getWeddingIssues(String wedding_number){
		this.start();
		
		int wedding_num = Integer.parseInt(wedding_number);
		
		ArrayList<WeddingIssue> weddingIssues = manager.getrWeddingIssues(wedding_num);
		
		this.end();
		
		return weddingIssues;
	}
	
	public int addWeddingIssue(WeddingIssue weddingIssue) {
		this.start();
		
		int result = manager.addWeddingIssue(weddingIssue);
		
		this.end();
		
		return result;
	}
	
	public int deleteWeddingIssue(int issue_number) {
		this.start();
		
		int result = manager.deleteWeddingIssue(issue_number);
		
		this.end();
		
		return result;
	}
	
	
	public ArrayList<WeddingPhoto> getWeddingPhotos(String wedding_number){
		this.start();
		
		int wedding_num = Integer.parseInt(wedding_number);
		
		ArrayList<WeddingPhoto> weddingPhotos = manager.getWeddingPhotos(wedding_num);
		
		this.end();
		
		return weddingPhotos;
	}
	
	public int addWeddingPhoto(WeddingPhoto weddingPhoto) {
		this.start();
		
		int result = manager.addWeddingPhoto(weddingPhoto);
		
		this.end();
		
		return result;
	}
	
	/**
	 * Hall
	 */
	public int addHall(Hall hall) {
		this.start();
		
		int result = manager.addHall(hall);
		
		this.end();
		
		return result;
	}
	
}
