package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.UserDAO;
import com.food.Model.User;
import com.food.utility.DBConnection;

public class UserDAOImpl implements UserDAO{

	private static final String INSERT_QUERY = "INSERT INTO user(username, password, email, address, role, "
			+ "createdDate, lastLoginDate) Values(?,?,?,?,?,?,?)";
	
	private static final String SELECT_QUERY = "SELECT * FROM user WHERE userId = ?";
	
	private static final String UPDATE_QUERY = "UPDATE user SET username = ?, password = ?, email = ?, "
			+ "address = ?, lastLoginDate = ? WHERE userID = ?";
	
	private static final String DELETE_QUERY = "DELETE FROM user WHERE userId = ?";
	
	private static final String SELECT_ALL_QUERY = "SELECT * FROM user";
	
	
	@Override
	public int addUser(User user) {
		Connection con  = DBConnection.getConnection();
		try 
		{
			PreparedStatement stmt = con.prepareStatement(INSERT_QUERY);
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getPassword());
			stmt.setString(3, user.getEmail());
			stmt.setString(4, user.getAddress());
			stmt.setString(5, user.getRole());
			stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			stmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			int i = stmt.executeUpdate();
			return i;
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	
	@Override
	public User getUser(int userId) {
		User user = null;
		
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY);
			
			pstmt.setInt(1, userId);
			ResultSet res = pstmt.executeQuery();
			
			while(res.next())
			{
				int id = res.getInt("userId");
				String username = res.getString("username");
				String password = res.getString("password");
				String email = res.getString("email");
				String address = res.getString("address");
				String role = res.getString("role");
				Timestamp createdDate = res.getTimestamp("createdDate");
				Timestamp LastLoginDate = res.getTimestamp("LastLoginDate");
				
				user = new User(userId, username, password, email, address, role, createdDate, LastLoginDate);
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}

	
	@Override
	public void updateUser(User user) {
		
		Connection connection = DBConnection.getConnection();
		
		try
		{
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getAddress());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.setInt(6, user.getUserId());
			
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteUser(int userId) {
		
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, userId);
			
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public List<User> getAllUsers() {
		
		List<User> list = new ArrayList<User>();
		Connection con = DBConnection.getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);
			
			while(res.next())
			{
				int userId = res.getInt("userId");
				String username = res.getString("username");
				String password = res.getString("password");
				String email = res.getString("email");
				String address = res.getString("address");
				String role = res.getString("role");
				Timestamp createdDate = res.getTimestamp("createdDate");
				Timestamp LastLoginDate = res.getTimestamp("LastLoginDate");
				
				User user = new User(userId, username, password, email, address, role, createdDate, LastLoginDate);
				list.add(user);
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public User getUserByEmail(String mailId) {
		User user = null;
		String email_Query = "SELECT * FROM User WHERE email = ?";
		
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(email_Query);
			
			pstmt.setString(1, mailId);
			ResultSet res = pstmt.executeQuery();
			
			while(res.next())
			{
				int userId = res.getInt("userId");
				String username = res.getString("username");
				String password = res.getString("password");
				String email = res.getString("email");
				String address = res.getString("address");
				String role = res.getString("role");
				Timestamp createdDate = res.getTimestamp("createdDate");
				Timestamp LastLoginDate = res.getTimestamp("LastLoginDate");
				
				user = new User(userId, username, password, email, address, role, createdDate, LastLoginDate);
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}

	
	

}
