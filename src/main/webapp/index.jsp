<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
boolean isLoggedIn = (session != null && session.getAttribute("username") != null);
String username = isLoggedIn ? (String) session.getAttribute("username") : "";
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
<style>
	/* 3D Food Bowl and Fumes Style */
	.food-bowl-3d {
		position: relative;
		margin-top: 0px;
		margin-bottom: 45px;
		display: flex;
		flex-direction: column;
		align-items: center;
		pointer-events: none;
		z-index: 10;
		animation: bowlFloat 6s ease-in-out infinite;
	}

	@keyframes bowlFloat {
		0%, 100% { transform: translateY(0); }
		50% { transform: translateY(-8px); }
	}

	.bowl-img {
		width: 500px;
		height: 350px;
		filter: drop-shadow(0 15px 30px rgba(43, 31, 26, 0.35));
	}



</style>
</head>

<body class="app-body">

	<!-- Background Video playing in the background of the landing page -->
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
			<a href="index.jsp" class="logo">
				<span>🍔</span> FeastFlow
			</a>
			
			<div class="welcome-info">
				<%
				if (isLoggedIn) {
				%>
					<div class="avatar-wrapper">
						<img src="images/profile-logo.png" alt="Avatar">
					</div>
					<div class="separator"></div>
					<span>Welcome, <%= username %>!</span>
					<a href="logout.jsp" class="slider-order-btn" style="margin-left: 15px;">Logout</a>
				<%
				} else {
				%>
					<a href="login.jsp" class="slider-order-btn">Sign In</a>
				<%
				}
				%>
			</div>
		</header>

		<!-- Main Landing Content (Podium and text slider) -->
		<div class="podium-container">
			
			<!-- Visual overlay for text and CTA buttons -->
			<div style="text-align: center; margin-top: 125px; max-width: 600px; padding: 0 20px; z-index: 10;">
				<h1 class="hero-title" style="font-size: 52px; margin-bottom: 15px; line-height: 1.1;">
					The Ultimate<br>Platform for Foodies
				</h1>
				<p class="hero-desc" style="margin: 0 auto 30px; font-size: 15px;">
					<%
					if (isLoggedIn) {
					%>
						Welcome back! Explore our collection of premium flame-grilled cheeseburgers and artisanal gourmet cuisines from elite kitchen partners.
					<%
					} else {
					%>
						Experience the rich fusion of flame-grilled premium patty, fresh organic ingredients, and double melted cheddar. Please sign in to explore.
					<%
					}
					%>
				</p>
				
				<div style="display: flex; gap: 15px; justify-content: center; margin-bottom: 20px;">
					<%
					if (isLoggedIn) {
					%>
						<a href="callRestaurantServlet" class="slider-order-btn" style="align-self: center;">Order Now <i class="fa-solid fa-arrow-right"></i></a>
						<a href="callRestaurantServlet?view=dashboard" class="glass-logout-btn" style="display: inline-flex; align-items: center; justify-content: center;">Dashboard</a>
					<%
					} else {
					%>
						<a href="login.jsp" class="slider-order-btn" style="align-self: center;">Get Started <i class="fa-solid fa-arrow-right"></i></a>
						<a href="login.jsp" class="glass-logout-btn">Learn More</a>
					<%
					}
					%>
				</div>
			</div>

			<!-- 3D Food Bowl with rising fumes -->
			<div class="food-bowl-3d">
				<!-- Realistic 3D Food Bowl Image -->
				<img class="bowl-img" src="images/hero/bowl-new.png" alt="Steaming Food Bowl" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/realistic_bowl.png';">
			</div>

			<!-- Slide indicator dots at the bottom -->
			<div class="indicator-dots">
				<a href="index.jsp" class="indicator-dot active"></a>
				<%
				if (isLoggedIn) {
				%>
					<a href="callRestaurantServlet" class="indicator-dot"></a>
					<a href="callRestaurantServlet?view=dashboard" class="indicator-dot"></a>
				<%
				} else {
				%>
					<a href="login.jsp" class="indicator-dot"></a>
					<a href="login.jsp" class="indicator-dot"></a>
				<%
				}
				%>
			</div>

		</div>

	</div>

</body>
</html>
