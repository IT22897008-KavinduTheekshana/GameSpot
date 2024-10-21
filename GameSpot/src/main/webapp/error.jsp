<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>Error - GameSpot</title>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-danger text-center">Error</h1>
        <div class="alert alert-danger text-center">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unknown error occurred." %>
        </div>
        <div class="text-center">
            <a href="index.jsp" class="btn btn-primary">Return to Home</a>
        </div>
    </div>
</body>
</html>
