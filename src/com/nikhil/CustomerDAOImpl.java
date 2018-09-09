package com.nikhil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAOImpl {
	
	static Connection conn;
	static PreparedStatement ps;
	
	public void addCustomer(Customer cust) {
		// TODO Auto-generated method stub
		conn = ConnectionProvider.getCon();
		//System.out.println(conn);
		try {
			ps = conn.prepareStatement("insert into Customer values(?,?,?,?)");
			ps.setString(1, cust.getName());
			ps.setString(2, cust.getPassword());
			ps.setString(3, cust.getEmailid());
			ps.setString(4, cust.getFaceid());
			ps.execute();
			conn.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String logincheck(String name) {
		// TODO Auto-generated method stub
		conn = ConnectionProvider.getCon();
		
		try {
			ps = conn.prepareStatement("select PASSWORD from Customer where EMAILID= (?)");
			ps.setString(1, name);
			
		ResultSet rs =	ps.executeQuery();
		String s="";
		while(rs.next()) s=rs.getString(1);
		//System.out.println(s);
			return s;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getName(String faceid) {
		String custname="";
		conn = ConnectionProvider.getCon();

		try {
			ps = conn.prepareStatement("select * from Customer");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				FaceVerify verify = new FaceVerify();

				if (verify.getVerify(rs.getString(4), faceid) ) {
					
						return rs.getString(1);
					
				}
					
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return custname;

	}
	
}
