package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrderItemDAO;
import com.food.Model.OrderItem;
import com.food.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String INSERT_QUERY =
            "INSERT INTO orderitem(orderId, quantity, itemTotal, menuId) VALUES(?,?,?,?)";

    private static final String GET_BY_ID_QUERY =
            "SELECT * FROM orderitem WHERE orderItemId=?";

    private static final String GET_ALL_QUERY =
            "SELECT * FROM orderitem";

    private static final String GET_BY_ORDER_ID_QUERY =
            "SELECT * FROM orderitem WHERE orderId=?";

    private static final String UPDATE_QUERY =
            "UPDATE orderitem SET orderId=?, quantity=?, itemTotal=?, menuId=? WHERE orderItemId=?";

    private static final String DELETE_QUERY =
            "DELETE FROM orderitem WHERE orderItemId=?";

    @Override
    public int addOrderItem(OrderItem orderItem) {

        int result = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getQuantity());
            pstmt.setDouble(3, orderItem.getItemTotal());
            pstmt.setInt(4, orderItem.getMenuId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public OrderItem getOrderItemById(int orderItemId) {

        OrderItem orderItem = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_ID_QUERY)) {

            pstmt.setInt(1, orderItemId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                orderItem = extractOrderItemFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_QUERY);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_ORDER_ID_QUERY)) {

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public int updateOrderItem(OrderItem orderItem) {

        int result = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getQuantity());
            pstmt.setDouble(3, orderItem.getItemTotal());
            pstmt.setInt(4, orderItem.getMenuId());
            pstmt.setInt(5, orderItem.getOrderItemId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public int deleteOrderItem(int orderItemId) {

        int result = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, orderItemId);

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    private OrderItem extractOrderItemFromResultSet(ResultSet rs) throws SQLException {

        OrderItem orderItem = new OrderItem();

        orderItem.setOrderItemId(rs.getInt("orderItemId"));
        orderItem.setOrderId(rs.getInt("orderId"));
        orderItem.setQuantity(rs.getInt("quantity"));
        orderItem.setItemTotal(rs.getDouble("itemTotal"));
        orderItem.setMenuId(rs.getInt("menuId"));

        return orderItem;
    }
}