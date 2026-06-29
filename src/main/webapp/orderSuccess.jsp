<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | Order Placed Successfully</title>

<!-- Fonts & Icons -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Style sheet -->
<link rel="stylesheet" href="restaurant.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/restaurant.css">
<style>
	.success-card {
		background: rgba(255, 255, 255, 0.35);
		border-radius: 28px;
		padding: 50px 40px;
		max-width: 550px;
		width: 100%;
		text-align: center;
		box-shadow: 0 20px 50px rgba(43, 31, 26, 0.05);
		border: 1px solid rgba(255, 255, 255, 0.3);
		margin: 40px auto;
		animation: popUp 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	}
	@keyframes popUp {
		from { transform: scale(0.9); opacity: 0; }
		to { transform: scale(1); opacity: 1; }
	}
	.success-icon {
		width: 90px;
		height: 90px;
		background: var(--primary-light);
		color: var(--primary);
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 40px;
		margin: 0 auto 30px;
		box-shadow: 0 10px 20px rgba(217, 83, 51, 0.1);
	}
	.success-card h1 {
		font-family: var(--font-sans);
		font-weight: 700;
		font-size: 32px;
		color: var(--text-main);
		margin-bottom: 12px;
	}
	.success-card p {
		color: var(--text-muted);
		font-size: 16px;
		line-height: 1.6;
		margin-bottom: 35px;
	}
	.success-actions {
		display: flex;
		flex-direction: column;
		gap: 15px;
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
			
			<!-- Left Sidebar Navigation -->
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
				
				<div class="success-card">
					<div class="success-icon">
						<i class="fa-solid fa-check"></i>
					</div>
					<h1>Order Placed!</h1>
					<p>Your gourmet order has been successfully placed with FeastFlow. The kitchen has begun coordinating with local delivery riders.</p>
					
					<div class="success-actions">
						<a href="orderHistory.jsp" class="slider-order-btn" style="text-decoration: none; text-align: center;">View Order History</a>
						<a href="callRestaurantServlet?view=dashboard" class="glass-logout-btn" style="text-align: center;">Back to Shop</a>
					</div>
				</div>

			</main>

		</div>

	</div>

</body>
</html>
