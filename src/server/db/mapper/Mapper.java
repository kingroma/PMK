package server.db.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

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

public interface Mapper {
	
	/**
	 * User
	 */
	final String getUserSql = "select * from User where user_id = #{user_id}";
	@Select(getUserSql)
	public User getUser(String user_id);

	final String addUserSql = "insert into User("
			+ "user_id , user_pw , name , "
			+ "nickname , registration_number , work_site , "
			+ "phone) "
			+ "values ("
			+ "#{user_id} , #{user_pw} , #{name} , "
			+ "#{nickname} , #{registration_number} , #{work_site} , "
			+ "#{phone}"
			+ ")";
	@Insert(addUserSql)
	public int addUser(User user);
	
	final String getUserLocationSql = "select * from UserLocation where user_id = #{user_id}";
	@Select(getUserLocationSql)
	public ArrayList<UserLocation> getUserLocations(String user_id);
	
	final String getUserLocationSqlLocationNumber = "select * from UserLocation where location_number = #{location_number}";
	@Select(getUserLocationSqlLocationNumber)
	public ArrayList<UserLocation> getUserLocationLocationNumber(int location_number);
	
	final String addUserLocationSql = "insert into UserLocation "
			+ "(location_number , user_id) values"
			+ "#{location_number} , #{user_id})";
	@Insert(addUserLocationSql)
	public int addUserLocation(UserLocation userLocation);
	
	final String getUserWorkDateSql = "select DISTINCT * from UserWorkDate where location_number= #{location_number} and user_id= #{user_id}";
	@Select(getUserWorkDateSql)
	public ArrayList<UserWorkDate> getUserWorkDates(Map<String,Object> map);
	
	final String getUserWorkDatesSqlLocationNumberWorkDate = "select * from UserWorkDate where location_number=#{location_number} and work_date=#{work_date}";
	@Select(getUserWorkDatesSqlLocationNumberWorkDate)
	public ArrayList<UserWorkDate> getUserWorkDatesLocationNumberWorkDate(Map<String,Object> map);
	
	final String addUserWorkDateSql = "insert into UserWorkDate (user_id,location_number,work_date) values (#{user_id},#{location_number},#{work_date})";
	@Insert(addUserWorkDateSql)
	public int addUserWorkDate(UserWorkDate userWorkDate) ;
	
	final String deleteUserWorkDateSql = "delete from UserWorkDate where location_number=#{location_number} and user_id=#{user_id} and work_date=#{work_date}";
	@Delete(deleteUserWorkDateSql)
	public int deleteUserWorkDate(UserWorkDate userWorkDate);
	
	/**
	 * Location
	 */
	final String getLocationSql = "select * from location where location_number=#{location_number}";
	@Select(getLocationSql)
	public Location getLocation(int location_number);
	
	final String getLocationSqlString = "select * from location where location_number=#{location_number}";
	@Select(getLocationSqlString)
	public Location getLocationString(String location_number);
	
	
	final String addLocationSql = "insert into location "
			+ "(location_number,name,imgUrl) values "
			+ "(#{location_number},#{name},#{imgUrl})";
	@Insert(addLocationSql)
	public int addLocation(Location location);
	
	final String getLocationIssuesSql = "select * from LocationIssue where location_number= #{location_number}";
	@Select(getLocationIssuesSql)
	public ArrayList<LocationIssue> getLocationIssues(int location_number);
	
	final String getLocationIssuesSqlWithDate = "select * from LocationIssue where location_number=#{location_number} and work_date like #{work_date}";
	@Select(getLocationIssuesSqlWithDate)
	public ArrayList<LocationIssue> getLocationIssuesWithDate(Map<String,Object> map);
	
	final String addLocationIssueSql = "insert into LocationIssue(issue_number,location_number , title , text , work_date) values (#{issue_number},#{location_number},#{title},#{text},#{work_date})";
	@Insert(addLocationIssueSql)
	public int addLocationIssue(LocationIssue locationIssue);
	
	final String deleteLocationIssueSql = "delete from LocationIssue where issue_number=#{issue_number}";
	@Delete(deleteLocationIssueSql)
	public int deleteLocationIssue(int issue_number);
	
	final String getLocationPositionsSql = "select * from LocationPosition where location_number=#{location_number}";
	@Select(getLocationPositionsSql)
	public ArrayList<LocationPosition> getLocationPositions(int location_number);
	
	final String getLocationPositionsSqlWithDate = "select * from LocationPosition where location_number=#{location_number} and work_date=#{work_date}";
	@Select(getLocationPositionsSqlWithDate)
	public ArrayList<LocationPosition> getLocationPositionsWithDate(Map<String,Object> map);
	
	final String addLocationPositionSql ="insert into LocationPosition(location_number ,hall_number, title , user_id , work_date) values (#{location_number} ,#{hall_number}, #{title} , #{user_id} , #{work_date} )";
	@Insert(addLocationPositionSql)
	public int addLocationPosition(LocationPosition locationPosition);
	
