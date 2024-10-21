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

@WebServlet("/edit-game")
public class EditGameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        System.out.println("Received ID parameter: " + idParam); // Debug line
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("games.jsp"); // Redirect if the ID is missing
            return;
        }

        int id = Integer.parseInt(idParam); // Changed from gameId to id
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        
        double price;
        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("games.jsp?error=InvalidPrice"); // Redirect on error
            return;
        }

        String coverImage = request.getParameter("cover_image");
        String description = request.getParameter("description");
        String downloadLink = request.getParameter("download_link");

        System.out.println("Title: " + title);
        System.out.println("Genre: " + genre);
        System.out.println("Price: " + price);
        System.out.println("Cover Image: " + coverImage);
        System.out.println("Description: " + description);
        System.out.println("Download Link: " + downloadLink);

        Game game = new Game(id, title, genre, price, coverImage);
        game.setDescription(description);
        game.setDownloadLink(downloadLink);

        try (Connection conn = DbCon.getConnection()) {
            GameDao gameDao = new GameDao(conn);
            gameDao.updateGame(game); // Ensure this method is implemented
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("games.jsp");  // Redirect to the games list page after editing
    }
}
