<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | FeastFlow</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Outfit:wght@300;400;500;600;700&display=swap');

:root {
	--bg-gradient: linear-gradient(135deg, #FAF6EE 0%, #F5EFEB 100%);
	--primary: #D95333;       /* Terracotta Accent */
	--primary-hover: #C84021;
	--primary-light: #FDF1EE;
	--text-main: #2B1F1A;     /* Dark Charcoal/Brown */
	--text-muted: #594C45;    /* Muted Brown */
	--text-light: #908177;
	--white: #FFFFFF;
	--card-bg: rgba(255, 255, 255, 0.75);
	--border-color: rgba(43, 31, 26, 0.08);
	--shadow-soft: 0 15px 35px rgba(43, 31, 26, 0.06);
	--font-serif: 'DM Serif Display', serif;
	--font-sans: 'Outfit', sans-serif;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: var(--font-sans);
}

body {
	overflow: hidden;
	background: #FAF6EE;
	background-image: var(--bg-gradient);
	color: var(--text-main);
	min-height: 100vh;
}

.video-container {
	position: fixed;
	inset: 0;
	z-index: -2;
	display: block;
}

.overlay {
	position: absolute;
	inset: 0;
	background: rgba(250, 246, 238, 0.12);
	backdrop-filter: blur(8px);
	-webkit-backdrop-filter: blur(8px);
}

/* Background glows for premium look */
.bg-glow-1 {
	position: fixed;
	width: 500px;
	height: 500px;
	background: radial-gradient(circle, rgba(217, 83, 51, 0.05) 0%, rgba(250, 246, 238, 0) 70%);
	top: -100px;
	left: -100px;
	z-index: -1;
}

.bg-glow-2 {
	position: fixed;
	width: 600px;
	height: 600px;
	background: radial-gradient(circle, rgba(229, 106, 78, 0.04) 0%, rgba(250, 246, 238, 0) 70%);
	bottom: -150px;
	right: -150px;
	z-index: -1;
}

.container {
	display: flex;
	justify-content: space-evenly;
	align-items: center;
	height: 100vh;
	padding: 40px;
	position: relative;
	z-index: 10;
}

.left {
	max-width: 450px;
}

.left h1 {
	font-family: var(--font-serif);
	font-size: 56px;
	color: var(--text-main);
	margin-bottom: 10px;
}

.left h2 {
	font-family: var(--font-serif);
	font-size: 38px;
	margin: 15px 0;
	color: var(--primary);
}

.left p {
	font-size: 17px;
	line-height: 1.7;
	color: var(--text-muted);
}

.card {
	width: 420px;
	padding: 40px;
	background: rgba(255, 255, 255, 0.45);
	backdrop-filter: blur(25px);
	-webkit-backdrop-filter: blur(25px);
	border: 1px solid rgba(255, 255, 255, 0.35);
	border-radius: 28px;
	box-shadow: 0 20px 45px rgba(43, 31, 26, 0.1);
}

.card form h2 {
	font-family: var(--font-serif);
	font-size: 30px;
	color: var(--text-main);
	margin-bottom: 15px;
}

.group {
	position: relative;
	margin: 25px 0;
}

.group input {
	width: 100%;
	padding: 16px;
	border: 1px solid var(--border-color);
	border-radius: 14px;
	background: var(--white);
	color: var(--text-main);
	outline: none;
	font-size: 15px;
	transition: all 0.3s ease;
}

.group input:focus {
	border-color: rgba(217, 83, 51, 0.4);
	box-shadow: 0 4px 15px rgba(217, 83, 51, 0.05);
}

.group label {
	position: absolute;
	left: 16px;
	top: 16px;
	color: var(--text-light);
	transition: .3s;
	pointer-events: none;
	font-size: 15px;
}

.group input:focus+label, .group input:valid+label {
	top: -10px;
	left: 10px;
	font-size: 11px;
	background: var(--primary);
	color: var(--white);
	padding: 2px 8px;
	border-radius: 10px;
	font-weight: 600;
}

#toggle {
	position: absolute;
	right: 16px;
	top: 16px;
	cursor: pointer;
	color: var(--text-light);
}

button {
	width: 100%;
	padding: 16px;
	border: none;
	border-radius: 50px;
	background: var(--primary);
	color: var(--white);
	font-size: 17px;
	font-weight: 700;
	cursor: pointer;
	box-shadow: 0 6px 20px rgba(217, 83, 51, 0.2);
	transition: all 0.3s ease;
}

button:hover {
	background: var(--primary-hover);
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(217, 83, 51, 0.3);
}

.links {
	text-align: center;
	margin-top: 25px;
	font-size: 14px;
	color: var(--text-muted);
}

.links a {
	color: var(--primary);
	text-decoration: none;
	font-weight: 600;
}

.links a:hover {
	text-decoration: underline;
}

@media (max-width: 900px) {
	body {
		overflow: auto;
	}
	.container {
		flex-direction: column;
		padding: 30px;
		justify-content: center;
		gap: 30px;
	}
	.card {
		width: 100%;
		max-width: 420px;
	}
	.left {
		text-align: center;
		margin-bottom: 10px;
	}
}
</style>
</head>
<body>
	<div class="video-container">
		<video autoplay muted loop playsinline>
			<source src="${pageContext.request.contextPath}/videos/food.mp4" type="video/mp4">
		</video>
		<div class="overlay"></div>
	</div>
	<div class="container">
		<div class="left">
			<h1>🍔 FeastFlow</h1>
			<h2>Welcome Back!</h2>
			<p>Login and continue exploring your favourite restaurants and
				delicious meals.</p>
		</div>
		<div class="card">
			<form action="callLoginServlet" method="post">
				<h2 style="text-align: center">Sign In</h2>
				<div class="group">
					<input type="email" name="email" required><label>Email</label>
				</div>
				<div class="group">
					<input id="pwd" type="password" name="password" required><label>Password</label><span
						id="toggle">👁</span>
				</div>
				<button type="submit">Login</button>
				<div class="links">
					Don't have an account? <a href="registration.jsp">Register</a>
				</div>
			</form>
		</div>
	</div>
	<script>
const t=document.getElementById('toggle'),p=document.getElementById('pwd');
t.onclick=()=>{if(p.type==='password'){p.type='text';t.textContent='🙈';}else{p.type='password';t.textContent='👁';}};
</script>
</body>
</html>