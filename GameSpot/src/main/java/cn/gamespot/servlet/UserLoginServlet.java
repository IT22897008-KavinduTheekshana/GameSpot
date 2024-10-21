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

@WebServlet("/user-login")
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("login-email");
        String password = request.getParameter("login-password");

        UserDao userDao = null;
        try {
            userDao = new UserDao(DbCon.getConnection());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("loginError", "Database connection error.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("loginError", "Database driver not found.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Authenticate the user
            User user = userDao.userLogin(email, password);
            if (user != null) {
                // Successful login, set the user in session
                request.getSession().setAttribute("auth", user);
                request.getSession().setAttribute("userId", user.getId()); // Set userId for library operations
                response.sendRedirect("index.jsp"); // Redirect to home page
            } else {
                // Login failed
                request.setAttribute("loginError", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response); // Forward back to login page
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("loginError", "An error occurred while logging in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
