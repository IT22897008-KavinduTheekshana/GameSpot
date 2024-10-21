package cn.gamespot.dao;

import cn.gamespot.model.Library;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserLibraryDao {
    private Connection conn;

    public UserLibraryDao(Connection conn) {
        this.conn = conn;
    }

    // Method to fetch library entries for a user
    public List<Library> getLibraryEntries(int userId) throws SQLException {
        List<Library> libraries = new ArrayList<>();
        String sql = "SELECT * FROM user_library WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Library library = new Library(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("game_id")
                );
                libraries.add(library);
            }
        }
        return libraries;
    }

    // Method to add a game to the user's library
    public void addGameToLibrary(int userId, int gameId) throws SQLException {
        String sql = "INSERT INTO user_library (user_id, game_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, gameId);
            stmt.executeUpdate();
        }
    }

    // Method to remove a game from the user's library
    public void removeGameFromLibrary(int userId, int gameId) throws SQLException {
        String sql = "DELETE FROM user_library WHERE user_id = ? AND game_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, gameId);
            stmt.executeUpdate();
        }
    }
}
