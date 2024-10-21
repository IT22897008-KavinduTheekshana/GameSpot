package cn.gamespot.servlet;

import cn.gamespot.dao.UserDao;
import cn.gamespot.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cn.gamespot.connection.DbCon;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("current-password");
        String newPassword = request.getParameter("new-password");

        UserDao userDao = null;
        try {
            userDao = new UserDao(DbCon.getConnection());
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("resetError", "Database error.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        try {
            // Attempt to find the user and validate the current password
            User user = userDao.findUserByEmail(email);
            if (user != null && user.getPassword().equals(currentPassword)) {
                boolean success = userDao.resetPassword(user.getId(), currentPassword, newPassword);
                if (success) {
                    request.setAttribute("resetSuccess", "Password reset successful.");
                    request.getRequestDispatcher("login.jsp").forward(request, response); // Redirect to login page
                } else {
                    request.setAttribute("resetError", "An error occurred while resetting the password.");
                    request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("resetError", "Incorrect email or current password.");
                request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("resetError", "An error occurred while resetting the password.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}
