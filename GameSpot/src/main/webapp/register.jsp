<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>Register - GameSpot</title>
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
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Registration</div>
			<div class="card-body">
				<form action="user-register" method="post">
					<div class="form-group">
						<label>Name</label> <input type="text" name="name"
							class="form-control" placeholder="Enter your name" required>
					</div>
					<div class="form-group">
						<label>Email address</label> <input type="email" name="email"
							class="form-control" placeholder="Enter email" required>
					</div>
					<div class="form-group">
						<label>Password</label> <input type="password" name="password"
							class="form-control" placeholder="Password" required>
					</div>
					<button type="submit" class="btn btn-primary btn-block">Register</button>
				</form>
				<div class="text-center mt-2">
					<a href="login.jsp">Already have an account? Login here!</a>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>
