package cn.gamespot.servlet;

import cn.gamespot.dao.GameDao;
import cn.gamespot.connection.DbCon;
import cn.gamespot.model.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/add-game")
public class AddGameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String priceStr = request.getParameter("price");
        String coverImage = request.getParameter("coverImage");
        String description = request.getParameter("description");
        String downloadLink = request.getParameter("downloadLink");

        double price = 0.0;
        try {
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                price = Double.parseDouble(priceStr);
            } else {
                request.setAttribute("errorMessage", "Price cannot be empty.");
                request.getRequestDispatcher("add-game.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid price format.");
            request.getRequestDispatcher("add-game.jsp").forward(request, response);
            return;
        }

        Game game = new Game();
        game.setTitle(title);
        game.setGenre(genre);
        game.setPrice(price);
        game.setCoverImage(coverImage);
        game.setDescription(description);
        game.setDownloadLink(downloadLink);

        try (Connection conn = DbCon.getConnection()) {
            GameDao gameDao = new GameDao(conn);
            gameDao.addGame(game);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to add game.");
            request.getRequestDispatcher("add-game.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("games.jsp");
    }
}
