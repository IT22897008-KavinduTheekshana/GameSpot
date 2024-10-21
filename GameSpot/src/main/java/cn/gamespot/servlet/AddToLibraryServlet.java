package cn.gamespot.servlet;

import cn.gamespot.dao.UserLibraryDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cn.gamespot.connection.DbCon;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/add-to-library")
public class AddToLibraryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            request.setAttribute("errorMessage", "You must be logged in to add games to your library.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        int gameId = Integer.parseInt(request.getParameter("gameId"));

        try (Connection conn = DbCon.getConnection()) {
            UserLibraryDao userLibraryDao = new UserLibraryDao(conn);
            userLibraryDao.addGameToLibrary(userId, gameId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to add game to library.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return; // Add a return here to ensure no further processing occurs
        }

        response.sendRedirect("library.jsp"); // Redirect back to the library page
    }
}
