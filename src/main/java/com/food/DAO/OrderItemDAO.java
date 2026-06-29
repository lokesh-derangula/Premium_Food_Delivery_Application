package com.food.DAO;

import java.util.List;

import com.food.Model.OrderItem;

public interface OrderItemDAO {

    int addOrderItem(OrderItem orderItem);

    OrderItem getOrderItemById(int orderItemId);

    List<OrderItem> getAllOrderItems();

    List<OrderItem> getOrderItemsByOrderId(int orderId);

    int updateOrderItem(OrderItem orderItem);

    int deleteOrderItem(int orderItemId);
}