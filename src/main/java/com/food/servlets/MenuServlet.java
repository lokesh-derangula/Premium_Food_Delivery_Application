package com.food.servlets;


import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/Menu")
public class MenuServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		jakarta.servlet.http.HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("username") == null)
		{
			resp.sendRedirect("login.jsp");
			return;
		}

		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		
		
		String restaurantIdParam = req.getParameter("restaurantId");

		if (restaurantIdParam == null || restaurantIdParam.trim().isEmpty()) {
		    resp.sendRedirect("callRestaurantServlet");
		    return;
		}

		int restaurantId = Integer.parseInt(restaurantIdParam);
		List<Menu> allmenusByRestaurantId = menuDAOImpl.getMenusByRestaurantId(restaurantId);
		req.setAttribute("allmenusByRestaurantId", allmenusByRestaurantId);
		
		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
		rd.forward(req, resp);
	}

}
