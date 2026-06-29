package com.food.DAO;

import java.util.List;

import com.food.Model.OrderTable;

public interface OrderTableDAO {

    int addOrder(OrderTable order);

    OrderTable getOrderById(int orderId);

    List<OrderTable> getAllOrders();

    List<OrderTable> getOrdersByUserId(int userId);

    List<OrderTable> getOrdersByRestaurantId(int restaurantId);

    int updateOrder(OrderTable order);

    int deleteOrder(int orderId);
}