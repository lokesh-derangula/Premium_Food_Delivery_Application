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

@WebServlet("/callRegisterServlet")
public class RegisterServlet extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String role = req.getParameter("role");
		String address = req.getParameter("address");
	
		String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(12));
		
		User user = new User(name, hashpw, email, address, role);
		UserDAOImpl userDAO = new UserDAOImpl();
		int res = userDAO.addUser(user);
		
		if(res == 1)
		{
			resp.sendRedirect("login.jsp");
		}
		else
		{
			resp.sendRedirect("registration.jsp");
		}
	
		
		
	}

}
