<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="cn.gamespot.dao.ReviewDao" %>
<%@ page import="cn.gamespot.model.Review" %>
<%@ page import="cn.gamespot.connection.DbCon" %>
<%@ page import="cn.gamespot.model.User" %>

<%
    User user = (User) request.getSession().getAttribute("auth");
    if (user == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not authenticated
        return;
    }

    List<Review> userReviews = new ArrayList<>();
    try (Connection conn = DbCon.getConnection()) {
        ReviewDao reviewDao = new ReviewDao(conn);
        userReviews = reviewDao.getReviewsByUserId(user.getId()); // Fetch reviews by user ID
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - GameSpot</title>
    <%@include file="/includes/head.jsp"%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #343a40; /* Dark theme background */
            color: #fff; /* Light text color */
        }
        .profile-header {
            background-color: #495057; /* Darker header background */
            padding: 20px;
            text-align: center;
            border-radius: 10px;
        }
        .profile-card {
            border-radius: 10px;
            background-color: #495057; /* Darker card background */
            border: 1px solid #6c757d; /* Light border for cards */
        }
        .review-card {
            border-radius: 10px;
            background-color: #495057; /* Darker review card background */
            border: 1px solid #6c757d; /* Light border for review cards */
        }
        .review-text {
            font-size: 1.1em;
            line-height: 1.5;
        }
        .btn-primary {
            background-color: #0d6efd; /* Primary button color */
        }
        .btn-danger {
            background-color: #dc3545; /* Danger button color */
        }
    </style>
</head>
<body>
    <%@include file="/includes/navbar.jsp"%>
    
    <div class="container mt-5">
        <div class="profile-header mb-4">
            <h2><i class="bi bi-person-circle"></i> Welcome, <%= user.getName() %></h2>
        </div>

        <div class="profile-card p-4 mb-5 mx-auto" style="max-width: 600px;">
            <form action="update-name" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" id="name" name="name" class="form-control" value="<%= user.getName() %>" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" class="form-control" value="<%= user.getEmail() %>" readonly>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </div>
            </form>

            <!-- Logout Button -->
            <div class="text-center mt-4">
                <form action="logout" method="post">
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>

    <div class="container reviews-section">
        <h3 class="text-center mb-4">Your Reviews</h3>

        <div class="row">
            <%
            if (!userReviews.isEmpty()) {
                for (Review review : userReviews) {
            %>
                <div class="col-md-6 mb-4">
                    <div class="card review-card p-3">
                        <div class="card-body">
                            <h5 class="card-title">Game ID: <%= review.getGameId() %></h5>
                            <p class="card-text review-text"><%= review.getReviewText() %></p>
                            <div class="review-actions text-end">
                                <a href="edit-review.jsp?reviewId=<%= review.getId() %>" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil"></i> Edit
                                </a>
                                <form action="delete-review" method="post" style="display:inline;">
                                    <input type="hidden" name="reviewId" value="<%= review.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                }
            } else {
            %>
                <p class="text-center">You haven't written any reviews yet.</p>
            <%
            }
            %>
        </div>
    </div>

    <%@include file="/includes/footer.jsp"%>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
