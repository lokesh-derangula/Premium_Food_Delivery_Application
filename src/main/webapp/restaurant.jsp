<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.food.Model.Restaurant,com.food.Model.Cart,com.food.Model.CartItem"%>
<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String username = (String) session.getAttribute("username");
List<Restaurant> allRestaurants = (List<Restaurant>) request.getAttribute("allRestaurants");

// Get view type from parameter: 'carousel' (default) or 'dashboard'
String viewType = request.getParameter("view");
if (viewType == null) {
	viewType = "carousel";
}

// Fetch Cart information
Cart cart = (Cart) session.getAttribute("cart");
Map<Integer, CartItem> cartItems = (cart != null) ? cart.getItems() : null;
double subtotal = 0;
int totalQty = 0;
if (cartItems != null) {
	for (CartItem i : cartItems.values()) {
		subtotal += i.getPrice() * i.getQuantity();
		totalQty += i.getQuantity();
	}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FeastFlow | Elite Gourmet Delivery</title>

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
</head>

<body class="app-body">

	<!-- Background Video playing in the background -->
	<div class="video-background-container">
		<video autoplay muted loop playsinline id="bgVideo">
			<source src="videos/demo.mp4" type="video/mp4">
			<source src="${pageContext.request.contextPath}/videos/demo.mp4" type="video/mp4">
		</video>
		<div class="video-background-overlay"></div>
	</div>

	<!-- Main Glassmorphic Card Container -->
	<div class="glass-container">
		
		<!-- Header Navbar inside Glass Container -->
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

		<!-- Main Workspace containing Sidebar, Content, and Cart Panel -->
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

			<!-- Central View Pane -->
			<main class="glass-content-pane">
				
				<% if ("carousel".equals(viewType) && allRestaurants != null && !allRestaurants.isEmpty()) { %>
					<!-- CAROUSEL SLIDER VIEW (Frame 4/6) -->
					<div class="restaurant-slider-view">
						
						<!-- Left Active Card -->
						<div class="slider-left-card">
							<div class="slider-main-image-container">
								<!-- Steam clouds animation -->
								<div class="steam-clouds">
									<div class="steam-cloud steam-cloud-1"></div>
									<div class="steam-cloud steam-cloud-2"></div>
									<div class="steam-cloud steam-cloud-3"></div>
								</div>
								<img id="active-image" src="${pageContext.request.contextPath}/<%= allRestaurants.get(0).getImagePath() %>" alt="Food">
							</div>
							
							<div class="slider-mini-profile">
								<div class="slider-mini-avatar">🍔</div>
								<div class="slider-mini-details">
									<h4 id="active-mini-name"><%= allRestaurants.get(0).getRestaurantName() %></h4>
									<p id="active-mini-cuisine"><%= allRestaurants.get(0).getCuisineType() %></p>
								</div>
								<div class="slider-badge-active">Active</div>
							</div>
						</div>

						<!-- Right Info & Action Details -->
						<div class="slider-right-details">
							<div class="slider-rating-row">
								<div class="slider-rating-badge">
									<i class="fa-solid fa-star"></i> <span id="active-rating"><%= allRestaurants.get(0).getRating() %></span>
								</div>
								<div class="slider-favorite-btn">
									<i class="fa-regular fa-heart"></i>
								</div>
								<div class="slider-stars">
									<i class="fa-solid fa-star"></i>
									<i class="fa-solid fa-star"></i>
									<i class="fa-solid fa-star"></i>
									<i class="fa-solid fa-star"></i>
									<i class="fa-solid fa-star-half-stroke"></i>
								</div>
							</div>
							
							<h1 class="slider-title" id="active-name"><%= allRestaurants.get(0).getRestaurantName() %></h1>
							<p class="slider-desc" id="active-address">
								<i class="fa-solid fa-location-dot" style="color: var(--primary); margin-right: 6px;"></i>
								<%= allRestaurants.get(0).getAddress() %>
							</p>
							
							<div class="slider-time-badge">
								<i class="fa-regular fa-clock"></i> Delivery: <span id="active-time"><%= allRestaurants.get(0).getDeliveryTime() %></span> mins
							</div>
							
							<a id="active-order-link" href="Menu?restaurantId=<%= allRestaurants.get(0).getRestaurantId() %>" class="slider-order-btn">Order Now</a>
							
							<!-- Carousel Navigation Controls -->
							<div style="display: flex; gap: 15px; margin-top: 10px;">
								<button onclick="prevSlide()" class="slider-favorite-btn"><i class="fa-solid fa-chevron-left"></i></button>
								<button onclick="nextSlide()" class="slider-favorite-btn"><i class="fa-solid fa-chevron-right"></i></button>
							</div>
						</div>

						<!-- Peeking Card on Right -->
						<div class="slider-peeking-card">
							<img id="peeking-image" src="${pageContext.request.contextPath}/<%= allRestaurants.size() > 1 ? allRestaurants.get(1).getImagePath() : allRestaurants.get(0).getImagePath() %>" alt="Food">
							<div style="display: flex; flex-direction: column; gap: 4px;">
								<h4 style="margin: 0; font-size: 14px;" id="peeking-name"><%= allRestaurants.size() > 1 ? allRestaurants.get(1).getRestaurantName() : allRestaurants.get(0).getRestaurantName() %></h4>
								<span style="font-size: 11px; color: var(--text-light);" id="peeking-cuisine"><%= allRestaurants.size() > 1 ? allRestaurants.get(1).getCuisineType() : allRestaurants.get(0).getCuisineType() %></span>
							</div>
						</div>

					</div>

				<% } else { %>
					<!-- DASHBOARD GRID VIEW (Frame 12/14) -->
					<div class="dashboard-grid-view">
						<div class="dashboard-section-header">
							<h2>Popular Restaurants</h2>
							<div class="dashboard-search-container">
								<input id="db-search" type="text" onkeyup="filterRestaurants()" placeholder="Search restaurant or cuisine...">
								<i class="fa-solid fa-magnifying-glass"></i>
							</div>
						</div>
						
						<div class="dashboard-grid">
							<%
							if (allRestaurants != null) {
								for (Restaurant restaurant : allRestaurants) {
							%>
							<div class="dashboard-card restaurant-card-item" data-name="<%= restaurant.getRestaurantName().toLowerCase() %>" data-cuisine="<%= restaurant.getCuisineType().toLowerCase() %>">
								<div class="dashboard-card-img-box">
									<img src="${pageContext.request.contextPath}/<%= restaurant.getImagePath() %>" alt="<%= restaurant.getRestaurantName() %>">
									<div class="dashboard-card-rating">
										<i class="fa-solid fa-star"></i> <%= restaurant.getRating() %>
									</div>
								</div>
								
								<div class="dashboard-card-body">
									<h3><%= restaurant.getRestaurantName() %></h3>
									<p><i class="fa-solid fa-location-dot"></i> <%= restaurant.getAddress() %></p>
									<p><i class="fa-solid fa-utensils"></i> <%= restaurant.getCuisineType() %></p>
									
									<div class="dashboard-card-bottom">
										<span>
											<i class="fa-regular fa-clock"></i> <%= restaurant.getDeliveryTime() %> mins
										</span>
										<a href="Menu?restaurantId=<%= restaurant.getRestaurantId() %>" class="dashboard-card-btn">Order Now</a>
									</div>
								</div>
							</div>
							<%
								}
							}
							%>
						</div>
					</div>
				<% } %>

			</main>

			<!-- Right Shopping Cart Drawer Panel -->
			<aside class="glass-cart-pane">
				<div class="cart-header">
					<h3>Cart</h3>
					<span>(<%= totalQty %> items)</span>
				</div>
				
				<div class="cart-items-list">
					<% if (cartItems != null && !cartItems.isEmpty()) { 
						for (CartItem item : cartItems.values()) {
					%>
						<div class="cart-item-mini">
							<div class="slider-mini-avatar" style="font-size: 18px; width: 44px; height: 44px; border-radius: 10px; display: flex; align-items: center; justify-content: center; background: var(--primary-light);">🍔</div>
							<div class="cart-item-mini-info">
								<h4><%= item.getName() %></h4>
								<p>Qty: <%= item.getQuantity() %> x ₹<%= (int)item.getPrice() %></p>
							</div>
							<div class="cart-item-mini-price">
								₹<%= (int)(item.getPrice() * item.getQuantity()) %>
							</div>
						</div>
					<% 
						}
					} else { %>
						<div style="text-align: center; margin-top: 50px; color: var(--text-light); font-size: 14px;">
							<i class="fa-solid fa-basket-shopping" style="font-size: 32px; margin-bottom: 12px; display: block; opacity: 0.5;"></i>
							Your cart is empty.
						</div>
					<% } %>
				</div>

				<div class="cart-summary-box">
					<div class="cart-summary-row">
						<span>Subtotal</span>
						<span>₹<%= (int)subtotal %></span>
					</div>
					<div class="cart-summary-row">
						<span>Delivery Fee</span>
						<span>₹<%= (int)(subtotal > 0 ? 40 : 0) %></span>
					</div>
					<div class="cart-summary-row total">
						<span>Total</span>
						<span>₹<%= (int)(subtotal > 0 ? subtotal + 40 : 0) %></span>
					</div>
				</div>

				<a href="checkout.jsp" class="cart-checkout-btn" style="<%= subtotal > 0 ? "" : "pointer-events: none; opacity: 0.5;" %>">Checkout</a>
			</aside>

		</div>

	</div>

	<!-- Carousel Javascript logic -->
	<% if ("carousel".equals(viewType) && allRestaurants != null && !allRestaurants.isEmpty()) { %>
	<script>
		const restaurants = [
			<%
			for (int i = 0; i < allRestaurants.size(); i++) {
				Restaurant r = allRestaurants.get(i);
			%>
			{
				id: <%= r.getRestaurantId() %>,
				name: "<%= r.getRestaurantName().replace("\"", "\\\"") %>",
				image: "${pageContext.request.contextPath}/<%= r.getImagePath() %>",
				rating: <%= r.getRating() %>,
				address: "<%= r.getAddress().replace("\"", "\\\"") %>",
				cuisine: "<%= r.getCuisineType().replace("\"", "\\\"") %>",
				time: <%= r.getDeliveryTime() %>
			}<%= (i < allRestaurants.size() - 1) ? "," : "" %>
			<% } %>
		];

		let activeIndex = 0;

		function updateCarousel() {
			const active = restaurants[activeIndex];
			const peekingIndex = (activeIndex + 1) % restaurants.length;
			const peeking = restaurants[peekingIndex];

			// Fade out elements briefly for visual smooth transition
			const container = document.querySelector('.restaurant-slider-view');
			container.style.opacity = 0.8;

			setTimeout(() => {
				// Update active card
				document.getElementById('active-image').src = active.image;
				document.getElementById('active-name').textContent = active.name;
				document.getElementById('active-mini-name').textContent = active.name;
				document.getElementById('active-mini-cuisine').textContent = active.cuisine;
				document.getElementById('active-rating').textContent = active.rating;
				document.getElementById('active-address').innerHTML = `<i class="fa-solid fa-location-dot" style="color: var(--primary); margin-right: 6px;"></i>${active.address}`;
				document.getElementById('active-time').textContent = active.time;
				document.getElementById('active-order-link').href = `Menu?restaurantId=${active.id}`;

				// Update peeking card
				document.getElementById('peeking-image').src = peeking.image;
				document.getElementById('peeking-name').textContent = peeking.name;
				document.getElementById('peeking-cuisine').textContent = peeking.cuisine;

				container.style.opacity = 1;
			}, 180);
		}

		function nextSlide() {
			activeIndex = (activeIndex + 1) % restaurants.length;
			updateCarousel();
		}

		function prevSlide() {
			activeIndex = (activeIndex - 1 + restaurants.length) % restaurants.length;
			updateCarousel();
		}
	</script>
	<% } %>

	<!-- Dashboard search logic -->
	<script>
		function filterRestaurants() {
			const query = document.getElementById('db-search').value.toLowerCase();
			const cards = document.querySelectorAll('.restaurant-card-item');
			cards.forEach(card => {
				const name = card.getAttribute('data-name');
				const cuisine = card.getAttribute('data-cuisine');
				if (name.includes(query) || cuisine.includes(query)) {
					card.style.display = 'block';
				} else {
					card.style.display = 'none';
				}
			});
		}
	</script>

</body>
</html>
