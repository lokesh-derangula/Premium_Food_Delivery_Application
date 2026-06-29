<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.food.Model.OrderTable,com.food.Model.OrderItem,com.food.Model.Restaurant,com.food.Model.Menu,com.food.DAOImpl.OrderTableDAOImpl,com.food.DAOImpl.OrderItemDAOImpl,com.food.DAOImpl.RestaurantDAOImpl,com.food.DAOImpl.MenuDAOImpl"%>
<%
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
com.food.Model.User user = (com.food.Model.User) session.getAttribute("user");
String username = user.getUsername();
int userId = user.getUserId();

OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
MenuDAOImpl menuDAO = new MenuDAOImpl();

List<OrderTable> ordersList = orderDAO.getOrdersByUserId(userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | Order History</title>

<!-- Fonts & Icons -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Style sheet -->
<link rel="stylesheet" href="restaurant.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/restaurant.css">
<style>
	.order-card {
		background: rgba(255, 255, 255, 0.35);
		border-radius: 24px;
		padding: 25px;
		box-shadow: 0 15px 35px rgba(43, 31, 26, 0.03);
		border: 1px solid rgba(255, 255, 255, 0.3);
		margin-bottom: 25px;
		transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
	}
	.order-card:hover {
		transform: translateY(-3px);
		background: rgba(255, 255, 255, 0.55);
		border-color: rgba(255, 255, 255, 0.45);
		box-shadow: 0 20px 45px rgba(217, 83, 51, 0.08);
	}
	.order-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px solid rgba(255, 255, 255, 0.2);
		padding-bottom: 15px;
		margin-bottom: 15px;
		flex-wrap: wrap;
		gap: 15px;
	}
	.order-meta-left {
		display: flex;
		align-items: center;
		gap: 15px;
	}
	.order-restaurant-img {
		width: 50px;
		height: 50px;
		border-radius: 12px;
		object-fit: cover;
		border: 1px solid rgba(255, 255, 255, 0.3);
	}
	.order-details h3 {
		font-family: var(--font-sans);
		font-weight: 700;
		font-size: 16px;
		color: var(--text-main);
		margin: 0;
	}
	.order-date {
		font-size: 12px;
		color: var(--text-light);
		margin-top: 2px;
	}
	.order-status {
		padding: 4px 12px;
		border-radius: 20px;
		font-size: 11px;
		font-weight: 700;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}
	.order-status.pending {
		background: #FFF8EB;
		color: #E28C00;
	}
	.order-status.delivered {
		background: #E8F8F0;
		color: #10B981;
	}
	.order-items-list {
		margin-bottom: 15px;
		display: flex;
		flex-direction: column;
		gap: 8px;
	}
	.order-item-row {
		display: flex;
		justify-content: space-between;
		font-size: 14px;
		color: var(--text-muted);
	}
	.order-item-row .qty-name {
		font-weight: 500;
	}
	.order-item-row .price {
		font-weight: 600;
		color: var(--text-main);
	}
	.order-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-top: 1px dashed rgba(255, 255, 255, 0.2);
		padding-top: 15px;
		margin-top: 8px;
	}
	.order-payment {
		font-size: 12px;
		color: var(--text-light);
	}
	.order-total {
		font-size: 16px;
		font-weight: 700;
		color: var(--primary);
	}
</style>
</head>

