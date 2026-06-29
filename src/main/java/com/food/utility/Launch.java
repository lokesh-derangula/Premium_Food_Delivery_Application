package com.food.utility;

import java.util.List;
import java.util.Scanner;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

public class Launch {

	public static void main(String[] args) {
		Scanner scan =  new Scanner(System.in);
		
		
//		System.out.println("Enter the userName:");
//		String username = scan.next();
//		System.out.println("Enter the password:");
//		String password = scan.next();
//		System.out.println("Enter the email:");
//		String email = scan.next();
//		System.out.println("Enter the address:");
//		String address = scan.next();
//		System.out.println("Enter the role:");
//		String role = scan.next();
//		
//		User u = new User(username, password, email, address, role);
		UserDAOImpl udao = new UserDAOImpl();
//
//		1. ADDING USER
//		udao.addUser(u);
//		System.out.println(u);
		
//		2. GETTING USER
//		System.out.println(u);
//		User u = udao.getUser(1);
//		
//		3. UPDATE USER
//		u.setAddress("BTM Layout");
//		u.setEmail("loku@gmail.com");
//		
//		udao.updateUser(u);
//		System.out.println("User Updated");
		
//		4. DELETE USER
//		udao.deleteUser(1);
//		System.out.println("User Deleted");
		
//		5. GET ALL USERS
		List<User> allUsers = udao.getAllUsers();
		for(User u : allUsers)
		{
			System.out.println(u);
		}
		

	}

}
