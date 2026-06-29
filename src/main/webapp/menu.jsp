<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.food.Model.Menu,com.food.Model.Restaurant"%>
<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String username = (String) session.getAttribute("username");
List<Menu> allmenusByRestaurantId = (List<Menu>) request.getAttribute("allmenusByRestaurantId");

// Find restaurant details if possible, or fallback
String restaurantName = "FeastFlow Kitchen";
String cuisineType = "Gourmet Cuisines";
String rating = "4.6";
String address = "Indiranagar, Bangalore";
int restaurantId = 0;

if (allmenusByRestaurantId != null && !allmenusByRestaurantId.isEmpty()) {
    restaurantId = allmenusByRestaurantId.get(0).getRestaurantId();
    // In a real flow, we can query details, or use default parameters
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | Menu Details</title>

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
	/* Thumbnail item layout */
	.menu-thumbs-list {
		display: flex;
		flex-direction: column;
		gap: 12px;
		overflow-y: auto;
		flex: 1;
		padding-right: 5px;
	}
	.menu-thumbs-list::-webkit-scrollbar {
		width: 4px;
	}
	.menu-thumbs-list::-webkit-scrollbar-thumb {
		background: rgba(43, 31, 26, 0.1);
		border-radius: 10px;
	}
	.menu-thumb-item {
		display: flex;
		align-items: center;
		gap: 10px;
		background: rgba(255, 255, 255, 0.35);
		border: 1px solid rgba(255, 255, 255, 0.25);
		border-radius: 16px;
		padding: 10px;
		cursor: pointer;
		transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
		text-decoration: none;
		color: var(--text-main);
	}
	.menu-thumb-item:hover, .menu-thumb-item.active {
		background: rgba(255, 255, 255, 0.65);
		border-color: rgba(255, 255, 255, 0.45);
		transform: translateY(-2px);
		box-shadow: 0 6px 15px rgba(0, 0, 0, 0.02);
	}
	.menu-thumb-item img {
		width: 46px;
		height: 46px;
		border-radius: 10px;
		object-fit: cover;
	}
	.menu-thumb-info h5 {
		font-size: 13px;
		font-weight: 700;
		margin: 0;
	}
	.menu-thumb-info p {
		font-size: 11px;
		color: var(--text-light);
		margin: 0;
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
				<a href="callRestaurantServlet?view=dashboard" class="sidebar-icon-link active" title="Restaurants Dashboard">
					<i class="fa-solid fa-shop"></i>
				</a>
				<a href="profile.jsp" class="sidebar-icon-link" title="Profile">
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

			<!-- Food Detail View layout -->
			<main class="glass-content-pane" style="overflow: hidden;">
				
				<% if (allmenusByRestaurantId != null && !allmenusByRestaurantId.isEmpty()) { %>
					
					<div class="food-detail-view">
						
						<!-- Left Sidebar Pane: Restaurant card and thumbnails list -->
						<div class="food-left-pane">
							<!-- Mini Restaurant Info Card -->
							<div class="slider-mini-profile" style="background: rgba(255, 255, 255, 0.45); border-radius: 20px;">
								<div class="slider-mini-avatar">⭐</div>
								<div class="slider-mini-details">
									<h4 style="font-size: 14px;"><%= restaurantName %></h4>
									<p style="font-size: 11px;"><%= cuisineType %> | <%= rating %></p>
								</div>
								<a href="callRestaurantServlet?view=dashboard" class="slider-badge-active" style="text-decoration: none; color: #1f9254;">Back</a>
							</div>
							
							<!-- Scrollable Thumbnails list -->
							<div class="menu-thumbs-list">
								<% for (int i = 0; i < allmenusByRestaurantId.size(); i++) {
									Menu item = allmenusByRestaurantId.get(i);
								%>
									<div class="menu-thumb-item <%= i == 0 ? "active" : "" %>" onclick="selectMenuItem(<%= i %>)">
										<img src="${pageContext.request.contextPath}/<%= item.getImagePath() %>" alt="Food">
										<div class="menu-thumb-info">
											<h5><%= item.getItemName() %></h5>
											<p>₹<%= (int)item.getPrice() %></p>
										</div>
									</div>
								<% } %>
							</div>
						</div>

						<!-- Center Active Card Pane -->
						<div class="food-center-pane">
							
							<div class="food-active-card">
								<!-- Steam animation clouds -->
								<div class="steam-clouds" style="width: 100%; height: 100%;">
									<div class="steam-cloud steam-cloud-1"></div>
									<div class="steam-cloud steam-cloud-2"></div>
									<div class="steam-cloud steam-cloud-3"></div>
								</div>
								
								<div class="food-active-image-container">
									<img id="active-food-img" src="${pageContext.request.contextPath}/<%= allmenusByRestaurantId.get(0).getImagePath() %>" alt="Food">
								</div>
								
								<div>
									<h2 class="food-active-title" id="active-food-title"><%= allmenusByRestaurantId.get(0).getItemName() %></h2>
									<p class="food-active-location" id="active-food-desc">
										<i class="fa-solid fa-burger" style="color: var(--primary);"></i>
										<%= allmenusByRestaurantId.get(0).getDescription() != null ? allmenusByRestaurantId.get(0).getDescription() : "Freshly prepared elite gourmet selection." %>
									</p>
								</div>
								
								<!-- Form and Controls -->
								<form action="callCartServlet" method="get">
									<input type="hidden" name="menuId" id="form-menuId-input" value="<%= allmenusByRestaurantId.get(0).getMenuId() %>">
									<input type="hidden" name="restaurantId" value="<%= restaurantId %>">
									<input type="hidden" name="quantity" id="form-qty-input" value="1">
									<input type="hidden" name="action" value="add">
									
									<div class="food-controls-row">
										<div class="food-qty-selector">
											<button type="button" onclick="adjustQty(-1)" class="food-qty-btn">-</button>
											<span class="food-qty-val" id="qty-display">1</span>
											<button type="button" onclick="adjustQty(1)" class="food-qty-btn plus">+</button>
										</div>
										
										<div class="food-price-badge" id="active-food-price">
											₹<%= (int)allmenusByRestaurantId.get(0).getPrice() %>
										</div>
									</div>
									
									<button type="submit" class="slider-order-btn" style="width: 100%; margin-top: 15px; border: none; align-self: stretch;">
										Add to Cart <i class="fa-solid fa-basket-shopping" style="margin-left: 6px;"></i>
									</button>
								</form>
							</div>

						</div>

						<!-- Right 3D Floating Assets Pane -->
						<div class="food-right-pane">
							<div class="floating-assets-container">
								<!-- Fries box popping out (Red/Yellow SVG) -->
								<svg width="100" height="100" viewBox="0 0 100 100" class="floating-asset floating-fries-box">
								  <ellipse cx="50" cy="85" rx="30" ry="8" fill="rgba(43, 31, 26, 0.15)" />
								  <rect x="25" y="15" width="8" height="40" rx="3" fill="#ffcc00" transform="rotate(-15 25 15)" />
								  <rect x="35" y="10" width="8" height="45" rx="3" fill="#ffdb4d" transform="rotate(-5 35 10)" />
								  <rect x="45" y="8" width="8" height="48" rx="3" fill="#ffcc00" />
								  <rect x="55" y="12" width="8" height="45" rx="3" fill="#ffdb4d" transform="rotate(8 55 12)" />
								  <rect x="65" y="18" width="8" height="38" rx="3" fill="#ffcc00" transform="rotate(20 65 18)" />
								  <path d="M 20 45 L 80 45 L 70 85 L 30 85 Z" fill="#d95333" />
								  <path d="M 30 45 Q 50 55 70 45 L 70 55 Q 50 65 30 55 Z" fill="#b83c20" />
								  <circle cx="50" cy="65" r="10" fill="#ffdb4d" />
								  <text x="50" y="69" font-size="12" font-weight="bold" fill="#d95333" text-anchor="middle">F</text>
								</svg>
								
								<!-- Soda Cup (Red/White Striped SVG) -->
								<svg width="90" height="110" viewBox="0 0 90 110" class="floating-asset floating-soda-cup">
								  <ellipse cx="45" cy="100" rx="25" ry="6" fill="rgba(43, 31, 26, 0.15)" />
								  <path d="M 50 10 L 60 -15 L 70 -12 L 62 12" fill="none" stroke="#d95333" stroke-width="6" stroke-linecap="round" />
								  <path d="M 50 10 L 60 -15 L 70 -12 L 62 12" fill="none" stroke="#ffffff" stroke-width="6" stroke-linecap="round" stroke-dasharray="4 4" />
								  <path d="M 20 30 L 70 30 L 60 95 L 30 95 Z" fill="#ffffff" />
								  <path d="M 28 30 L 38 30 L 45 95 L 35 95 Z" fill="#d95333" />
								  <path d="M 52 30 L 62 30 L 55 95 L 45 95 Z" fill="#d95333" />
								  <ellipse cx="45" cy="30" rx="27" ry="6" fill="#e0e0e0" />
								  <ellipse cx="45" cy="27" rx="27" ry="6" fill="#f5f5f5" />
								</svg>
								
								<!-- Falling Single Fries SVGs -->
								<svg width="15" height="50" viewBox="0 0 15 50" class="floating-asset floating-fry-single-1">
								  <rect x="2" y="2" width="10" height="45" rx="3" fill="#ffcc00" />
								</svg>
								<svg width="15" height="50" viewBox="0 0 15 50" class="floating-asset floating-fry-single-2">
								  <rect x="2" y="2" width="10" height="45" rx="3" fill="#ffdb4d" />
								</svg>
								<svg width="15" height="50" viewBox="0 0 15 50" class="floating-asset floating-fry-single-3">
								  <rect x="2" y="2" width="10" height="45" rx="3" fill="#ffcc00" />
								</svg>
							</div>
						</div>

					</div>

				<% } else { %>
					<div style="text-align: center; margin-top: 150px; color: var(--text-light);">
						<i class="fa-solid fa-circle-exclamation" style="font-size: 48px; margin-bottom: 15px; opacity: 0.5;"></i>
						<h2>No Menu Items Found</h2>
						<p>Check back later or try other kitchen partners.</p>
						<a href="callRestaurantServlet?view=dashboard" class="slider-order-btn" style="display: inline-block; margin-top: 20px;">Back to Restaurants</a>
					</div>
				<% } %>

			</main>

		</div>

	</div>

	<% if (allmenusByRestaurantId != null && !allmenusByRestaurantId.isEmpty()) { %>
	<script>
		// Menu items data for interactive updates
		const menuItems = [
			<%
			for (int i = 0; i < allmenusByRestaurantId.size(); i++) {
				Menu m = allmenusByRestaurantId.get(i);
			%>
			{
				id: <%= m.getMenuId() %>,
				restaurantId: <%= m.getRestaurantId() %>,
				name: "<%= m.getItemName().replace("\"", "\\\"") %>",
				image: "${pageContext.request.contextPath}/<%= m.getImagePath() %>",
				price: <%= m.getPrice() %>,
				description: "<%= m.getDescription() != null ? m.getDescription().replace("\"", "\\\"").replace("\n", " ") : "Freshly prepared elite gourmet selection." %>"
			}<%= (i < allmenusByRestaurantId.size() - 1) ? "," : "" %>
			<% } %>
		];

		let activeMenuIndex = 0;
		let currentQty = 1;

		function selectMenuItem(index) {
			activeMenuIndex = index;
			const item = menuItems[index];
			
			// Smooth transition active card update
			const activeCard = document.querySelector('.food-active-card');
			activeCard.style.opacity = 0.8;
			
			setTimeout(() => {
				document.getElementById('active-food-img').src = item.image;
				document.getElementById('active-food-title').textContent = item.name;
				document.getElementById('active-food-desc').innerHTML = `<i class="fa-solid fa-burger" style="color: var(--primary);"></i> ${item.description}`;
				document.getElementById('active-food-price').textContent = '₹' + parseInt(item.price);
				document.getElementById('form-menuId-input').value = item.id;
				
				// Reset qty controls
				currentQty = 1;
				document.getElementById('qty-display').textContent = 1;
				document.getElementById('form-qty-input').value = 1;
				
				activeCard.style.opacity = 1;
				
				// Highlight active left thumbnail
				document.querySelectorAll('.menu-thumb-item').forEach((el, idx) => {
					if (idx === index) el.classList.add('active');
					else el.classList.remove('active');
				});
			}, 150);
		}

		function adjustQty(amount) {
			currentQty = Math.max(1, currentQty + amount);
			document.getElementById('qty-display').textContent = currentQty;
			document.getElementById('form-qty-input').value = currentQty;
		}
	</script>
	<% } %>

</body>
</html>
