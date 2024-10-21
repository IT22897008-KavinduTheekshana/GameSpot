package cn.gamespot.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.gamespot.model.User;

public class UserDao {
	private Connection connection;

	public UserDao(Connection connection) {
		this.connection = connection;
	}

	// Method to authenticate the user
	public User userLogin(String email, String password) throws SQLException {
		String query = "SELECT * FROM users WHERE email = ?";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				String storedPassword = rs.getString("password");
				if (storedPassword.equals(password)) { // Use hashed password comparison in production
					return new User(rs.getInt("id"), rs.getString("name"), email, password);
				}
			}
		}
		return null; // No user found
	}

	public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users"; // Ensure 'users' table exists

        try (PreparedStatement pst = this.connection.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Be cautious about displaying passwords
                users.add(user);
            }
        }

        return users;
    }

	// Method to register a new user
	public boolean registerUser(User user) throws SQLException {
		// First, check if the email already exists
		String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
		try (PreparedStatement checkEmailStmt = connection.prepareStatement(checkEmailQuery)) {
			checkEmailStmt.setString(1, user.getEmail());
			ResultSet rs = checkEmailStmt.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				return false; // Email already exists
			}
		}

		// Proceed to insert the new user if the email is unique
		String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword()); // Capturing plain password
			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0; // Return true if registration is successful
		}
	}

	// Method to update the user's name
	public boolean updateUserName(User user) throws SQLException {
		String query = "UPDATE users SET name = ? WHERE id = ?";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			pstmt.setString(1, user.getName());
			pstmt.setInt(2, user.getId());
			return pstmt.executeUpdate() > 0; // Return true if the update was successful
		}
	}
	
	public void removeUserById(int userId) throws SQLException {
	    String sql = "DELETE FROM users WHERE id = ?";
	    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
	        stmt.setInt(1, userId);
	        stmt.executeUpdate();
	    }
	}
	
	public User findUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"), rs.getString("password"));
            }
        }
        return null;
    }

	 // Method to reset password
	public boolean resetPassword(int userId, String currentPassword, String newPassword) throws SQLException {
	    String query = "SELECT * FROM users WHERE id = ? AND password = ?";
	    try (PreparedStatement pst = connection.prepareStatement(query)) {
	        pst.setInt(1, userId);
	        pst.setString(2, currentPassword); // Assuming the password is stored in plain text (not recommended for production)

	        ResultSet rs = pst.executeQuery();
	        if (rs.next()) {
	            // Current password is correct, update to new password
	            String updateQuery = "UPDATE users SET password = ? WHERE id = ?";
	            try (PreparedStatement updatePst = connection.prepareStatement(updateQuery)) {
	                updatePst.setString(1, newPassword); // Update with the new password
	                updatePst.setInt(2, userId);
	                updatePst.executeUpdate();
	                return true; // Password reset successful
	            }
	        }
	    }
	    return false; // Current password is incorrect
	}



}
