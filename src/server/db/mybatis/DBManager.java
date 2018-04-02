package server.db.mybatis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.java.hall.Hall;
import com.java.location.Location;
import com.java.location.LocationChat;
import com.java.location.LocationIssue;
import com.java.location.LocationPosition;
import com.java.user.User;
import com.java.user.UserLocation;
import com.java.user.UserWorkDate;
import com.java.wedding.Wedding;
import com.java.wedding.WeddingChat;
import com.java.wedding.WeddingIssue;
import com.java.wedding.WeddingPhoto;

import server.db.mapper.Mapper;

public class DBManager {
	private Manager sqlManager = Manager.getInstance();
	private SqlSession sqlSession;
	private Mapper mapper;
	
	public void start() {
		sqlManager.start();
		sqlSession = sqlManager.getSqlSession();
		mapper = (Mapper) sqlSession.getMapper(Mapper.class);
	}
	
	public void end() {
		sqlManager.end();
	}
	
	public DBManager() {
		
	}
	
	
	/**
	 * User
	 */
	public User getUser(String user_id) {
		return mapper.getUser(user_id);
	}
	
	public int addUser(User user) {
		return mapper.addUser(user);
	}
	
	public ArrayList<UserLocation> getUserLocations(String user_id) {
		return mapper.getUserLocations(user_id);
	}
	
	public ArrayList<UserLocation> getUserLocationLocationNumber(int location_number){
		return mapper.getUserLocationLocationNumber(location_number);
	}
	
	public int addUserLocation(UserLocation userLocation) {
		return mapper.addUserLocation(userLocation);
	}
	
	public ArrayList<UserWorkDate> getUserWorkDates(int location_number , String user_id){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("user_id", user_id);
		
		return mapper.getUserWorkDates(map);
	}
	
	public ArrayList<UserWorkDate> getUserWorkDatesLocationNumberWorkDate(int location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date);
		
		return mapper.getUserWorkDatesLocationNumberWorkDate(map);
	}
	
	public int addUserWorkDate(UserWorkDate userWorkDate) {
		return mapper.addUserWorkDate(userWorkDate);
	}
	
	public int deleteUserWorkDate(UserWorkDate userWorkDate) {
		return mapper.deleteUserWorkDate(userWorkDate);
	}
	
	/**
	 * Location
	 */
	public Location getLocation(int location_number) {
		return mapper.getLocation(location_number);
	}
	public Location getLocation(String location_number) {
		
		return mapper.getLocationString("0"+location_number);
	}
	
	public int addLocation(Location location) {
		return mapper.addLocation(location);
	}
	
	public ArrayList<LocationIssue> getLocationIssues(int location_number){
		return mapper.getLocationIssues(location_number);
	}
	
	public ArrayList<LocationIssue> getLocationIssuesWithDate(int location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date+"%");
		
		return mapper.getLocationIssuesWithDate(map);
	}
	
	public ArrayList<LocationIssue> getLocationIssuesWithDate(String location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date+"%");
		
		return mapper.getLocationIssuesWithDate(map);
	}
	
	public int addLocationIssues(LocationIssue locationIssue) {
		return mapper.addLocationIssue(locationIssue);
	}
	
	public int deleteLocationIssue(int issue_number) {
		return mapper.deleteLocationIssue(issue_number);
	}
	
	public ArrayList<LocationPosition> getLocationPositions(int location_number){
		return mapper.getLocationPositions(location_number);
	}
	
	public ArrayList<LocationPosition> getLocationPositionWithDate(int location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date);
		
		return mapper.getLocationPositionsWithDate(map);
	}
	
	public int addLocationPosition(LocationPosition locationPosition) {
		return mapper.addLocationPosition(locationPosition);
	}
	
	public int deleteLocationPosition(LocationPosition locationPosition) {
		return mapper.deleteLocationPosition(locationPosition);
	}

	public ArrayList<LocationChat> getLocationChats(int location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date+"%");
		
		return mapper.getLocationChats(map);
	}
	
	public int addLocationChat(LocationChat locationChat) {
		return mapper.addLocationChat(locationChat);
	}
	
	/**
	 * Hall
	 */
	public Hall getHall(int hall_number) {
		return mapper.getHall(hall_number);
	}
	
	public ArrayList<Hall> getHalls(int location_number){
		return mapper.getHalls(location_number);
	}
	
	public int addHall(Hall hall) {
		return mapper.addHall(hall);
	}
	
	/**
	 * Wedding
	 */
	
	public Wedding getWedding(int wedding_number) {
		return mapper.getWedding(wedding_number);
	}
	
	public ArrayList<Wedding> getWeddingLoationNumberHallNumber(int location_number,int hall_number) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("hall_number", hall_number);
		
		return mapper.getWeddingsLocationNumberHallNumber(map);
	}
	
	public ArrayList<Wedding> getWeddings(int location_number){
		return mapper.getWeddings(location_number);
	}
	
	public ArrayList<Wedding> getWeddingsWithLocationNumberDate(int location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date+"%");
		
		return mapper.getWeddingsWithLocationNumberDate(map);
	}
	
	public ArrayList<Wedding> getWeddingsWithLocationNumberDate(String location_number , String work_date){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("location_number", location_number);
		map.put("work_date", work_date+"%");
		
		return mapper.getWeddingsWithLocationNumberDate(map);
	}
	
	public int addWedding(Wedding wedding) {
		return mapper.addWedding(wedding);
	}
	
	public ArrayList<WeddingChat> getWeddingChats(int wedding_number){
		return mapper.getWeddingChats(wedding_number);
	}
	
	public int addWeddingChat(WeddingChat weddingChat) {
		return mapper.addWeddingChat(weddingChat);
	}
	
	public ArrayList<WeddingIssue> getrWeddingIssues(int wedding_number){
		return mapper.getWeddingIssues(wedding_number);
	}
	
	public int addWeddingIssue(WeddingIssue weddingIssue) {
		return mapper.addWeddingIssue(weddingIssue);
	}
	
	public int deleteWeddingIssue(int issue_number) {
		return mapper.deleteWeddingIssue(issue_number);
	}
	
	public ArrayList<WeddingPhoto> getWeddingPhotos(int wedding_number){
		return mapper.getWeddingPhotos(wedding_number);
	}
	
	public int addWeddingPhoto(WeddingPhoto weddingPhoto) {
		return mapper.addWeddingPhoto(weddingPhoto);
	}
	
}
