<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.food.Model.Cart,com.food.Model.CartItem,java.util.*"%>
<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String username = (String) session.getAttribute("username");

Cart cart = (Cart) session.getAttribute("cart");
double subtotal = 0;
int items = 0;
if (cart != null) {
	for (CartItem c : cart.getItems().values()) {
		subtotal += c.getTotalPrice();
		items += c.getQuantity();
	}
}
double delivery = subtotal > 0 ? 40 : 0;
double tax = subtotal * 0.05;
double total = subtotal + delivery + tax;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | Secure Checkout</title>

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
<link rel="stylesheet" href="${pageContext.request.contextPath}/restaurant.css">
<style>
	.checkout-grid {
		display: grid;
		grid-template-columns: 2fr 1fr;
		gap: 30px;
		align-items: start;
	}
	.checkout-form-section {
		display: flex;
		flex-direction: column;
		gap: 20px;
	}
	.checkout-card {
		background: rgba(255, 255, 255, 0.35);
		border: 1px solid rgba(255, 255, 255, 0.25);
		border-radius: 24px;
		padding: 26px;
		box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02);
	}
	.checkout-card h3 {
		font-family: var(--font-sans);
		font-weight: 700;
		color: var(--text-main);
		margin-top: 0;
		margin-bottom: 20px;
		font-size: 18px;
		border-bottom: 1px solid rgba(255, 255, 255, 0.2);
		padding-bottom: 10px;
	}
	.form-group-row {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 15px;
		margin-bottom: 15px;
	}
	.form-input-group {
		display: flex;
		flex-direction: column;
		gap: 6px;
		margin-bottom: 15px;
	}
	.form-input-group label {
		font-size: 13px;
		font-weight: 600;
		color: var(--text-muted);
	}
	.form-input-group input, .form-input-group textarea {
		padding: 12px;
		border: 1px solid rgba(255, 255, 255, 0.4);
		background: rgba(255, 255, 255, 0.5);
		border-radius: 12px;
		outline: none;
		font-size: 14px;
		transition: all 0.3s;
	}
	.form-input-group input:focus, .form-input-group textarea:focus {
		background: rgba(255, 255, 255, 0.85);
		border-color: rgba(217, 83, 51, 0.3);
	}
	.payment-option {
		display: flex;
		align-items: center;
		gap: 12px;
		padding: 12px 18px;
		background: rgba(255, 255, 255, 0.45);
		border: 1px solid rgba(255, 255, 255, 0.3);
		border-radius: 14px;
		margin-bottom: 10px;
		cursor: pointer;
		font-size: 14px;
		font-weight: 600;
		transition: all 0.2s;
	}
	.payment-option:hover {
		background: rgba(255, 255, 255, 0.65);
	}
	.payment-option input {
		accent-color: var(--primary);
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
				<a href="orderHistory.jsp" class="sidebar-icon-link" title="Order History">
					<i class="fa-solid fa-calendar-days"></i>
				</a>
				<a href="cart.jsp" class="sidebar-icon-link active" title="Shopping Cart">
					<i class="fa-solid fa-receipt"></i>
				</a>
				<a href="#" class="sidebar-icon-link" title="Notifications">
					<i class="fa-solid fa-bell"></i>
				</a>
				
			</aside>

			<!-- Content Pane -->
			<main class="glass-content-pane">
				
				<div class="dashboard-section-header" style="margin-bottom: 25px;">
					<h2>Checkout</h2>
					<span style="font-size: 14px; color: var(--text-light);">Secure Placement</span>
				</div>

				<form action="PlaceOrderServlet" method="post">
					<div class="checkout-grid">
						
						<!-- Left Side: Forms -->
						<div class="checkout-form-section">
							
							<!-- Address Card -->
							<div class="checkout-card">
								<h3>Delivery Details</h3>
								
								<div class="form-input-group">
									<label>Full Name</label>
									<input type="text" name="name" required placeholder="Enter your full name">
								</div>
								
								<div class="form-group-row">
									<div class="form-input-group">
										<label>Phone Number</label>
										<input type="text" name="phone" required placeholder="Enter mobile number">
									</div>
									<div class="form-input-group">
										<label>Email Address</label>
										<input type="email" name="email" placeholder="Enter email address">
									</div>
								</div>
								
								<div class="form-input-group">
									<label>Complete Address</label>
									<textarea rows="3" name="address" required placeholder="Street address, apartment, flat no."></textarea>
								</div>
								
								<div class="form-group-row">
									<div class="form-input-group">
										<label>City</label>
										<input type="text" name="city" required placeholder="Enter city">
									</div>
									<div class="form-input-group">
										<label>Pincode</label>
										<input type="text" name="pincode" required placeholder="Enter pincode">
									</div>
								</div>
							</div>

							<!-- Payment Card -->
							<div class="checkout-card">
								<h3>Payment Method</h3>
								
								<label class="payment-option">
									<input type="radio" name="payment" value="Cash on Delivery" checked>
									<span>Cash on Delivery</span>
								</label>
								<label class="payment-option">
									<input type="radio" name="payment" value="UPI">
									<span>UPI</span>
								</label>
								<label class="payment-option">
									<input type="radio" name="payment" value="Credit Card">
									<span>Credit/Debit Card</span>
								</label>
							</div>

						</div>

						<!-- Right Side: Order Summary -->
						<div class="cart-summary-box" style="padding: 24px;">
							<h3 style="margin-top: 0; margin-bottom: 15px; font-family: var(--font-sans); font-weight: 700; font-size: 18px; color: var(--text-main);">Order Summary</h3>
							
							<div style="max-height: 180px; overflow-y: auto; margin-bottom: 15px; padding-right: 5px;">
								<%
								if (cart != null) {
									for (CartItem i : cart.getItems().values()) {
								%>
									<div class="cart-summary-row" style="margin: 8px 0; font-size: 13px;">
										<span style="font-weight: 600;"><%= i.getName() %> <span style="opacity: 0.6;">x <%= i.getQuantity() %></span></span>
										<span>₹<%= (int)i.getTotalPrice() %></span>
									</div>
								<%
									}
								}
								%>
							</div>
							
							<div class="cart-summary-row" style="margin: 8px 0; border-top: 1px solid rgba(255, 255, 255, 0.15); padding-top: 10px;">
								<span>Items Selected</span>
								<span><%= items %></span>
							</div>
							<div class="cart-summary-row" style="margin: 8px 0;">
								<span>Subtotal</span>
								<span>₹<%= (int)subtotal %></span>
							</div>
							<div class="cart-summary-row" style="margin: 8px 0;">
								<span>Delivery Fee</span>
								<span>₹<%= (int)delivery %></span>
							</div>
							<div class="cart-summary-row style="margin: 8px 0;">
								<span>GST (5%)</span>
								<span>₹<%= (int)tax %></span>
							</div>
							
							<div class="cart-summary-row total" style="margin-top: 15px; padding-top: 12px; font-size: 18px;">
								<span>Total</span>
								<span>₹<%= (int)total %></span>
							</div>
							
							<input type="hidden" name="amount" value="<%= total %>">
							<button type="submit" class="cart-checkout-btn" style="width: 100%; border: none; margin-top: 20px;">Place Order Now</button>
						</div>

					</div>
				</form>

			</main>

		</div>

	</div>

</body>
</html>
