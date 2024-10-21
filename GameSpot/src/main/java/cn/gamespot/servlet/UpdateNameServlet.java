package cn.gamespot.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import cn.gamespot.connection.DbCon;
import cn.gamespot.dao.UserDao;
import cn.gamespot.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-name")
public class UpdateNameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not authenticated
            return;
        }

        String newName = request.getParameter("name");

        // Perform validation on the new name (e.g., non-empty, valid length)
        if (newName == null || newName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name cannot be empty.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        user.setName(newName); // Update the user's name in the session

        try (Connection conn = DbCon.getConnection()) {
            UserDao userDao = new UserDao(conn);
            boolean success = userDao.updateUserName(user); // Update name in the database

            if (success) {
                session.setAttribute("auth", user); // Update session with new name
                response.sendRedirect("profile.jsp"); // Redirect to profile page
            } else {
                request.setAttribute("errorMessage", "Failed to update the name. Please try again.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the name.");
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }
}
