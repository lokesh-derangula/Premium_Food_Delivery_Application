package com.food.DAOImpl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.RestaurantDAO;
import com.food.Model.Restaurant;
import com.food.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

	private static final String INSERT_QUERY =
			"INSERT INTO restaurant(restaurantName, cuisineType, deliveryTime, address, rating, isActive, imagePath) VALUES(?,?,?,?,?,?,?)";

	private static final String GET_BY_ID_QUERY =
			"SELECT * FROM restaurant WHERE restaurantId=?";

	private static final String GET_ALL_QUERY =
			"SELECT * FROM restaurant";

	private static final String UPDATE_QUERY =
			"UPDATE restaurant SET restaurantName=?, cuisineType=?, deliveryTime=?, address=?, rating=?, isActive=?, imagePath=? WHERE restaurantId=?";

	private static final String DELETE_QUERY =
			"DELETE FROM restaurant WHERE restaurantId=?";

	@Override
	public int addRestaurant(Restaurant restaurant) {

		int result = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)) {

			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3, restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setDouble(5, restaurant.getRating());
			pstmt.setBoolean(6, restaurant.isActive());
			pstmt.setString(7, restaurant.getImagePath());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public Restaurant getRestaurantById(int restaurantId) {

		Restaurant restaurant = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_BY_ID_QUERY)) {

			pstmt.setInt(1, restaurantId);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				restaurant = new Restaurant();

				restaurant.setRestaurantId(rs.getInt("restaurantId"));
				restaurant.setRestaurantName(rs.getString("restaurantName"));
				restaurant.setCuisineType(rs.getString("cuisineType"));
				restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
				restaurant.setAddress(rs.getString("address"));
				restaurant.setRating(rs.getDouble("rating"));
				restaurant.setActive(rs.getBoolean("isActive"));
				restaurant.setImagePath(rs.getString("imagePath"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurant;
	}

	@Override
	public List<Restaurant> getAllRestaurants() {

		List<Restaurant> restaurantList = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_QUERY);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {

				Restaurant restaurant = new Restaurant();

				restaurant.setRestaurantId(rs.getInt("restaurantId"));
				restaurant.setRestaurantName(rs.getString("restaurantName"));
				restaurant.setCuisineType(rs.getString("cuisineType"));
				restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
				restaurant.setAddress(rs.getString("address"));
				restaurant.setRating(rs.getDouble("rating"));
				restaurant.setActive(rs.getBoolean("isActive"));
				restaurant.setImagePath(rs.getString("imagePath"));

				restaurantList.add(restaurant);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurantList;
	}

	@Override
	public int updateRestaurant(Restaurant restaurant) {

		int result = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)) {

			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3, restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setDouble(5, restaurant.getRating());
			pstmt.setBoolean(6, restaurant.isActive());
			pstmt.setString(7, restaurant.getImagePath());
			pstmt.setInt(8, restaurant.getRestaurantId());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int deleteRestaurant(int restaurantId) {

		int result = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

			pstmt.setInt(1, restaurantId);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

}	
