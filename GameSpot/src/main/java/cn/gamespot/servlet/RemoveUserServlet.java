package cn.gamespot.servlet;

import cn.gamespot.dao.UserDao;
import cn.gamespot.connection.DbCon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/remove-user")
public class RemoveUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        try (Connection conn = DbCon.getConnection()) {
            UserDao userDao = new UserDao(conn);
            userDao.removeUserById(userId); // Implement this method in UserDao
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to remove user.");
            request.getRequestDispatcher("admin-users.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("admin-users.jsp"); // Redirect back to the admin users page
    }
}
