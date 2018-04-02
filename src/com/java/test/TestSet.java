package com.java.test;

import java.util.ArrayList;

import com.java.hall.Hall;
import com.java.location.Location;
import com.java.location.LocationIssue;
import com.java.wedding.Wedding;

public class TestSet {
	public static Location location;
	
	public static ArrayList<Wedding> weddings;
	
	public static void testSet() {
		location = new Location();
		weddings = new ArrayList<Wedding>();
		location.setLocation_number(0);
		location.setName("WaterFall");
		
		
		ArrayList<Hall> halls = new ArrayList<Hall>();
		Hall hall = new Hall();
		hall.setHall_number(0);
		hall.setLocation_number(0);
		hall.setName("WaterFall");
		hall.setNickname("W");
		halls.add(hall);
		
		hall = null;
		hall = new Hall();
		hall.setHall_number(1);
		hall.setLocation_number(0);
		hall.setName("Lily");
		hall.setNickname("L");
		halls.add(hall);
		
		hall = null;
		hall = new Hall();
		hall.setHall_number(2);
		hall.setLocation_number(0);
		hall.setName("Rose");
		hall.setNickname("R");
		halls.add(hall);
		
		location.setHalls(halls);
		
		Wedding wedding = new Wedding();
		wedding.setWork_date("201803031100");
		wedding.setHall_number(0);
		wedding.setLocation_number(0);
		wedding.setWedding_number(0);
		weddings.add(wedding);
		
		wedding = null;
		wedding = new Wedding();
		wedding.setWork_date("201803031230");
		wedding.setHall_number(0);
		wedding.setLocation_number(0);
		wedding.setWedding_number(0);
		weddings.add(wedding);
		
		wedding = null;
		wedding = new Wedding();
		wedding.setWork_date("201803031200");
		wedding.setHall_number(1);
		wedding.setLocation_number(0);
		wedding.setWedding_number(0);
		weddings.add(wedding);
		
		wedding = null;
		wedding = new Wedding();
		wedding.setWork_date("201803031300");
		wedding.setHall_number(1);
		wedding.setLocation_number(0);
		wedding.setWedding_number(0);
		weddings.add(wedding);
		
		wedding = null;
		wedding = new Wedding();
		wedding.setWork_date("201803031200");
		wedding.setHall_number(2);
		wedding.setLocation_number(0);
		wedding.setWedding_number(0);
		weddings.add(wedding);
		
		wedding = null;
		wedding = new Wedding();
		wedding.setWork_date("201803031200");
		wedding.setHall_number(0);
		wedding.setLocation_number(0);
		wedding.setWedding_number(0);
		weddings.add(wedding);
		
		ArrayList<LocationIssue> issues = new ArrayList<LocationIssue>();
		LocationIssue issue = new LocationIssue();
		issue.setWork_date("201803030000");
		issue.setLocation_number(0);
		issue.setTitle("title test");
		issue.setText("text test");
		issues.add(issue);
		
		location.setLocationIssues(issues);
		
	}
	
}
