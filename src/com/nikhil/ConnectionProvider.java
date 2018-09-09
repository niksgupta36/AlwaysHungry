package com.nikhil;

import java.sql.Connection;
import com.microsoft.sqlserver.jdbc.SQLServerDriver;

import java.sql.DriverManager;

public class ConnectionProvider {
	static String connectionString =  
             "jdbc:sqlserver://niksgupta37.database.windows.net:1433;"  
             + "database=niksgupta36;"  
             + "user=niks36@niksgupta37;"  
             + "password=India@123;"  
             + "encrypt=true;"  
             + "trustServerCertificate=false;"  
             + "hostNameInCertificate=*.database.windows.net;"  
             + "loginTimeout=30;";  
	
 static Connection conn=null;
	public static Connection getCon(){
		
		try{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn=DriverManager.getConnection(connectionString);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;
		
	}
}
