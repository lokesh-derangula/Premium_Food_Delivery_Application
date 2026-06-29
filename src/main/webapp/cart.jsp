<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*,com.food.Model.Cart,com.food.Model.CartItem"%>
<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String username = (String) session.getAttribute("username");

Cart cart = (Cart) session.getAttribute("cart");
Map<Integer, CartItem> items = (cart != null) ? cart.getItems() : null;
double subtotal = 0;
int totalQty = 0;
if (items != null) {
	for (CartItem i : items.values()) {
		subtotal += i.getPrice() * i.getQuantity();
		totalQty += i.getQuantity();
	}
}
double tax = subtotal * 0.05;
double delivery = (subtotal > 0) ? 40 : 0;
double total = subtotal + tax + delivery;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | My Cart</title>

<!-- Fonts & Icons -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Style sheet -->
<link rel="stylesheet" href="restaurant.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/restaurant.css">
<style>
.cart-grid-container {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 30px;
	align-items: start;
}

.cart-item-card {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px;
	background: rgba(255, 255, 255, 0.35);
	border: 1px solid rgba(255, 255, 255, 0.25);
	border-radius: 20px;
	margin-bottom: 18px;
	transition: all 0.3s ease;
}

.cart-item-card:hover {
	transform: translateY(-2px);
	background: rgba(255, 255, 255, 0.55);
	border-color: rgba(255, 255, 255, 0.45);
}

.cart-item-details {
	display: flex;
	gap: 15px;
	align-items: center;
}

.cart-item-details img {
	width: 60px;
	height: 60px;
	border-radius: 14px;
	object-fit: cover;
	border: 1px solid rgba(255, 255, 255, 0.3);
}

.cart-item-info h4 {
	font-size: 16px;
	font-weight: 700;
	color: var(--text-main);
	margin: 0;
}

.cart-item-info p {
	font-size: 13px;
	color: var(--primary);
	font-weight: 600;
	margin: 0;
}

.cart-item-actions {
	display: flex;
	align-items: center;
	gap: 20px;
}

.cart-qty-inline {
	display: flex;
	align-items: center;
	gap: 12px;
	background: rgba(255, 255, 255, 0.5);
	padding: 4px;
	border-radius: 50px;
	border: 1px solid rgba(255, 255, 255, 0.3);
}

.cart-qty-inline form {
	display: inline;
}

.cart-qty-inline button {
	width: 28px;
	height: 28px;
	border-radius: 50%;
	border: none;
	background: rgba(255, 255, 255, 0.8);
	color: var(--text-main);
	cursor: pointer;
	font-size: 14px;
	font-weight: 700;
	display: flex;
	justify-content: center;
	align-items: center;
	transition: all 0.2s;
}

.cart-qty-inline button:hover {
	background: #fff;
	transform: scale(1.05);
}

.cart-qty-inline strong {
	font-size: 14px;
	width: 15px;
	text-align: center;
}

.cart-item-price-col {
	text-align: right;
	width: 120px;
}

.cart-item-price-col strong {
	font-size: 16px;
	color: var(--text-main);
}

.cart-remove-link {
	background: none;
	border: none;
	color: #e53935;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	padding: 0;
	margin-top: 5px;
}

.cart-remove-link:hover {
	text-decoration: underline;
}
</style>
</head>

