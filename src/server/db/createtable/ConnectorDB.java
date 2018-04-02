package server.db.createtable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectorDB {
	private Connection conn = null;
	private String db_jdbc = "com.mysql.jdbc.Driver";
	private String db_url = "jdbc:mysql://127.0.0.1:3306/test";
	private String db_id = "root";
	private String db_pw = "4235";
	
	public ConnectorDB() {
		
	}
	public boolean start(){
        try {
            Class.forName(db_jdbc);
            conn = DriverManager.getConnection(db_url,db_id,db_pw);
            System.out.println("db [[ START ]]");

        }catch(Exception e) {
        	e.printStackTrace();
        	return false;
        }
        return true;
    }
	
	public boolean end(){
		try {
            if (conn != null) conn.close();
            conn = null;
            System.out.println("db [[ END ]]");
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
		return true;
	}
	public Connection getConn() {
		return conn;
	}
	public void setConn(Connection conn) {
		this.conn = conn;
	}
}
