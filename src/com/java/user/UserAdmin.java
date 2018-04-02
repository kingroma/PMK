package com.java.user;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import com.java.util.ServerStaticData;

public class UserAdmin {
	private Properties properties;
	private File file;
	private FileInputStream fis;
	public UserAdmin() {
		properties = new Properties();
		file = new File(ServerStaticData.AdminPath);
		try {
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean isAdminUserId(String user_id) {
		user_id = user_id.toLowerCase();
		boolean result = false;
		try {
			fis = new FileInputStream(file);
			properties.load(fis);
			String id = properties.getProperty(user_id);
			if(id != null) {
				result = true;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(fis!=null) {
					fis.close();	
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public void addAdminUserId(String user_id) {
		try {
			fis = new FileInputStream(file);
			properties.load(fis);
			properties.put(user_id, "o");
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(fis!=null) {
					fis.close();	
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
