package cn.gamespot.servlet;

import cn.gamespot.dao.ReviewDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cn.gamespot.connection.DbCon;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/delete-review")
public class DeleteReviewServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		try (Connection con = DbCon.getConnection()) {
			ReviewDao reviewDao = new ReviewDao(con);
			reviewDao.deleteReview(reviewId); // Create this method in ReviewDao
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		response.sendRedirect("profile.jsp"); // Redirect back to profile
	}
}
