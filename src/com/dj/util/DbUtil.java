package com.dj.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {
	
	private String driver="com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://localhost/shidejun?useUnicode=true&characterEncoding=UTF-8";
	private String user="root";
	private String password="123456";
	
	public Connection open() throws Exception{
		Class.forName(driver);
		return DriverManager.getConnection(url, user, password);
	}
	
	public void close(Connection con) throws SQLException {
		con.close();
	}
	
}