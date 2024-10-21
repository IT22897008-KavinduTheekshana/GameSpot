package cn.gamespot.dao;

import java.sql.*;
import java.util.*;
import cn.gamespot.model.Game;

public class GameDao {
    private Connection con;

    public GameDao(Connection con) {
        this.con = con;
    }

    public List<Game> getAllGames() {
        List<Game> games = new ArrayList<>();
        String query = "SELECT * FROM games";

        try (PreparedStatement pst = this.con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Game game = new Game();
                game.setId(rs.getInt("id"));
                game.setTitle(rs.getString("title"));
                game.setGenre(rs.getString("genre"));
                game.setPrice(rs.getDouble("price"));
                game.setCoverImage(rs.getString("cover_image"));
                game.setDescription(rs.getString("description"));
                game.setDownloadLink(rs.getString("download_link"));
                games.add(game);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return games;
    }
    
    public Game getGameById(int id) {
        Game game = null;
        String query = "SELECT * FROM games WHERE id = ?";

        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                game = new Game();
                game.setId(rs.getInt("id"));
                game.setTitle(rs.getString("title"));
                game.setGenre(rs.getString("genre"));
                game.setPrice(rs.getDouble("price"));
                game.setCoverImage(rs.getString("cover_image"));
                game.setDescription(rs.getString("description"));
                game.setDownloadLink(rs.getString("download_link"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return game;
    }

    public void addGame(Game game) throws SQLException {
        String sql = "INSERT INTO games (title, genre, price, cover_image, description, download_link) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, game.getTitle());
            stmt.setString(2, game.getGenre());
            stmt.setDouble(3, game.getPrice());
            stmt.setString(4, game.getCoverImage());
            stmt.setString(5, game.getDescription());
            stmt.setString(6, game.getDownloadLink());
            stmt.executeUpdate();
        }
    }

    public void updateGame(Game game) throws SQLException {
        String sql = "UPDATE games SET title = ?, genre = ?, price = ?, cover_image = ?, description = ?, download_link = ? WHERE id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, game.getTitle());
            stmt.setString(2, game.getGenre());
            stmt.setDouble(3, game.getPrice());
            stmt.setString(4, game.getCoverImage());
            stmt.setString(5, game.getDescription());
            stmt.setString(6, game.getDownloadLink());
            stmt.setInt(7, game.getId());
            stmt.executeUpdate();
        }
    }


    public void removeGameById(int gameId) throws SQLException {
        String sql = "DELETE FROM games WHERE id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, gameId);
            stmt.executeUpdate();
        }
    }
}
