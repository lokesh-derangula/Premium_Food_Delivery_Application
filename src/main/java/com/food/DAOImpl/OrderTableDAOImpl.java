package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrderTableDAO;
import com.food.Model.OrderTable;
import com.food.utility.DBConnection;

public class OrderTableDAOImpl implements OrderTableDAO {

    private static final String INSERT_QUERY =
            "INSERT INTO order_table(userId, orderDate, totalAmount, status, paymentMethod, restaurantId) VALUES(?,?,?,?,?,?)";

    private static final String GET_BY_ID_QUERY =
            "SELECT * FROM order_table WHERE orderId=?";

    private static final String GET_ALL_QUERY =
            "SELECT * FROM order_table";

    private static final String GET_BY_USER_ID_QUERY =
            "SELECT * FROM order_table WHERE userId=?";

    private static final String GET_BY_RESTAURANT_ID_QUERY =
            "SELECT * FROM order_table WHERE restaurantId=?";

    private static final String UPDATE_QUERY =
            "UPDATE order_table SET userId=?, orderDate=?, totalAmount=?, status=?, paymentMethod=?, restaurantId=? WHERE orderId=?";

    private static final String DELETE_QUERY =
            "DELETE FROM order_table WHERE orderId=?";

    @Override
    public int addOrder(OrderTable order) {

        int result = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY, java.sql.Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setTimestamp(2, order.getOrderDate());
            pstmt.setDouble(3, order.getTotalAmount());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getPaymentMethod());
            pstmt.setInt(6, order.getRestaurantId());

            pstmt.executeUpdate();
            
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    result = generatedKeys.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public OrderTable getOrderById(int orderId) {

        OrderTable order = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_ID_QUERY)) {

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                order = extractOrderFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public List<OrderTable> getAllOrders() {

        List<OrderTable> orderList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_QUERY);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                orderList.add(extractOrderFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    @Override
    public List<OrderTable> getOrdersByUserId(int userId) {

        List<OrderTable> orderList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_USER_ID_QUERY)) {

            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderList.add(extractOrderFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    @Override
    public List<OrderTable> getOrdersByRestaurantId(int restaurantId) {

        List<OrderTable> orderList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_RESTAURANT_ID_QUERY)) {

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderList.add(extractOrderFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    @Override
    public int updateOrder(OrderTable order) {

        int result = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setTimestamp(2, order.getOrderDate());
            pstmt.setDouble(3, order.getTotalAmount());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getPaymentMethod());
            pstmt.setInt(6, order.getRestaurantId());
            pstmt.setInt(7, order.getOrderId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public int deleteOrder(int orderId) {

        int result = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, orderId);

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    private OrderTable extractOrderFromResultSet(ResultSet rs) throws SQLException {

        OrderTable order = new OrderTable();

        order.setOrderId(rs.getInt("orderId"));
        order.setUserId(rs.getInt("userId"));
        order.setOrderDate(rs.getTimestamp("orderDate"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setStatus(rs.getString("status"));
        order.setPaymentMethod(rs.getString("paymentMethod"));
        order.setRestaurantId(rs.getInt("restaurantId"));

        return order;
    }
}