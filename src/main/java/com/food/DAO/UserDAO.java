package com.food.DAO;

import java.util.List;

import com.food.Model.User;

public interface UserDAO {
	
	int addUser(User user);
	User getUser(int userId);
	void updateUser(User user);
	void deleteUser(int userId);
	List<User> getAllUsers();

}
