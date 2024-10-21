<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/includes/head.jsp"%>
<title>Reset Password - GameSpot</title>
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
            <div class="card-header text-center">Reset Password</div>
            <div class="card-body">
                <%
                String resetError = (String) request.getAttribute("resetError");
                String resetSuccess = (String) request.getAttribute("resetSuccess");
                if (resetError != null) {
                %>
                <div class="alert alert-danger text-center"><%=resetError%></div>
                <%
                }
                if (resetSuccess != null) {
                %>
                <div class="alert alert-success text-center"><%=resetSuccess%></div>
                <%
                }
                %>

                <form action="reset-password" method="post">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="current-password" class="form-control" placeholder="Enter current password" required>
                    </div>
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" name="new-password" class="form-control" placeholder="Enter new password" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
                </form>
            </div>
        </div>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
