package com.food.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callLoginServlet")
public class LoginServlet extends HttpServlet
{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		HttpSession session = req.getSession();
		
		UserDAOImpl userDAOImpl = new UserDAOImpl();
		
		User user = userDAOImpl.getUserByEmail(email);
		String name = user.getUsername();
		String dbPassword = user.getPassword();
				if(BCrypt.checkpw(password, dbPassword))
		{
			session.setAttribute("username", name);
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("user", user);
			resp.sendRedirect("callRestaurantServlet");
		}
		else
		{
			resp.sendRedirect("login.jsp");
		}
		
	}

}
