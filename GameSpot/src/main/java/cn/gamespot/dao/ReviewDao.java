package cn.gamespot.dao;

import java.sql.*;
import java.util.*;
import cn.gamespot.model.Review;

public class ReviewDao {
    private Connection con;

    public ReviewDao(Connection con) {
        this.con = con;
    }
    
    // Fetch review by review ID
    public Review getReviewById(int reviewId) throws SQLException {
        Review review = null;
        String query = "SELECT * FROM reviews WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, reviewId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                review = new Review(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("user_name"),
                    rs.getString("review_text"),
                    rs.getInt("game_id")
                );
            }
        }
        return review;
    }

    // Fetch reviews by user ID
    public List<Review> getReviewsByUserId(int userId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE user_id = ?"; // Ensure 'user_id' is correct

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review(
                    rs.getInt("id"),
                    rs.getInt("user_id"), // Fetch user_id from the database
                    rs.getString("user_name"),
                    rs.getString("review_text"),
                    rs.getInt("game_id")
                );
                reviews.add(review);
            }
        }
        return reviews;
    }

    public List<Review> getReviewsByGameId(int gameId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE game_id = ?"; // Ensure 'game_id' is correct

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, gameId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review(
                    rs.getInt("id"),
                    rs.getInt("user_id"), // Fetch user_id from the database
                    rs.getString("user_name"),
                    rs.getString("review_text"),
                    rs.getInt("game_id")
                );
                reviews.add(review);
            }
        }
        return reviews;
    }
    
    

    public void addReview(Review review) throws SQLException {
        String query = "INSERT INTO reviews (user_id, user_name, review_text, game_id) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, review.getUserId()); // Set user_id
            ps.setString(2, review.getUserName());
            ps.setString(3, review.getReviewText());
            ps.setInt(4, review.getGameId());
            ps.executeUpdate(); // Execute the insert
        }
    }

    public void updateReviewText(int reviewId, String updatedText) throws SQLException {
        String query = "UPDATE reviews SET review_text = ? WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, updatedText);
            ps.setInt(2, reviewId);
            ps.executeUpdate();
        }
    }

    public void deleteReview(int reviewId) throws SQLException {
        String query = "DELETE FROM reviews WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, reviewId);
            ps.executeUpdate();
        }
    }
}
