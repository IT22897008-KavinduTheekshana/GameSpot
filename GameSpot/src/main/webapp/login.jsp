<%@page import="cn.gamespot.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	response.sendRedirect("index.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/includes/head.jsp"%>
<title>Login - GameSpot</title>
<style>
body {
	background-color: #121212; /* Dark background */
	color: #ffffff; /* Light text color */
}

.card {
	background-color: #1e1e1e; /* Dark card background */
	border: none; /* Remove card border */
}

.btn-primary {
	background-color: #6200ea; /* Custom button color */
	border: none; /* Remove border */
}

.btn-primary:hover {
	background-color: #3700b3; /* Darker shade on hover */
}
</style>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="card w-50 mx-auto my-5 shadow-sm">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<%
				String loginError = (String) request.getAttribute("loginError");
				if (loginError != null) {
				%>
				<div class="alert alert-danger text-center"><%=loginError%></div>
				<%
				}
				%>

				<form action="user-login" method="post">
					<div class="form-group">
						<label>Email address</label> <input type="email"
							name="login-email" class="form-control" placeholder="Enter email"
							required>
					</div>
					<div class="form-group">
						<label>Password</label> <input type="password"
							name="login-password" class="form-control" placeholder="Password"
							required>
					</div>
					<button type="submit" class="btn btn-primary btn-block">Login</button>
				</form>
				<div class="text-center mt-2">
					<a href="register.jsp" class="text-light">Don't have an
						account? Register here!</a>
				</div>
				<div class="text-center mt-2">
					<a href="reset-password.jsp" class="text-light">Forgot your password? Reset here!</a>

				</div>
			</div>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>
