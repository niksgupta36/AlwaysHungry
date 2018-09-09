package com.nikhil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderDAOImpl {
	static Connection conn;
	static PreparedStatement ps;

	public void addOrder(String custname, int orderid) {
		// TODO Auto-generated method stub
		conn = ConnectionProvider.getCon();
		try {
			ps = conn.prepareStatement("insert into OrderTable values(?,?,?)");
			ps.setString(1, custname);
			ps.setLong(2, orderid);
			ps.setString(3, "Active");
			ps.execute();
			conn.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int getOrder(String custname) {
		// TODO Auto-generated method stub
		conn = ConnectionProvider.getCon();
		try {
			ps = conn.prepareStatement("select OrderId from OrderTable where Name=(?) and status='Active'");
			ps.setString(1, custname);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				return rs.getInt(1);
			}
			conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public void changestatus(int orderid) {
		
		conn = ConnectionProvider.getCon();

		try {
			ps = conn.prepareStatement("update OrderTable set STATUS = (?) where orderid = (?)");

			ps.setString(1, "Completed");
			ps.setLong(2, orderid);

			ps.executeUpdate();
			conn.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

