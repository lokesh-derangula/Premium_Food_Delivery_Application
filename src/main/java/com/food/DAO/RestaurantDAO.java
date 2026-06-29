package com.food.DAO;

import java.util.List;

import com.food.Model.Restaurant;

public interface RestaurantDAO
{
	// Create Restaurant
	int addRestaurant(Restaurant restaurant);
	
	// Get Restaurant
    Restaurant getRestaurantById(int restaurantId);

	// Get All Restaurants
    List<Restaurant> getAllRestaurants();

    
	// Update Restaurant
    int updateRestaurant(Restaurant restaurant);
    
	// Delete Restaurant
    int deleteRestaurant(int restaurantId);


}