<body class="app-body">

	<!-- Background Video -->
	<div class="video-background-container">
		<video autoplay muted loop playsinline id="bgVideo">
			<source src="videos/demo.mp4" type="video/mp4">
			<source src="${pageContext.request.contextPath}/videos/demo.mp4" type="video/mp4">
		</video>
		<div class="video-background-overlay"></div>
	</div>

	<!-- Main Glassmorphic Card Container -->
	<div class="glass-container">
		
		<!-- Header Navbar -->
		<header class="glass-header">
			<div style="display: flex; align-items: center; gap: 20px;">
				<span style="font-weight: 600; color: var(--text-main); font-size: 15px; cursor: pointer; display: flex; align-items: center; gap: 8px;">
					<i class="fa-solid fa-bars"></i> Home
				</span>
				<a href="index.jsp" class="logo">
					<span>🍔</span> FeastFlow
				</a>
			</div>
			
			<div class="welcome-info">
				<div class="avatar-wrapper">
					<img src="images/profile-logo.png" alt="Avatar">
				</div>
				<div class="separator"></div>
				<span>Welcome, <%= username %>!</span>
				<a href="logout.jsp" class="slider-order-btn" style="margin-left: 15px;">Logout</a>
			</div>
		</header>

		<!-- Main body -->
		<div class="glass-main-body">
			
			<!-- Left Navigation Sidebar -->
			<aside class="glass-sidebar">
				<a href="index.jsp" class="sidebar-icon-link" title="Home">
					<i class="fa-solid fa-house"></i>
				</a>
				<a href="callRestaurantServlet?view=dashboard" class="sidebar-icon-link" title="Restaurants Dashboard">
					<i class="fa-solid fa-shop"></i>
				</a>
				<a href="profile.jsp" class="sidebar-icon-link" title="Profile">
					<i class="fa-solid fa-user"></i>
				</a>
				<a href="orderHistory.jsp" class="sidebar-icon-link active" title="Order History">
					<i class="fa-solid fa-calendar-days"></i>
				</a>
				<a href="cart.jsp" class="sidebar-icon-link" title="Shopping Cart">
					<i class="fa-solid fa-receipt"></i>
				</a>
				<a href="#" class="sidebar-icon-link" title="Notifications">
					<i class="fa-solid fa-bell"></i>
				</a>
				
			</aside>

			<!-- Content Pane -->
			<main class="glass-content-pane">
				
				<div class="dashboard-section-header" style="margin-bottom: 25px;">
					<h2>Order History</h2>
					<span style="font-size: 14px; color: var(--text-light);">Past Orders</span>
				</div>

				<% if (ordersList == null || ordersList.isEmpty()) { %>
					<div style="text-align: center; padding: 80px 20px; color: var(--text-light);">
						<i class="fa-solid fa-receipt" style="font-size: 56px; margin-bottom: 18px; opacity: 0.5;"></i>
						<h3>No Orders Yet</h3>
						<p>You haven't placed any gourmet orders with FeastFlow yet.</p>
						<a href="callRestaurantServlet?view=dashboard" class="slider-order-btn" style="display: inline-block; margin-top: 20px;">Explore Restaurants</a>
					</div>
				<% } else { 
					// Sort list to show latest orders first
					java.util.Collections.reverse(ordersList);
					for (OrderTable order : ordersList) {
						Restaurant restaurant = restaurantDAO.getRestaurantById(order.getRestaurantId());
						String restaurantName = (restaurant != null) ? restaurant.getRestaurantName() : "FeastFlow Partner";
						String restaurantImg = (restaurant != null) ? restaurant.getImagePath() : "images/placeholder.jpg";
						List<OrderItem> items = orderItemDAO.getOrderItemsByOrderId(order.getOrderId());
				%>
					<div class="order-card">
						<div class="order-header">
							<div class="order-meta-left">
								<img src="<%= restaurantImg %>" alt="<%= restaurantName %>" class="order-restaurant-img">
								<div class="order-details">
									<h3><%= restaurantName %></h3>
									<div class="order-date">
										ID: #<%= order.getOrderId() %> &bull; 
										<%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(order.getOrderDate()) %>
									</div>
								</div>
							</div>
							<div class="order-status <%= order.getStatus().toLowerCase() %>">
								<%= order.getStatus() %>
							</div>
						</div>

						<div class="order-items-list">
							<% 
							if (items != null) {
								for (OrderItem item : items) {
									Menu menu = menuDAO.getMenuById(item.getMenuId());
									String itemName = (menu != null) ? menu.getItemName() : "Gourmet Dish";
							%>
								<div class="order-item-row">
									<span class="qty-name"><%= item.getQuantity() %> x <%= itemName %></span>
									<span class="price">₹ <%= (int)item.getItemTotal() %></span>
								</div>
							<% 
								}
							} 
							%>
						</div>

						<div class="order-footer">
							<span class="order-payment">Paid via: <b><%= order.getPaymentMethod() %></b></span>
							<span class="order-total">Total: ₹ <%= (int)order.getTotalAmount() %></span>
						</div>
					</div>
				<% 
					}
				} 
				%>

			</main>

		</div>

	</div>

</body>
</html>
