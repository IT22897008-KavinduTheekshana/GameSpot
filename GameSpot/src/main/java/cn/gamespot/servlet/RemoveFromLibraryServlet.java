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

@WebServlet("/remove-from-library")
public class RemoveFromLibraryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            // User is not logged in
            request.setAttribute("errorMessage", "You must be logged in to remove games from your library.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        int gameId = Integer.parseInt(request.getParameter("gameId"));

        try (Connection conn = DbCon.getConnection()) {
            UserLibraryDao userLibraryDao = new UserLibraryDao(conn);
            userLibraryDao.removeGameFromLibrary(userId, gameId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to remove game from library.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("library.jsp"); // Redirect back to the library page
    }
}
