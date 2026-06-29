package com.food.Model;

import java.util.HashMap;
import java.util.Map;

public class Cart {

    private Map<Integer, CartItem> items;

    public Cart() {
        items = new HashMap<>();
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void addItem(CartItem cartItem) {

        int menuId = cartItem.getMenuId();

        if(items.containsKey(menuId)) {
            CartItem existing = items.get(menuId);
            existing.setQuantity(existing.getQuantity() + 1);
        } else {
            items.put(menuId, cartItem);
        }
    }

    public void updateItem(int menuId, int quantity) {

        if(items.containsKey(menuId)) {
        		CartItem existing = items.get(menuId);
            if(quantity <= 0) {
                items.remove(menuId);
            } else {
                existing.setQuantity(quantity);
            }
        }
    }

    public void removeItem(int menuId) {
        items.remove(menuId);
    }

    public double getTotalPrice() {
        double total = 0;

        for(CartItem item : items.values()) {
            total += item.getTotalPrice();
        }

        return total;
    }

    public int getTotalItems() {
        int total = 0;

        for(CartItem item : items.values()) {
            total += item.getQuantity();
        }

        return total;
    }

    public void clearCart() {
        items.clear();
    }
}
