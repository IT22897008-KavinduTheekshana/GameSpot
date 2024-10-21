package cn.gamespot.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import cn.gamespot.connection.DbCon;
import cn.gamespot.dao.ReviewDao;
import cn.gamespot.model.Review;
import cn.gamespot.model.User;

@WebServlet("/submit-review")
public class SubmitReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reviewText = request.getParameter("reviewText");
        int gameId = Integer.parseInt(request.getParameter("gameId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth"); // Get user from session
        
        if (user == null) {
            request.setAttribute("errorMessage", "You must be logged in to submit a review.");
            request.getRequestDispatcher("game-details.jsp?gameId=" + gameId).forward(request, response);
            return;
        }

        Review review = new Review();
        review.setUserId(user.getId()); // Set the user ID from the User object
        review.setUserName(user.getName()); // Assuming you have a getName() method in User model
        review.setReviewText(reviewText);
        review.setGameId(gameId);

        try (Connection conn = DbCon.getConnection()) {
            ReviewDao reviewDao = new ReviewDao(conn);
            reviewDao.addReview(review); // Ensure this method exists and correctly inserts the review
            response.sendRedirect("game-details.jsp?gameId=" + gameId); // Redirect to game details after submission
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while submitting your review. Please try again.");
            request.getRequestDispatcher("game-details.jsp?gameId=" + gameId).forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found.");
            request.getRequestDispatcher("game-details.jsp?gameId=" + gameId).forward(request, response);
        }
    }
}
