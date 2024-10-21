package cn.gamespot.servlet;

import java.io.IOException;
import cn.gamespot.connection.DbCon;
import cn.gamespot.dao.UserDao;
import cn.gamespot.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/user-register")
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(name, email, password); // Use plain password

        try (Connection conn = DbCon.getConnection()) {
            UserDao userDao = new UserDao(conn);
            boolean success = userDao.registerUser(user);

            if (success) {
                request.getSession().setAttribute("auth", user);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("registerError", "Registration failed. Email may already be in use.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("registerError", "An error occurred. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
            request.setAttribute("registerError", "Database driver not found.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}