<body class="app-body">

	<!-- Background Video -->
	<div class="video-background-container">
		<video autoplay muted loop playsinline id="bgVideo">
			<source src="videos/demo.mp4" type="video/mp4">
			<source src="${pageContext.request.contextPath}/videos/demo.mp4"
				type="video/mp4">
		</video>
		<div class="video-background-overlay"></div>
	</div>

	<!-- Main Glassmorphic Card Container -->
	<div class="glass-container">

		<!-- Header Navbar -->
		<header class="glass-header">
			<div style="display: flex; align-items: center; gap: 20px;">
				<span
					style="font-weight: 600; color: var(--text-main); font-size: 15px; cursor: pointer; display: flex; align-items: center; gap: 8px;">
					<i class="fa-solid fa-bars"></i> Home
				</span> <a href="index.jsp" class="logo"> <span>🍔</span> FeastFlow
				</a>
			</div>

			<div class="welcome-info">
				<div class="avatar-wrapper">
					<img src="images/profile-logo.png" alt="Avatar">
				</div>
				<div class="separator"></div>
				<span>Welcome, <%= username %>!
				</span> <a href="logout.jsp" class="slider-order-btn"
					style="margin-left: 15px;">Logout</a>
			</div>
		</header>

		<!-- Main body -->
		<div class="glass-main-body">

			<!-- Left Navigation Sidebar -->
			<aside class="glass-sidebar">
				<a href="index.jsp" class="sidebar-icon-link" title="Home"> <i
					class="fa-solid fa-house"></i>
				</a> <a href="callRestaurantServlet?view=dashboard"
					class="sidebar-icon-link" title="Restaurants Dashboard"> <i
					class="fa-solid fa-shop"></i>
				</a> <a href="profile.jsp" class="sidebar-icon-link" title="Profile">
					<i class="fa-solid fa-user"></i>
				</a> <a href="orderHistory.jsp" class="sidebar-icon-link"
					title="Order History"> <i class="fa-solid fa-calendar-days"></i>
				</a> <a href="cart.jsp" class="sidebar-icon-link active"
					title="Shopping Cart"> <i class="fa-solid fa-receipt"></i>
				</a> <a href="#" class="sidebar-icon-link" title="Notifications"> <i
					class="fa-solid fa-bell"></i>
				</a>

			</aside>

			<!-- Content Pane -->
			<main class="glass-content-pane">

				<div class="dashboard-section-header" style="margin-bottom: 25px;">
					<h2>Your Cart</h2>
					<span style="font-size: 14px; color: var(--text-light);"><%= totalQty %>
						item(s) selected</span>
				</div>

				<%
				if (items == null || items.isEmpty()) {
				%>
				<div
					style="text-align: center; padding: 80px 20px; color: var(--text-light);">
					<i class="fa-solid fa-basket-shopping"
						style="font-size: 56px; margin-bottom: 18px; opacity: 0.5;"></i>
					<h3>Your Cart is Empty</h3>
					<p>Add delicious meals from our partner restaurants.</p>
					<a class="slider-order-btn" href="callRestaurantServlet"
						style="display: inline-block; margin-top: 20px;">Browse
						Restaurants</a>
				</div>
				<%
				} else {
				%>
				<div class="cart-grid-container">

					<!-- Left list of items -->
					<div>
						<%
							for (CartItem item : items.values()) {
							%>
						<div class="cart-item-card">
							<div class="cart-item-details">
								<div class="slider-mini-avatar"
									style="font-size: 24px; width: 54px; height: 54px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: var(--primary-light);">🍔</div>
								<div class="cart-item-info">
									<h4><%= item.getName() %></h4>
									<p>
										₹<%= (int)item.getPrice() %></p>
								</div>
							</div>

							<div class="cart-item-actions">
								<!-- Qty Control Form -->
								<div class="cart-qty-inline">
									<form action="callCartServlet" method="post">
										<input type="hidden" name="menuId"
											value="<%= item.getMenuId() %>"> <input type="hidden"
											name="restaurantId" value="<%= item.getRestaurantId() %>">
										<% if (item.getQuantity() - 1 <= 0) { %>
										<input type="hidden" name="action" value="delete">
										<% } else { %>
										<input type="hidden" name="action" value="update"> <input
											type="hidden" name="quantity"
											value="<%= item.getQuantity() - 1 %>">
										<% } %>
										<button type="submit">-</button>
									</form>

									<strong><%= item.getQuantity() %></strong>

									<form action="callCartServlet" method="post">
										<input type="hidden" name="action" value="update"> <input
											type="hidden" name="menuId" value="<%= item.getMenuId() %>">
										<input type="hidden" name="restaurantId"
											value="<%= item.getRestaurantId() %>"> <input
											type="hidden" name="quantity"
											value="<%= item.getQuantity() + 1 %>">
										<button type="submit">+</button>
									</form>
								</div>

								<!-- Price and Delete button -->
								<div class="cart-item-price-col">
									<strong>₹<%= (int)(item.getPrice() * item.getQuantity()) %></strong>
									<form action="callCartServlet" method="post">
										<input type="hidden" name="action" value="delete"> <input
											type="hidden" name="menuId" value="<%= item.getMenuId() %>">
										<button type="submit" class="cart-remove-link">Remove</button>
									</form>
								</div>
							</div>
						</div>
						<%
							}
							%>
					</div>

					<!-- Right Summary Card -->
					<div class="cart-summary-box" style="padding: 24px;">
						<h3
							style="margin-top: 0; margin-bottom: 15px; font-family: var(--font-sans); font-weight: 700; font-size: 18px; color: var(--text-main);">Order
							Summary</h3>

						<div class="cart-summary-row" style="margin: 10px 0;">
							<span>Items Selected</span> <span><%= totalQty %></span>
						</div>
						<div class="cart-summary-row" style="margin: 10px 0;">
							<span>Subtotal</span> <span>₹<%= (int)subtotal %></span>
						</div>
						<div class="cart-summary-row" style="margin: 10px 0;">
							<span>Tax (5%)</span> <span>₹<%= (int)tax %></span>
						</div>
						<div class="cart-summary-row" style="margin: 10px 0;">
							<span>Delivery Coordination</span> <span>₹<%= (int)delivery %></span>
						</div>
						<div class="cart-summary-row total"
							style="margin-top: 15px; padding-top: 12px; font-size: 18px;">
							<span>Total</span> <span>₹<%= (int)total %></span>
						</div>

						<a href="checkout.jsp" class="cart-checkout-btn"
							style="margin-top: 20px; text-decoration: none;">Proceed to
							Checkout →</a>
					</div>

				</div>
				<%
				}
				%>

			</main>

		</div>

	</div>

</body>
</html>