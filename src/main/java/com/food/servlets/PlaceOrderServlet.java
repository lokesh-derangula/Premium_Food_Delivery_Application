package com.food.servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;

import com.food.DAOImpl.OrderItemDAOImpl;
import com.food.DAOImpl.OrderTableDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.OrderItem;
import com.food.Model.OrderTable;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        // Extract parameters from checkout form
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String pincode = req.getParameter("pincode");
        String paymentMethod = req.getParameter("payment");
        double totalAmount = Double.parseDouble(req.getParameter("amount"));
        
        Integer restaurantIdAttr = (Integer) session.getAttribute("restaurantId");
        int restaurantId = (restaurantIdAttr != null) ? restaurantIdAttr : 0;
        
        // If restaurantId is not in session, grab it from any cart item
        if (restaurantId == 0) {
            for (CartItem item : cart.getItems().values()) {
                restaurantId = item.getRestaurantId();
                break;
            }
        }

        // 1. Create and Save Order
        OrderTable order = new OrderTable();
        order.setUserId(userId);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setTotalAmount(totalAmount);
        order.setStatus("Pending");
        order.setPaymentMethod(paymentMethod);
        order.setRestaurantId(restaurantId);

        OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
        int orderId = orderDAO.addOrder(order);

        // 2. Save Order Items
        if (orderId > 0) {
            OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
            Map<Integer, CartItem> cartItems = cart.getItems();

            for (CartItem cartItem : cartItems.values()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setMenuId(cartItem.getMenuId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setItemTotal(cartItem.getPrice() * cartItem.getQuantity());

                orderItemDAO.addOrderItem(orderItem);
            }

            // 3. Clear Cart
            session.removeAttribute("cart");
            session.removeAttribute("restaurantId");

            // 4. Redirect to confirmation page
            resp.sendRedirect("orderSuccess.jsp");
        } else {
            // Error placing order
            resp.sendRedirect("checkout.jsp?error=failed");
        }
    }
}
