package cn.gamespot.servlet;

import cn.gamespot.dao.ReviewDao;
import cn.gamespot.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cn.gamespot.connection.DbCon;


import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/update-review")
public class UpdateReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        String updatedText = request.getParameter("reviewText");

        try (Connection con = DbCon.getConnection()) {
            ReviewDao reviewDao = new ReviewDao(con);
            reviewDao.updateReviewText(reviewId, updatedText); // Create this method in ReviewDao
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        response.sendRedirect("profile.jsp"); // Redirect back to profile
    }
}
