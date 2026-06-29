package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callCartServlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");


        int newRestaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        Integer restaurantId = (Integer) session.getAttribute("restaurantId");

        if(cart == null || restaurantId != newRestaurantId) {
            cart = new Cart();
            session.setAttribute("cart", cart);
            session.setAttribute("restaurantId", newRestaurantId);
        }
        

        String action = req.getParameter("action");

        if(action.equals("add"))
        {
             addItemToCart(req, cart);
        }
        else if(action.equals("update"))
        {
             updateItemToCart(req, cart);
        }
        else if(action.equals("delete"))
        {
                deleteItemFromCart(req, cart);
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect("cart.jsp");
    }
    

    private void addItemToCart(HttpServletRequest req, Cart cart) {

        int menuId = Integer.parseInt(req.getParameter("menuId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Menu menu = new MenuDAOImpl().getMenuById(menuId);
        
        HttpSession session = req.getSession();
        session.setAttribute("restaurantId", menu.getRestaurantId());
        
        if(menu!=null)
        {
        CartItem item = new CartItem(
                menu.getMenuId(),
                menu.getRestaurantId(),
                menu.getItemName(),
                menu.getPrice(),
                quantity);

        cart.addItem(item);
        } 
    }

    private void updateItemToCart(HttpServletRequest req, Cart cart) {

        int menuId = Integer.parseInt(req.getParameter("menuId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        cart.updateItem(menuId, quantity);
    }

    private void deleteItemFromCart(HttpServletRequest req, Cart cart) {

        int menuId = Integer.parseInt(req.getParameter("menuId"));
        cart.removeItem(menuId);
    }
}
