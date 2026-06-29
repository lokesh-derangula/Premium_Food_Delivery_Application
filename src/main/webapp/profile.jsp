<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
com.food.Model.User user = (com.food.Model.User) session.getAttribute("user");
String username = user.getUsername();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | My Profile</title>

<!-- Fonts & Icons -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Style sheet -->
<link rel="stylesheet" href="restaurant.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/restaurant.css">
<style>
	.profile-card {
		background: rgba(255, 255, 255, 0.35);
		border-radius: 28px;
		padding: 40px;
		max-width: 600px;
		width: 100%;
		box-shadow: 0 20px 50px rgba(43, 31, 26, 0.05);
		border: 1px solid rgba(255, 255, 255, 0.3);
		margin: 0 auto;
		animation: popUp 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	}
	@keyframes popUp {
		from { transform: translateY(20px); opacity: 0; }
		to { transform: translateY(0); opacity: 1; }
	}
	.profile-header {
		display: flex;
		align-items: center;
		gap: 25px;
		margin-bottom: 30px;
		border-bottom: 1px solid rgba(255, 255, 255, 0.2);
		padding-bottom: 25px;
	}
	.profile-avatar {
		width: 80px;
		height: 80px;
		background: var(--primary);
		color: #ffffff;
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 32px;
		font-weight: 700;
		box-shadow: 0 8px 20px rgba(217, 83, 51, 0.2);
	}
	.profile-name-role h2 {
		font-family: var(--font-sans);
		font-weight: 700;
		font-size: 28px;
		color: var(--text-main);
		margin: 0;
	}
	.profile-name-role span {
		display: inline-block;
		margin-top: 6px;
		background: var(--primary-light);
		color: var(--primary);
		padding: 4px 14px;
		border-radius: 30px;
		font-size: 12px;
		font-weight: 600;
		text-transform: capitalize;
	}
	.info-item {
		display: flex;
		flex-direction: column;
		gap: 6px;
		margin-bottom: 20px;
	}
	.info-item label {
		font-size: 11px;
		font-weight: 700;
		text-transform: uppercase;
		letter-spacing: 0.5px;
		color: var(--text-light);
	}
	.info-item p {
		font-size: 16px;
		color: var(--text-main);
		font-weight: 500;
		margin: 0;
	}
	.profile-actions {
		display: flex;
		gap: 20px;
		margin-top: 30px;
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
				<a href="profile.jsp" class="sidebar-icon-link active" title="Profile">
					<i class="fa-solid fa-user"></i>
				</a>
				<a href="orderHistory.jsp" class="sidebar-icon-link" title="Order History">
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
					<h2>My Profile</h2>
					<span style="font-size: 14px; color: var(--text-light);">Account Settings</span>
				</div>

				<div class="profile-card">
					<div class="profile-header">
						<div class="profile-avatar">
							<%= user.getUsername().substring(0, 1).toUpperCase() %>
						</div>
						<div class="profile-name-role">
							<h2><%= user.getUsername() %></h2>
							<span><%= user.getRole() %></span>
						</div>
					</div>
					
					<div class="info-item">
						<label>Email Address</label>
						<p><%= user.getEmail() %></p>
					</div>
					
					<div class="info-item">
						<label>Default Delivery Address</label>
						<p><%= user.getAddress() != null && !user.getAddress().isEmpty() ? user.getAddress() : "No default address set" %></p>
					</div>
					
					<% if (user.getCreatedDate() != null) { %>
						<div class="info-item">
							<label>Member Since</label>
							<p><%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(user.getCreatedDate()) %></p>
						</div>
					<% } %>

					<div class="profile-actions">
						<a href="orderHistory.jsp" class="slider-order-btn" style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 8px; flex: 1;">
							<i class="fa-solid fa-clock-rotate-left"></i> Order History
						</a>
						<a href="callRestaurantServlet?view=dashboard" class="glass-logout-btn" style="display: inline-flex; align-items: center; justify-content: center; flex: 1;">
							Back to Shop
						</a>
					</div>
				</div>

			</main>

		</div>

	</div>

</body>
</html>
