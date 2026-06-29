<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | FeastFlow</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="registration.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/registration.css">
</head>
<body>
	<div class="video-container">
		<video autoplay muted loop playsinline>
			<source src="videos/food.mp4" type="video/mp4">
			<source src="${pageContext.request.contextPath}/videos/food.mp4" type="video/mp4">
		</video>
		<div class="overlay"></div>
	</div>

	<div class="bg-circle c1"></div>
	<div class="bg-circle c2"></div>

	<div class="container">
		<div class="left-panel">
			<h1>🍔 FeastFlow</h1>
			<h2>Welcome Food Lover!</h2>
			<p>Create your account and enjoy delicious meals delivered to
				your doorstep.</p>
		</div>

		<div class="glass-card">
			<form action="callRegisterServlet" method="post">
				<h2>Create Account</h2>

				<div class="input-group">
					<input type="text" name="name" required> <label>Name</label>
				</div>

				<div class="input-group">
					<input type="email" name="email" required> <label>Email</label>
				</div>

				<div class="input-group">
					<input id="pwd" type="password" name="password" required> <label>Password</label>
					<span id="toggle">👁</span>
				</div>

				<div class="input-group">
					<textarea name="address" required></textarea>
					<label>Address</label>
				</div>

				<div class="input-group">
					<select name="role" required>
						<option value="">Select Role</option>
						<option>Customer</option>
						<option>Restaurant Owner</option>
						<option>Delivery Partner</option>
					</select>
				</div>

				<button type="submit">Create Account</button>

				<p class="login-link">
					Already have an account? <a href="login.jsp">Login</a>
				</p>
			</form>
		</div>
	</div>

	<script src="registration.js"></script>
</body>
</html>
