package server.db.createtable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class CreateTable {
	ConnectorDB db = new ConnectorDB();
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public CreateTable() {
		db.start();
		conn = db.getConn();
		create();
		db.end();
	}
	
	public void create() {
		//user();
		//userLocation();
		//userWorkDate();
		//location();
		locationIssue();
//		locationPosition();
		//hall();
//		wedding();
		//weddingPhoto();
//		weddingIssue();
		//this.locationChat();
		//this.weddingChat();
	}
	public void user() {
		String sql = "create table user ("
				+ "user_id varchar(20) primary key,"
				+ "user_pw varchar(20) not null,"
				+ "name varchar(20) not null,"
				+ "nickname varchar(20) not null,"
				+ "registration_number varchar(20) not null,"
				+ "work_site varchar(50) not null , "
				+ "phone varchar(20) not null "
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void userLocation() {
		String sql = "create table UserLocation ("
				+ "location_number int not null , "
				+ "user_id varchar(20) not null"
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	public void userWorkDate() {
		String sql = "create table UserWorkDate ("
				+ "location_number int not null , "
				+ "user_id varchar(20) not null , "
				+ "work_date varchar(20) not null"
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void location() {
		String sql = "create table Location ("
				+ "location_number int primary key auto_increment , "
				+ "name varchar(20) not null , "
				+ "imgUrl varchar(500) "
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void locationIssue() {
		String sql = "create table LocationIssue ("
				+ "issue_number int primary key auto_increment ,"
				+ "location_number int not null ,"
				+ "title varchar(50) not null , "
				+ "text varchar(500) not null , "
				+ "work_date varchar(20) not null"
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void locationPosition() {
		String sql = "create table LocationPosition ("
				+ "location_number int not null ,"
				+ "hall_number int not null ,"
				+ "title varchar(20) not null , "
				+ "user_id varchar(20) not null , "
				+ "work_date varchar(20) not null"
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void hall(){
		String sql = "create table Hall ("
				+ "hall_number int primary key auto_increment ,"
				+ "location_number int not null , "
				+ "name varchar(20) not null , "
				+ "nickname varchar(20) not null"
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void wedding() {
		String sql = "create table Wedding ("
				+ "wedding_number int primary key auto_increment ,"
				+ "location_number int not null , "
				+ "hall_number int not null , "
				+ "work_date varchar(20) not null , "
				+ "title varchar(50) not null"
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void weddingIssue() {
		String sql = "create table WeddingIssue ("
				+ "issue_number int primary key auto_increment ,"
				+ "wedding_number int not null , "
				+ "title varchar(50) not null , "
				+ "text varchar(500) not null  "
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void weddingPhoto() {
		String sql = "create table WeddingPhoto ("
				+ "photo_number int primary key auto_increment ,"
				+ "wedding_number int not null ,  "
				+ "title varchar(50) not null , "
				+ "imgUrl varchar(500) not null , "
				+ "user_id varchar(20) not null "
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void weddingChat() {
		String sql = "create table weddingChat ("
				+ "wedding_chat_number int primary key auto_increment ,"
				+ "text varchar(500) not null , "
				+ "wedding_number int not null ,"
				+ "user_id varchar(20) not null "
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public void locationChat() {
		String sql = "create table LocationChat ("
				+ "location_chat_number int primary key auto_increment ,"
				+ "text varchar(500) not null , "
				+ "location_number int not null ,"
				+ "work_date varchar(20) not null , "
				+ "user_id varchar(20) not null  "
				+ ")";
		
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
}	
