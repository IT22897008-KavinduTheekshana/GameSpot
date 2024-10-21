package cn.gamespot.servlet;

import cn.gamespot.dao.GameDao;
import cn.gamespot.connection.DbCon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/remove-game")
public class RemoveGameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int gameId = Integer.parseInt(request.getParameter("gameId"));

        try (Connection conn = DbCon.getConnection()) {
            GameDao gameDao = new GameDao(conn);
            gameDao.removeGameById(gameId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to remove game.");
            request.getRequestDispatcher("games.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("games.jsp");
    }
}