	final String deleteLocationPositionSql = "delete from LocationPosition where location_number=#{location_number} and hall_number=#{hall_number} and  title=#{title} and user_id=#{user_id} and work_date=#{work_date}";
	@Delete(deleteLocationPositionSql)
	public int deleteLocationPosition(LocationPosition locationPosition);
	
	final String getLocationsChatSql = "select * from LocationChat where location_number=#{location_number} and work_date like #{work_date}";
	@Select(getLocationsChatSql)
	public ArrayList<LocationChat> getLocationChats(Map<String,Object> map);
	
	final String addLocationChatSql = "insert into LocationChat "
			+ "(location_chat_number , text , location_number , work_date ,"
			+ "user_id"
			+ ") values("
			+ "#{location_chat_number} , #{text} , #{location_number} , #{work_date} ," 
			+ "#{user_id}"
			+ ")" ;
	@Insert(addLocationChatSql)
	public int addLocationChat(LocationChat locationChat);
	
	/**
	 * 	Hall 
	 */
	
	final String getHallSql = "select * from hall where hall_number = #{hall_number}";
	@Select(getHallSql)
	public Hall getHall(int hall_number);
	
	final String getHallsSql = "select * from hall where location_number = #{location_number}";
	@Select(getHallsSql)
	public ArrayList<Hall> getHalls(int location_number);
	
	final String addHallSql = "insert into hall(hall_number , location_number , name , nickname) values(#{hall_number},#{location_number},#{name},#{nickname})";
	@Insert(addHallSql)
	public int addHall(Hall hall);
	
	/**
	 * Wedding
	 */
	final String getWeddingSql = "select * from wedding where wedding_number=#{wedding_number}";
	@Select(getWeddingSql)
	public Wedding getWedding(int wedding_number);
	
	final String getWeddingSqlLocationNumberHallNumber = " select * from wedding where location_number=#{location_number} and hall_number=#{hall_number}";
	@Select(getWeddingSqlLocationNumberHallNumber)
	public ArrayList<Wedding> getWeddingsLocationNumberHallNumber(Map<String,Object> map);
	
	final String getWeddingsSql = "select * from wedding where location_number=#{location_number}";
	@Select(getWeddingsSql)
	public ArrayList<Wedding> getWeddings(int location_number);
	
	final String getWeddingsSqlWithLocationNumberDateSql = "select * from wedding where location_number= #{location_number} and work_date like #{work_date}";
	@Select(getWeddingsSqlWithLocationNumberDateSql)
	public ArrayList<Wedding> getWeddingsWithLocationNumberDate(Map<String,Object> map);
	
	final String addWeddingSql = "insert into wedding "
			+ "(wedding_number,location_number,hall_number,work_date,title) values "
			+ "(#{wedding_number},#{location_number},#{hall_number},#{work_date},#{title})";
	@Insert(addWeddingSql)
	public int addWedding(Wedding wedding);
	
	final String getWeddingChatsSql = "select * from WeddingChat where wedding_number=#{wedding_number}";
	@Select(getWeddingChatsSql)
	public ArrayList<WeddingChat> getWeddingChats(int wedding_number);
	
	final String addWeddingChatSql = "insert into WeddingChat(wedding_chat_number,text,wedding_number,user_id) values ("
			+ "#{wedding_chat_number},#{text},#{wedding_number},#{user_id})";
	@Insert(addWeddingChatSql)
	public int addWeddingChat(WeddingChat weddingChat);
	
	final String getWeddingIssuesSql = "select * from WeddingIssue where wedding_number=#{wedding_number}";
	@Select(getWeddingIssuesSql)
	public ArrayList<WeddingIssue> getWeddingIssues(int wedding_number);
	
	final String addWeddingIssueSql = "insert into WeddingIssue (issue_number, wedding_number , title , text) values(#{issue_number}, #{wedding_number} , #{title} , #{text})";
	@Insert(addWeddingIssueSql)
	public int addWeddingIssue(WeddingIssue weddingIssue);
	
	final String deleteWeddingIssueSql = "delete from WeddingIssue where issue_number=#{issue_number}";
	@Delete(deleteWeddingIssueSql)
	public int deleteWeddingIssue(int issue_number);
	
	public String getWeddingPhotosSql = "select * from WeddingPhoto where wedding_number=#{wedding_number}";
	@Select(getWeddingPhotosSql)
	public ArrayList<WeddingPhoto> getWeddingPhotos(int wedding_number);
	
	public String addWeddingPhotoSql = "insert into WeddingPhoto (photo_number , wedding_number , title , imgUrl , user_id) values("
			+ "#{photo_number} , #{wedding_number} , #{title} , #{imgUrl} , #{user_id}"
			+ ")"; 
	@Insert(addWeddingPhotoSql)
	public int addWeddingPhoto(WeddingPhoto weddingPhoto);
}
