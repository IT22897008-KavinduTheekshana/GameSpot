<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.gamespot.model.Review"%>
<%@ page import="cn.gamespot.dao.ReviewDao"%>
<%@ page import="cn.gamespot.connection.DbCon"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%
    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    Review review = null;

    try (Connection conn = DbCon.getConnection()) {
        ReviewDao reviewDao = new ReviewDao(conn);
        review = reviewDao.getReviewById(reviewId); // Implement this method in ReviewDao
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }

    if (review == null) {
        response.sendRedirect("profile.jsp"); // Redirect if review not found
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Review - GameSpot</title>
    <%@include file="/includes/head.jsp"%>
</head>
<body>
    <%@include file="/includes/navbar.jsp"%>
    <div class="container my-5">
        <h2>Edit Review</h2>
        <form action="update-review" method="post">
            <input type="hidden" name="reviewId" value="<%= review.getId() %>">
            <div class="form-group">
                <label for="reviewText">Review Text</label>
                <textarea class="form-control" id="reviewText" name="reviewText" required><%= review.getReviewText() %></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Update Review</button>
        </form>
        <a href="profile.jsp" class="btn btn-secondary mt-3">Cancel</a>
    </div>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>
