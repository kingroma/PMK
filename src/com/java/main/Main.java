package com.java.main;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Main {

	public static void main(String[] args) {
		
//		CreateTable db = new CreateTable();
//		Controller controller = new Controller();
		
		//2018 03 31 10 00   /   WaterFall_2018/4/1
		try {
			String date_s = "2018-04-01 00:00:00.0"; 
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
			Date date = dt.parse(date_s); 

			date.setDate(0);
			
			
			/*
			
			String input = "201803311000";
			date.setYear(Integer.parseInt(input.substring(0, 4)));
			date.setMonth(Integer.parseInt(input.substring(4, 6)));
			date.setDate(Integer.parseInt(input.substring(6, 8)));
			date.setHours(Integer.parseInt(input.substring(8, 10)));
			date.setMinutes(Integer.parseInt(input.substring(10, 12)));
			*/
			System.out.println(date.toString());
			System.out.println(date.getMonth());
			System.out.println(date.getYear());
			System.out.println(date.getDay());
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
		
}
