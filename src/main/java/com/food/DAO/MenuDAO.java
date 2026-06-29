package com.food.DAO;

import java.util.List;

import com.food.Model.Menu;

public interface MenuDAO 
{

    int addMenu(Menu menu);

    Menu getMenuById(int menuId);

    List<Menu> getAllMenus();

    List<Menu> getMenusByRestaurantId(int restaurantId);

    int updateMenu(Menu menu);

    int deleteMenu(int menuId);
}
